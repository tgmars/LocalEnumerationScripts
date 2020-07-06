# Write-Object(PSObject) ... writes the specified object to STDOUT in
# PowerShell's list format as a string.
function Write-Object{
    [CmdletBinding()]
    param (
        [Parameter()]
        [PSObject]
        $objOutput
    )
    Write-Host( $objOutput | Format-List | Out-String)
}