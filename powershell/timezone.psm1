function Get-TZ {
    <#
    .SYNOPSIS
        Returns the offset from UTC time of the current system.
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
