function Get-NetInterfaces {
    <#
    .SYNOPSIS
        Retrieves currently connected network interfaces with WMI
    #>        
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        return (Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration -Filter 'ipenabled = "true"')
        # For more detail on the interface itself, can execute  
        # (Get-CimInstance -ClassName Win32_NetworkAdapter -Filter "netconnectionstatus=2")
        # and merge the objects.

        }
}

Export-ModuleMember -Function Get-NetInterfaces
