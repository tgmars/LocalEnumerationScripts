function Get-TimeZoneHCM {
    <#
    .SYNOPSIS
        Returns the textual timezone of the current system
    #>
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        return [PSCustomObject]$TZ=@{
            TimeZone=[System.TimeZone]::CurrentTimeZone | Select-Object StandardName 
        }
    }
}

Export-ModuleMember -Function Get-TimeZoneHCM