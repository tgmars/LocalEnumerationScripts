function Get-Timestamp {
    <#
    .SYNOPSIS
        Returns a PSObject with param TimeStamp containing a UTC timestamp
    #>
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {    
        return [PSCustomObject]$TS=@{
            TimeStamp=(Get-Date).ToUniversalTime()
        }
    }
}

Export-ModuleMember -Function Get-Timestamp