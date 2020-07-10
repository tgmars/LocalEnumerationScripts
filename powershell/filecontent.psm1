
function Get-FileContent {
    <#
    .SYNOPSIS
        Get file content
        TODO: Get ADS from files,Get stat of files,Strings equiv

    .REFERENCE
        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content?view=powershell-7
        https://stackoverflow.com/questions/10672092/read-parse-binary-files-with-powershell
    #>            
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $InputFile="",
        [Parameter(Mandatory=$true)]
        [string]
        $OutputFile=""
    )
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {

        $preHash=(Get-FileHash $InputFile -Algorithm SHA256).Hash
        $FileContents=[System.IO.File]::ReadAllBytes($InputFile)
        [System.IO.File]::WriteAllBytes($OutputFile,$FileContents)
        $postHash=(Get-FileHash $InputFile -Algorithm SHA256).Hash
        if ($preHash -eq $postHash) {
            Write-Host("Copied from $InputFile to $OutputFile")
        } else {
            Write-Host("Hashes don't match, file copy failed.")

        }
    }
}
Export-ModuleMember -Function Get-FileContent
