function Get-ExampleData {
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
        $localVariable = Get-CimInstance Win32_OperatingSystem 
        Write-Host($localVariable)

        # Stub
        # $lvJSON = ConvertTo-Json($localVariable)
    }
    end {
    }
}

