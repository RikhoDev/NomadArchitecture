# Markdown: neutral mechanism for reading this repository's documents.
# It knows Markdown and the status-header format; it knows nothing about what
# canon, lineage or placement mean.

function Read-StatusHeader([string]$Path) {
    # The YAML-like header between the first two '---' lines, as a hashtable,
    # or $null when the file has none. List values are comma-separated.
    $lines = @(Get-Content -LiteralPath $Path)
    if ($lines.Count -lt 2 -or $lines[0] -ne '---') { return $null }
    $end = [Array]::IndexOf($lines, '---', 1)
    if ($end -lt 0) { return $null }
    $fields = [ordered]@{}
    foreach ($line in $lines[1..($end - 1)]) {
        if ($line -match '^(\w+):\s*(.*?)\s*(#.*)?$') { $fields[$Matches[1]] = $Matches[2] }
    }
    return $fields
}

function Get-MarkdownLines([string]$Path) {
    # Lines outside code fences, with inline code removed.
    $inFence = $false
    foreach ($line in Get-Content -LiteralPath $Path) {
        if ($line -match '^\s*```') { $inFence = -not $inFence; continue }
        if (-not $inFence) { $line -replace '`[^`]*`', '' }
    }
}

function Get-MarkdownLinks([string]$Path) {
    # Relative links as objects: Target (a path, or empty for the same file)
    # and Anchor. Web and mail links are left out.
    foreach ($line in Get-MarkdownLines $Path) {
        foreach ($m in [regex]::Matches($line, '\]\(([^)\s]+)\)')) {
            $url = $m.Groups[1].Value
            if ($url -match '^(https?|mailto):') { continue }
            $target, $anchor = $url -split '#', 2
            [pscustomobject]@{ Target = $target; Anchor = $anchor }
        }
    }
}

function ConvertTo-Slug([string]$Heading) {
    # The anchor GitHub derives from a heading.
    (($Heading -replace '`', '').ToLowerInvariant() -replace '[^\p{L}\p{Nd}\s_-]', '') -replace '\s', '-'
}

function Get-MarkdownSlugs([string]$Path) {
    $slugs = [System.Collections.Generic.HashSet[string]]::new()
    foreach ($line in Get-MarkdownLines $Path) {
        if ($line -match '^#{1,6}\s+(.*)$') { [void]$slugs.Add((ConvertTo-Slug $Matches[1])) }
    }
    return , $slugs
}

function Get-MarkdownSection([string]$Path, [string]$Heading) {
    # The text under a heading, up to the next heading of the same or a higher
    # level, as one string; $null when the heading is absent.
    $lines = @(Get-Content -LiteralPath $Path)
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '^(#{1,6})\s+(.*)$' -and $Matches[2].Trim() -eq $Heading) {
            $level = $Matches[1].Length
            $body = for ($j = $i + 1; $j -lt $lines.Count; $j++) {
                if ($lines[$j] -match '^(#{1,6})\s' -and $Matches[1].Length -le $level) { break }
                $lines[$j]
            }
            return (($body -join "`n").Trim())
        }
    }
    return $null
}

function Get-MarkdownLead([string]$Path) {
    # The sentence a reader meets first: a paragraph starting "**Promise.**"
    # if there is one, otherwise the first paragraph after the title.
    $lines = @(Get-MarkdownLines $Path)
    $start = 0
    if ($lines.Count -gt 0 -and $lines[0] -eq '---') { $start = [Array]::IndexOf($lines, '---', 1) + 1 }
    $paragraphs = [System.Collections.Generic.List[string]]::new()
    $current = [System.Collections.Generic.List[string]]::new()
    foreach ($line in $lines[$start..($lines.Count - 1)] + '') {
        if ($line.Trim() -eq '' -or $line -match '^#') {
            if ($current.Count) { $paragraphs.Add(($current -join ' ')); $current.Clear() }
        } elseif ($line -notmatch '^\s*([>|]|-{3,})') {
            $current.Add($line.Trim())
        }
    }
    $promise = $paragraphs | Where-Object { $_ -like '**Promise.**' + '*' } | Select-Object -First 1
    if ($promise) { return ($promise -replace '^\*\*Promise\.\*\*\s*', '') }
    return ($paragraphs | Select-Object -First 1)
}
