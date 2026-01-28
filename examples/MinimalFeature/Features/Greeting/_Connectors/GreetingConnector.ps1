function Greet {
    param(
        [Parameter(Mandatory=$true)][string]$Name
    )
    return "Hello, $Name!"
}

# Note: this file is dot-sourced by Hosts (not imported as a module),
# so `Export-ModuleMember` is not necessary here and may warn at runtime.
