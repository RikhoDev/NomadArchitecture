# Checks that the repository tells the truth about itself:
#   1. every Markdown file except the root README carries a valid status header;
#   2. every relative link and #anchor resolves;
#   3. the canon is the same in all three places that name it: the files'
#      own status headers, the list in __Docs/README.md, and
#      .nomad-method/canon;
#   4. every proof (*.Tests.ps1) passes;
#   every awaiting_reading section named in a canon file exists; and
#   Chronicles and Mirages are named YYMM-xx-Name-Chronicle.md or
#   YYMM-xx-Name-Mirage.md and dated to agree; and every Trail lives in a
#   _Trails folder and names its document in trail_of.
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

# 2a. Chronicles and Mirages follow the folder grammar: YYMM-xx-Name.md, an
#     index local to each folder, and a date header that agrees with the name
$seen = @{}
foreach ($rel in $headers.Keys) {
    $segments = $rel -split '/'
    if (-not ($segments | Where-Object { $_ -in '_Chronicles', '_Mirages' })) { continue }
    $leaf = $segments[-1]
    if ($leaf -eq 'README.md' -or $leaf -match '\.Trail\.\d{8}\.md$') { continue }
    $suffix = if ($segments -contains '_Chronicles') { 'Chronicle' } else { 'Mirage' }
    if ($leaf -notmatch "^(\d{2})(\d{2})-(\d{2})-[^.]+-$suffix\.md$") { Report "$rel is not named YYMM-xx-Name-$suffix.md"; continue }
    $yymm = "$($Matches[1])-$($Matches[2])"; $index = "$($Matches[1])$($Matches[2])-$($Matches[3])"
    $date = $headers[$rel]['date']
    if (-not $date) { Report "$rel has no date header" }
    elseif ($date -notmatch '^20(\d{2})-(\d{2})(-\d{2})?$' -or "$($Matches[1])-$($Matches[2])" -ne $yymm) { Report "$rel is dated '$date', which disagrees with its name" }
    $key = (($segments[0..($segments.Count - 2)]) -join '/') + "/$index"
    if ($seen.ContainsKey($key)) { Report "$rel reuses index $index of $($seen[$key])" } else { $seen[$key] = $rel }
}

# 2c. Trails live in a _Trails folder and name their document in trail_of
foreach ($rel in $headers.Keys) {
    $isTrail = $headers[$rel]['kind'] -eq 'trail'
    $trailOf = $headers[$rel]['trail_of']
    if ($trailOf -and -not $isTrail) { Report "$rel has trail_of but is not a trail" }
    if (-not $isTrail) { continue }
    if (-not (($rel -split '/') -contains '_Trails')) { Report "$rel is a trail outside a _Trails folder" }
    if ((Split-Path $rel -Leaf) -notmatch '^[^.]+\.Trail\.\d{8}\.md$') { Report "$rel is not named <Owner>.Trail.<YYYYMMDD>.md" }
    if (-not $trailOf) { Report "$rel is a trail without trail_of" }
    elseif (-not (Test-Path (Join-Path (Split-Path (Join-Path $root $rel) -Parent) $trailOf) -PathType Leaf)) { Report "$rel trail_of '$trailOf' does not exist" }
}

# 2b. Sections awaiting the human's reading exist, and only on canon files
foreach ($rel in $headers.Keys) {
    $awaiting = $headers[$rel]['awaiting_reading']
    if (-not $awaiting) { continue }
    if ($headers[$rel]['status'] -ne 'canon') { Report "$rel lists awaiting_reading but is not canon" }
    $slugs = Get-Slugs (Join-Path $root $rel)
    foreach ($anchor in $awaiting -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ }) {
        if (-not $slugs.ContainsKey($anchor)) { Report "$rel awaits reading of '#$anchor', which is not a section of it" }
    }
}

# 3. The canon agrees with itself
$byHeader = @($headers.Keys | Where-Object { $headers[$_]['status'] -eq 'canon' } | Sort-Object)
$listFile = Join-Path $root '.nomad-method/canon'
$docsReadmePath = Join-Path $root '__Docs/README.md'
if (-not (Test-Path -LiteralPath $listFile)) { Report '.nomad-method/canon is missing: there is no canon list' }
if (-not (Test-Path -LiteralPath $docsReadmePath)) { Report '__Docs/README.md is missing: there is no canon index' }
$byPlugin = @(if (Test-Path -LiteralPath $listFile) { Get-Content -LiteralPath $listFile | Where-Object { $_ -and $_ -notmatch '^\s*#' } | ForEach-Object { $_.Trim() } })
$docsReadme = if (Test-Path -LiteralPath $docsReadmePath) { Get-Content -LiteralPath $docsReadmePath -Raw } else { '' }
$section = [regex]::Match($docsReadme, '(?ms)^## Canon\s*$(.*?)^## ').Groups[1].Value
$byReadme = @([regex]::Matches($section, '(?m)^- \[[^\]]*\]\(([^)#\s]+)') | ForEach-Object {
    Rel ([IO.Path]::GetFullPath((Join-Path (Join-Path $root '__Docs') $_.Groups[1].Value)))
})
if (Test-Path -LiteralPath $docsReadmePath) { $byReadme += '__Docs/README.md' }
foreach ($file in $byHeader) {
    if ($file -notin $byPlugin) { Report "$file is canon but missing from .nomad-method/canon" }
    if ($file -notin $byReadme) { Report "$file is canon but not listed in __Docs/README.md#canon" }
}
foreach ($file in $byReadme | Sort-Object -Unique) {
    if (-not $headers.ContainsKey($file)) { Report "__Docs/README.md lists $file as canon, but it does not exist"; continue }
    if ($headers[$file]['status'] -ne 'canon') { Report "__Docs/README.md lists $file as canon, but its header says '$($headers[$file]['status'])'" }
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
