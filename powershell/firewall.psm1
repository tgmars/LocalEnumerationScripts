function Get-Firewall {
    <#
    .SYNOPSIS
        Enumerates firewall rules using the HNetCfg.FwPolicy2 com object
    .REFERENCE
        https://serverfault.com/questions/415622/how-can-i-use-netsh-to-find-a-rule-using-a-pattern
    .SCHEMA
        Name                        : Xbox Game Bar
        Description                 : Xbox Game Bar
        ApplicationName             :
        serviceName                 :
        Protocol                    : 256
        LocalPorts                  :
        RemotePorts                 :
        LocalAddresses              : *
        RemoteAddresses             : *
        IcmpTypesAndCodes           :
        Direction                   : 2
        Interfaces                  :
        InterfaceTypes              : All
        Enabled                     : True
        Grouping                    : Xbox Game Bar
        Profiles                    : 7
        EdgeTraversal               : False
        Action                      : 1
        EdgeTraversalOptions        : 0
        LocalAppPackageId           : S-1-15-2-1714399563-1326177402-2048222277-143663168-2151391019-765408921-4098702777
        LocalUserOwner              : S-1-5-21-1329900238-2378929851-359923150-1001
        LocalUserAuthorizedList     :
        RemoteUserAuthorizedList    :
        RemoteMachineAuthorizedList :
        SecureFlags                 : 0
    #>    
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        $FirewallRules=@()
        $FwComObj=New-object -comObject HNetCfg.FwPolicy2    
        foreach($rule in $FwComObj.rules){
            $FirewallRules+=$rule
        }
        return $FirewallRules
    }
}

Export-ModuleMember -Function Get-Firewall

