function Get-Services {
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
        $localVariable = (Get-CimInstance -ClassName Win32_Service) | Select-Object Name, DisplayName, Description, 
            InstallDate, PathName, ProcessId, State, Status, SystemName, StartMode
        Write-Host($localVariable)

        # Stub
        # $lvJSON = ConvertTo-Json($localVariable)
    }
    end {    
    }
}

