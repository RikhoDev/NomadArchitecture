# Shared by every *.Tests.ps1 proof: state a claim, check it, count failures.
# Dot-source it, call Assert-Promise for each claim, then Complete-Proof.
$script:ProofFailures = 0

function Assert-Promise([string]$Claim, [scriptblock]$Evidence) {
    try {
        if (& $Evidence) { Write-Host "  ok   $Claim" }
        else { Write-Host "  FAIL $Claim"; $script:ProofFailures++ }
    } catch { Write-Host "  FAIL $Claim ($($_.Exception.Message))"; $script:ProofFailures++ }
}

function Complete-Proof {
    if ($script:ProofFailures -gt 0) { exit 1 }
}
