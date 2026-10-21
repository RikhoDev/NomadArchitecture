# Canon: say what binds in this repository, and what is still waiting for the
# human's reading.
#
# Needs (given by the Host): ReadHeader, a function from a file path to its
# status header (a hashtable) or $null.

function Get-Canon {
    param(
        [Parameter(Mandatory)][string]$Root,
        [Parameter(Mandatory)][scriptblock]$ReadHeader
    )
    $list = Join-Path $Root '.nomad-method/canon'
    if (-not (Test-Path -LiteralPath $list)) { return }
    foreach ($entry in Get-Content -LiteralPath $list) {
        $path = $entry.Trim()
        if (-not $path -or $path.StartsWith('#')) { continue }
        $full = Join-Path $Root $path
        $header = if (Test-Path -LiteralPath $full) { & $ReadHeader $full } else { $null }
        $awaiting = @()
        if ($header -and $header['awaiting_reading']) {
            $awaiting = @($header['awaiting_reading'] -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ })
        }
        [pscustomobject]@{
            Path            = $path
            Exists          = [bool]$header -or (Test-Path -LiteralPath $full)
            Status          = if ($header) { $header['status'] } else { $null }
            AwaitingReading = $awaiting
        }
    }
}
