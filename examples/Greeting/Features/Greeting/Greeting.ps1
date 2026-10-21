# Greeting: the Feature's public promise.
# Given a name, return a greeting for that person. A blank name is refused,
# because "Hello, !" greets no one.

function Get-Greeting {
    param(
        [Parameter(Mandatory = $true)][AllowEmptyString()][string]$Name
    )
    $trimmed = $Name.Trim()
    if ($trimmed.Length -eq 0) {
        throw [System.ArgumentException]::new('A greeting needs a name.')
    }
    return "Hello, $trimmed!"
}
