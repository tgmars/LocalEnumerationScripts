function Get-TZ {
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
        $localVariable = (Get-TimeZone) | Select-Object  BaseUtcOffset 
        Write-Host($localVariable)
        # Stub
        # $lvJSON = ConvertTo-Json($localVariable)
    }
    end {
    }
}
