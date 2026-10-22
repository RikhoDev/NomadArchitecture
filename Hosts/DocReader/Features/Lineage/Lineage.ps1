# Lineage: show where a document came from and what became of it: what it
# replaced, what replaced it, and the Trails that hold its conversation.
# A Trail is found by its trail_of header, not by where it sits.
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

    # A Trail names its document in a trail_of header, so it can live in any
    # _Trails folder. Trails are listed oldest first, by the date in their name.
    $own = & $ReadHeader (Join-Path $Root $Path)
    $trailOf = if ($own -and $own['trail_of']) { Resolve-RepoPath $Root $Path $own['trail_of'] } else { $null }
    $trails = foreach ($doc in $documents) {
        $header = & $ReadHeader (Join-Path $Root $doc)
        if ($header -and $header['trail_of'] -and (Resolve-RepoPath $Root $doc $header['trail_of']) -eq $Path) { $doc }
    }
    $trails = $trails | Sort-Object { if ($_ -match '\.Trail\.(\d{8})\.md$') { $Matches[1] } else { '' } }, { $_ }

    [pscustomobject]@{
        Path       = $Path
        ReplacedBy = @($replacedBy)
        Replaces   = @($replaces | Sort-Object)
        Trails     = @($trails)
        TrailOf    = $trailOf
    }
}
