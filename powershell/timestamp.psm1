function Get-Timestamp {
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
        $localVariable = (Get-Date).ToUniversalTime()
        Write-Host($localVariable)

        # Stub
        # $lvJSON = ConvertTo-Json($localVariable)
    }
    end {    
    }
}

