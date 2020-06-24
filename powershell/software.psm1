function Get-InstalledSoftware {
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
        $localVariable = (Get-CimInstance -ClassName Win32_Product) | Select-Object Name, PackageName, InstallDate, InstallSource
        Write-Host($localVariable)

        # Stub
        # $lvJSON = ConvertTo-Json($localVariable)
    }
    end {    
    }
}

