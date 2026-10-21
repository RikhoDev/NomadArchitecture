# Checks that the repository tells the truth about itself:
#   1. every Markdown file except the root README carries a valid status header;
#   2. every relative link and #anchor resolves;
#   3. the canon is the same in all three places that name it: the files'
#      own status headers, the list in __Docs__/README.md, and
#      .nomad-method/canon;
#   4. every proof (*.Tests.ps1) passes.
# Usage: pwsh Scripts/Test-Repository.ps1    Exit code 0 means all checks pass.

$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$problems = [System.Collections.Generic.List[string]]::new()
function Report([string]$Message) { $problems.Add($Message) }
function Rel([string]$Path) { [IO.Path]::GetRelativePath($root, $Path).Replace('\', '/') }

$markdown = Get-ChildItem -Path $root -Recurse -File -Filter *.md |
    Where-Object { (Rel $_.FullName) -notmatch '^\.git/' }

# 1. Status headers
$allowed = @{
    status = 'canon', 'proposed', 'non-canon', 'superseded'
    kind   = 'doctrine', 'guide', 'mirage', 'trail', 'chronicle'
    origin = 'human', 'ai', 'ai-assisted'
}
$headers = @{}
foreach ($file in $markdown) {
    $rel = Rel $file.FullName
    if ($rel -eq 'README.md') { continue }
    $lines = Get-Content -LiteralPath $file.FullName
    if ($lines.Count -lt 2 -or $lines[0] -ne '---') { Report "$rel has no status header"; continue }
    $end = [Array]::IndexOf($lines, '---', 1)
    if ($end -lt 0) { Report "$rel has an unterminated status header"; continue }
    $fields = @{}
    foreach ($line in $lines[1..($end - 1)]) {
        if ($line -match '^(\w+):\s*(.+?)\s*$') { $fields[$Matches[1]] = $Matches[2] }
    }
    foreach ($key in $allowed.Keys) {
        if (-not $fields.ContainsKey($key)) { Report "$rel header lacks '$key'" }
        elseif ($fields[$key] -notin $allowed[$key]) { Report "$rel header has $key '$($fields[$key])'" }
    }
    if ($fields['status'] -eq 'superseded') {
        $target = ($fields['superseded_by'] -split '#')[0]
        if (-not $target) { Report "$rel is superseded but names no replacement" }
        elseif (-not (Test-Path (Join-Path $file.DirectoryName $target))) { Report "$rel superseded_by '$target' does not exist" }
    }
    $headers[$rel] = $fields
}

# 2. Links and anchors (outside code fences and inline code)
function Get-Slugs([string]$Path) {
    $slugs = @{}
    $inFence = $false
    foreach ($line in Get-Content -LiteralPath $Path) {
        if ($line -match '^\s*```') { $inFence = -not $inFence; continue }
        if ($inFence -or $line -notmatch '^#{1,6}\s+(.*)$') { continue }
        $text = $Matches[1] -replace '`', ''
        $slug = (($text.ToLowerInvariant() -replace '[^\p{L}\p{Nd}\s_-]', '') -replace '\s', '-')
        $slugs[$slug] = $true
    }
    $slugs
}
$slugCache = @{}
foreach ($file in $markdown) {
    $rel = Rel $file.FullName
    $inFence = $false
    foreach ($line in Get-Content -LiteralPath $file.FullName) {
        if ($line -match '^\s*```') { $inFence = -not $inFence; continue }
        if ($inFence) { continue }
        $plain = $line -replace '`[^`]*`', ''
        foreach ($m in [regex]::Matches($plain, '\]\(([^)\s]+)\)')) {
            $url = $m.Groups[1].Value
            if ($url -match '^(https?|mailto):') { continue }
            $path, $anchor = $url -split '#', 2
            $target = if ($path) { [IO.Path]::GetFullPath((Join-Path $file.DirectoryName $path)) } else { $file.FullName }
            if (-not (Test-Path -LiteralPath $target)) { Report "$rel links to missing '$url'"; continue }
            if ($anchor -and (Test-Path -LiteralPath $target -PathType Leaf)) {
                if (-not $slugCache.ContainsKey($target)) { $slugCache[$target] = Get-Slugs $target }
                if (-not $slugCache[$target].ContainsKey($anchor)) { Report "$rel links to missing anchor '$url'" }
            }
        }
    }
}

# 3. The canon agrees with itself
$byHeader = @($headers.Keys | Where-Object { $headers[$_]['status'] -eq 'canon' } | Sort-Object)
$listFile = Join-Path $root '.nomad-method/canon'
$byPlugin = @(Get-Content -LiteralPath $listFile | Where-Object { $_ -and $_ -notmatch '^\s*#' } | ForEach-Object { $_.Trim() })
$docsReadme = Get-Content -LiteralPath (Join-Path $root '__Docs__/README.md') -Raw
$section = [regex]::Match($docsReadme, '(?ms)^## Canon\s*$(.*?)^## ').Groups[1].Value
$byReadme = @([regex]::Matches($section, '(?m)^- \[[^\]]*\]\(([^)#\s]+)') | ForEach-Object {
    Rel ([IO.Path]::GetFullPath((Join-Path (Join-Path $root '__Docs__') $_.Groups[1].Value)))
})
$byReadme += '__Docs__/README.md'
foreach ($file in $byHeader) {
    if ($file -notin $byPlugin) { Report "$file is canon but missing from .nomad-method/canon" }
    if ($file -notin $byReadme) { Report "$file is canon but not listed in __Docs__/README.md#canon" }
}
foreach ($file in $byReadme | Sort-Object -Unique) {
    if (-not $headers.ContainsKey($file)) { Report "__Docs__/README.md lists $file as canon, but it does not exist"; continue }
    if ($headers[$file]['status'] -ne 'canon') { Report "__Docs__/README.md lists $file as canon, but its header says '$($headers[$file]['status'])'" }
}
foreach ($file in $byPlugin) {
    if (-not (Test-Path (Join-Path $root $file))) { Report ".nomad-method/canon lists missing file $file" }
}

# 4. Proofs
foreach ($proof in Get-ChildItem -Path $root -Recurse -File -Filter *.Tests.ps1) {
    Write-Host "proof: $(Rel $proof.FullName)"
    & (Get-Process -Id $PID).Path -NoProfile -File $proof.FullName
    if ($LASTEXITCODE -ne 0) { Report "proof failed: $(Rel $proof.FullName)" }
}

if ($problems.Count -gt 0) {
    Write-Host ''
    $problems | ForEach-Object { Write-Host "FAIL $_" }
    Write-Host "$($problems.Count) problem(s)."
    exit 1
}
Write-Host "Repository check passed: $($markdown.Count) Markdown files, $($byHeader.Count) canon files."
