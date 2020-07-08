function Get-LoginHistory {
    <#
    .SYNOPSIS
        Returns windows events used to track account authentications.
        The returned object contains both the raw output of Get-WinEvent and
        it converted to XML.
        Requires admin permissions. 
    .REFERENCES
        https://devblogs.microsoft.com/scripting/use-filterhashtable-to-filter-event-log-with-powershell/
    #>    
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)

        $Time24HoursAgo=(Get-Date).AddHours(-24)
        Write-Host($Time24HoursAgo)

        $EventLogQuery=@{
            Logname=    "Security";
            ID=         "4624", #Logon
                        "4625", #Failed logon
                        "4672", #Priv logon
                        "4720", #Account created
                        "4634", #Logoff
                        "4647", #Logoff
                        "4648", #Runas/explicit creds
                        "4778", #RDP Session connection
                        "4779", #RDP Disconnect/conhost disconnecton
                        "4776", #NTLM auth on provider
                        "4768", #TGT granted - successful kerberos auth
                        "4769", #Service ticket granted - access to server resource
                        "4771"; #kerberos failed login - Preauth failed - 
            StartTime=  "$Time24HoursAgo";
        }
    }
    process {
    }
    end {
        $Events=Get-WinEvent -FilterHashtable $EventLogQuery
        # Write-Object $Events | Format-List *
        return [PSCustomObject]@{
            RawEvents=$Events
            XMLEvents=$Events | ConvertTo-XML -Depth 99
            # StructuredEvents=$Events | ConvertTo-XML
        } 
    }
}

Export-ModuleMember -Function Get-LoginHistory

