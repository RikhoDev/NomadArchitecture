# Checks that every commit which changes the canon says on whose authority.
#
#   pwsh Scripts/Test-CanonAuthority.ps1 -Range <base>..<head> [-Repository <path>]
#
# A commit that touches a canon file (listed in .nomad-method/canon, plus
# .github/CODEOWNERS, which names the canon's owners) must carry a trailer:
#
#   Canon-Authority: human       a canon owner wrote it, or read and confirmed it
#   Canon-Authority: review      proposed: it merges only with a canon owner's approval
#   Canon-Authority: delegated   decided by an AI assistant under a human's delegation,
#                                with a second trailer quoting it: Delegation: "<words>"
#
# Clearing a section from a decided_by_assistant header means a human has read
# it, so only `human` may do it. The rules are in __Docs/Evidence-And-Authority.md.
# This check enforces what commits declare; who may approve is enforced by
# code-owner review in the repository's branch protection.
param(
    [Parameter(Mandatory)][string]$Range,
    [string]$Repository = (Split-Path $PSScriptRoot -Parent)
)
$ErrorActionPreference = 'Stop'
$problems = [System.Collections.Generic.List[string]]::new()

function Invoke-Git { git -C $Repository @args }

$canonList = Join-Path $Repository '.nomad-method/canon'
$canon = @(if (Test-Path -LiteralPath $canonList) {
        Get-Content -LiteralPath $canonList | Where-Object { $_ -and $_ -notmatch '^\s*#' } | ForEach-Object { $_.Trim() }
    }) + '.github/CODEOWNERS'

function Get-Decided([string]$Commit, [string]$Path) {
    $text = Invoke-Git show "${Commit}:$Path" 2>$null
    if ($LASTEXITCODE -ne 0 -or -not $text) { return @() }
    $line = $text | Where-Object { $_ -match '^decided_by_assistant:\s*(.*)$' } | Select-Object -First 1
    if (-not $line) { return @() }
    @(($line -replace '^decided_by_assistant:\s*', '') -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ })
}

$commits = @(Invoke-Git rev-list --no-merges --reverse $Range)
foreach ($commit in $commits) {
    $short = $commit.Substring(0, 7)
    $touched = @(Invoke-Git diff-tree --no-commit-id --name-only -r $commit | Where-Object { $_ -in $canon })
    if (-not $touched) { continue }

    $authority = (Invoke-Git log -1 --format='%(trailers:key=Canon-Authority,valueonly)' $commit | Where-Object { $_ }) -join ' '
    $authority = $authority.Trim()
    $where = "$short ($($touched -join ', '))"
    if (-not $authority) {
        $problems.Add("$where declares no Canon-Authority")
        continue
    }
    if ($authority -notin 'human', 'review', 'delegated') {
        $problems.Add("$where declares Canon-Authority '$authority'; use human, review or delegated")
        continue
    }
    if ($authority -eq 'delegated') {
        $delegation = (Invoke-Git log -1 --format='%(trailers:key=Delegation,valueonly)' $commit | Where-Object { $_ }) -join ' '
        if (-not $delegation.Trim()) { $problems.Add("$where is delegated but quotes no Delegation") }
    }
    if ($authority -ne 'human') {
        foreach ($path in $touched) {
            $before = Get-Decided "$commit^" $path
            $after = Get-Decided $commit $path
            foreach ($cleared in $before | Where-Object { $_ -notin $after }) {
                $problems.Add("$short clears #$cleared from $path's decided_by_assistant without Canon-Authority: human")
            }
        }
    }
}

if ($problems.Count) {
    $problems | ForEach-Object { Write-Host "FAIL $_" }
    Write-Host "$($problems.Count) problem(s) in $($commits.Count) commit(s)."
    exit 1
}
Write-Host "Canon authority check passed: $($commits.Count) commit(s) in $Range."
