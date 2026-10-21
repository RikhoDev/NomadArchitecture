# Placement: for any path in the repository, answer "whose meaning is this?":
# which pillars it sits inside, which world it belongs to, and the nearest
# README that owns it.
#
# Needs (given by the Host): ReadLead, a function from a README path to the
# sentence that states its promise.

$script:PillarRoles = [ordered]@{ Hosts = 'WHY'; Features = 'WHAT'; Foundations = 'HOW'; Core = 'COMMON' }
$script:Worlds = @{
    '__Docs'      = 'memory: the documentation pillar'
    'Scripts'       = 'repository world: scaffolding that checks the system, not part of it'
    '.github'       = 'repository world: scaffolding that checks the system, not part of it'
    '.nomad-method' = 'repository world: configuration for the nomad-method plugin'
}

function Get-Placement {
    param(
        [Parameter(Mandatory)][string]$Root,
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][scriptblock]$ReadLead
    )
    $Path = $Path.Replace('\', '/').Trim('/')
    $full = Join-Path $Root $Path
    $isDirectory = Test-Path -LiteralPath $full -PathType Container
    $segments = @($Path -split '/' | Where-Object { $_ })

    $nesting = for ($i = 0; $i -lt $segments.Count - 1; $i++) {
        if ($script:PillarRoles.Contains($segments[$i])) {
            [pscustomobject]@{ Pillar = $segments[$i]; Role = $script:PillarRoles[$segments[$i]]; Name = $segments[$i + 1] }
        }
    }

    $world = if ($segments.Count -and $script:Worlds.ContainsKey($segments[0])) { $script:Worlds[$segments[0]] }
             elseif ($segments.Count -and $script:PillarRoles.Contains($segments[0])) { 'system: the pillars of the repository itself' }
             else { 'root: how the repository is entered' }

    # The owner is the nearest README above the path; a README's own owner is
    # the README of the folder above it.
    $dir = if ($isDirectory) { $full } else { Split-Path $full -Parent }
    if ((Split-Path $full -Leaf) -eq 'README.md' -or $isDirectory) { $dir = Split-Path $dir -Parent }
    $owner = $null
    $rootFull = [IO.Path]::GetFullPath($Root).TrimEnd([IO.Path]::DirectorySeparatorChar)
    while ($dir -and [IO.Path]::GetFullPath($dir).StartsWith($rootFull)) {
        $candidate = Join-Path $dir 'README.md'
        if ((Test-Path -LiteralPath $candidate) -and [IO.Path]::GetFullPath($candidate) -ne [IO.Path]::GetFullPath($full)) { $owner = $candidate; break }
        if ([IO.Path]::GetFullPath($dir).TrimEnd([IO.Path]::DirectorySeparatorChar) -eq $rootFull) { break }
        $dir = Split-Path $dir -Parent
    }

    [pscustomobject]@{
        Path        = $Path
        Exists      = Test-Path -LiteralPath $full
        IsDirectory = $isDirectory
        Nesting     = @($nesting)
        World       = $world
        Owner       = if ($owner) { [IO.Path]::GetRelativePath($Root, $owner).Replace('\', '/') } else { $null }
        OwnerLead   = if ($owner) { & $ReadLead $owner } else { $null }
    }
}
