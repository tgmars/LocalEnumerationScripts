function Get-Arp {
    <#
    .SYNOPSIS
        Parses arp -a output into a PSCustom Object
    .REFERENCES
        Managed .NET & inspo code 
        https://social.technet.microsoft.com/Forums/lync/en-US/e949b8d6-17ad-4afc-88cd-0019a3ac9df9/powershell-alternative-to-arp-a?forum=ITCG
    #>        
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        $ArpEntries=@()
        $ArpOutput = arp -a 
        $ArpOutput = $ArpOutput[4..($ArpOutput.length-3)] 
        foreach($line in $ArpOutput){
            $cols = $line -split "\s+", 6

            $CurrentArp=[PSCustomObject]@{
                InternetAddress = $cols[1]
                PhysicalAddress = $cols[2]
                Type = $cols[3]
            }

            # If DNS lookups are going to blow opsec in the environment, remove
            # this from the script and just retrieve output of arp -a without
            # conducting DNS lookups to get hostnames.
            # $HostName=Get-Hostname $cols[1]
            # if ($HostName.Length -gt 0) {
            #     $CurrentArp | Add-Member -MemberType NoteProperty -Name "HostName" -Value $HostName
            # }
            $ArpEntries+=$CurrentArp
        }
       return $ArpEntries
    }
}

Function Get-Hostname{
param   ([string]$IPAddress="")
process {TRAP 
             {"" ;continue} 
             return=([system.net.dns]::GetHostByAddress($IPAddress)).HostName
        }
}

Export-ModuleMember -Function Get-Arp

