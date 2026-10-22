# Proof for the Placement Feature, on a throwaway tree with a fake lead reader.
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '..' 'Placement.ps1')
. (Join-Path $PSScriptRoot '..' '..' '..' '..' '..' 'Scripts' 'Proof.ps1')

$root = Join-Path ([IO.Path]::GetTempPath()) ([Guid]::NewGuid())
$feature = Join-Path $root 'Hosts/Reader/Features/Canon'
New-Item -ItemType Directory $feature, (Join-Path $root 'Scripts') | Out-Null
'x' | Set-Content (Join-Path $root 'Hosts/Reader/README.md')
'x' | Set-Content (Join-Path $feature 'README.md')
'x' | Set-Content (Join-Path $feature 'Canon.ps1')
'x' | Set-Content (Join-Path $root 'Scripts/Check.ps1')
$lead = { param($p) "lead of $([IO.Path]::GetRelativePath($root, $p).Replace('\', '/'))" }

$code = Get-Placement -Root $root -Path 'Hosts/Reader/Features/Canon/Canon.ps1' -ReadLead $lead
Assert-Promise 'names every pillar a path sits inside, outermost first' {
    ($code.Nesting | ForEach-Object { "$($_.Role):$($_.Name)" }) -join ' ' -eq 'WHY:Reader WHAT:Canon'
}
Assert-Promise 'its owner is the nearest README, with that README''s promise' {
    $code.Owner -eq 'Hosts/Reader/Features/Canon/README.md' -and $code.OwnerLead -eq 'lead of Hosts/Reader/Features/Canon/README.md'
}
Assert-Promise 'a README is owned by the README above it' {
    (Get-Placement -Root $root -Path 'Hosts/Reader/Features/Canon/README.md' -ReadLead $lead).Owner -eq 'Hosts/Reader/README.md'
}
Assert-Promise 'scaffolding is placed in the repository world' {
    (Get-Placement -Root $root -Path 'Scripts/Check.ps1' -ReadLead $lead).World -like 'repository world*'
}
Assert-Promise 'a reference system is its own world, with its own pillars' {
    New-Item -ItemType Directory (Join-Path $root 'Reference/Shop/Features/Cart') -Force | Out-Null
    'x' | Set-Content (Join-Path $root 'Reference/Shop/Features/Cart/Cart.cs')
    $p = Get-Placement -Root $root -Path 'Reference/Shop/Features/Cart/Cart.cs' -ReadLead $lead
    $p.World -like 'reference systems*' -and ($p.Nesting | ForEach-Object { "$($_.Role):$($_.Name)" }) -join ' ' -eq 'WHAT:Cart'
}
Assert-Promise 'a path that does not exist says so' { -not (Get-Placement -Root $root -Path 'Nowhere/x.md' -ReadLead $lead).Exists }

Remove-Item -Recurse -Force $root
Complete-Proof
