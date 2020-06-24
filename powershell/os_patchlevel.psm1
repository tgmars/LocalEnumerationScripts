function Get-OSPatchLevel {
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
        $localVariable = (Get-CimInstance -ClassName Win32_OperatingSystem).BuildNumber
        Write-Host($localVariable)
    }
    end {
    }
}
