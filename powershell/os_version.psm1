function Get-OSVersion {
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
        $localVariable = (Get-CimInstance Win32_OperatingSystem).Caption
        Write-Host($localVariable)
    }
    end {
    }
}
