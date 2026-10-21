# Lineage: show where a document came from and what became of it: what it
# replaced, what replaced it, and the Trails that hold its conversation.
#
# Needs (given by the Host):
#   ReadHeader      a function from a file path to its status header or $null;
#   ListDocuments   a function returning every Markdown path, relative to Root.

function Resolve-RepoPath([string]$Root, [string]$From, [string]$Relative) {
    $target = ($Relative -split '#', 2)[0]
    $full = [IO.Path]::GetFullPath((Join-Path (Join-Path $Root (Split-Path $From -Parent)) $target))
    [IO.Path]::GetRelativePath($Root, $full).Replace('\', '/')
}

function Get-Lineage {
    param(
        [Parameter(Mandatory)][string]$Root,
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][scriptblock]$ReadHeader,
        [Parameter(Mandatory)][scriptblock]$ListDocuments
    )
    $Path = $Path.Replace('\', '/')
    $documents = @(& $ListDocuments)

    $replacedBy = [System.Collections.Generic.List[string]]::new()
    $current = $Path
    while ($true) {
        $header = & $ReadHeader (Join-Path $Root $current)
        if (-not $header -or -not $header['superseded_by']) { break }
        $next = Resolve-RepoPath $Root $current $header['superseded_by']
        if ($replacedBy.Contains($next) -or $next -eq $Path) { break }
        $replacedBy.Add($next)
        $current = $next
    }

    $replaces = foreach ($doc in $documents) {
        $header = & $ReadHeader (Join-Path $Root $doc)
        if ($header -and $header['superseded_by'] -and (Resolve-RepoPath $Root $doc $header['superseded_by']) -eq $Path) { $doc }
    }

    $folder = Split-Path $Path -Parent
    $stem = [IO.Path]::GetFileNameWithoutExtension($Path)
    $trailOf = $null
    if ($stem -match '^(.*)\.Trail\.\d{8}$') { $trailOf = (Join-Path $folder "$($Matches[1]).md").Replace('\', '/').TrimStart('/') }
    $trails = $documents | Where-Object {
        (Split-Path $_ -Parent) -eq $folder -and (Split-Path $_ -Leaf) -match ('^' + [regex]::Escape($stem) + '\.Trail\.\d{8}\.md$')
    } | Sort-Object

    [pscustomobject]@{
        Path       = $Path
        ReplacedBy = @($replacedBy)
        Replaces   = @($replaces | Sort-Object)
        Trails     = @($trails)
        TrailOf    = $trailOf
    }
}
