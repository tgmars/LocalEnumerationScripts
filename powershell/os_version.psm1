function Get-OSVersion {
    <#
    .SYNOPSIS
        Returns OS build number and architecture information.
    #>    
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        return [PSCustomObject]$OSVersion=@{
            FriendlyName=(Get-CimInstance Win32_OperatingSystem).Caption;
            Version=(Get-CimInstance Win32_OperatingSystem).Version;
            Architecture=(Get-CimInstance Win32_OperatingSystem).OSArchitecture
            EncryptionLevel=(Get-CimInstance Win32_OperatingSystem).EncryptionLevel
        }
    }
}
