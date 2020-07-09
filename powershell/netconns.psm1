function Get-Netconns {
    <#
    .SYNOPSIS
        Retrieves current network connections and associated PIDs
    .REFERENCES
        https://devblogs.microsoft.com/scripting/parsing-netstat-information-with-powershell-5/
    #>        
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        $Netstats=@()

        $NetstatOutput=netstat -nao -p TCP
        $NetstatOutput=$NetstatOutput[4..$NetstatOutput.count]

        foreach($line in $NetstatOutput){
            $line = $line -split ' ' | ? {$_ -ne ''}
            $Netstats += [PSCustomObject]@{
                'Proto'=$line[0];
                'LAddress'=$line[1];
                'FAddress'=$line[2];
                'State'=$line[3];
                'PID'=$line[4]
           }
        }

        $NetstatOutput=netstat -nao -p UDP
        $NetstatOutput=$NetstatOutput[4..$NetstatOutput.count]

        foreach($line in $NetstatOutput){
            $line = $line -split ' ' | ? {$_ -ne ''}
            $Netstats += [PSCustomObject]@{
                'Proto'=$line[0];
                'LAddress'=$line[1];
                'FAddress'=$line[2];
                'PID'=$line[3]       
            }
        }
        return $Netstats
    }
}

Export-ModuleMember -Function Get-Netconns
