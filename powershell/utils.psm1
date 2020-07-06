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

# Write-NestedObject(PSObject) ... writes the specified object to STDOUT in
# truncated, expanded JSON as a string.
function Write-NestedObject{
    [CmdletBinding()]
    param (
        [Parameter()]
        [PSObject]
        $objOutput
    )
    
    Write-Host( $objOutput | Format-Custom | Out-String)
}

Export-ModuleMember -Function Write-NestedObject
Export-ModuleMember -Function Write-Object
