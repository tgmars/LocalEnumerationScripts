function Get-Arp {
    <#
    .SYNOPSIS
        Returns a custom ps object containing arp entries
    .REFERENCES
        Managed .NET & inspo code 
        https://social.technet.microsoft.com/Forums/lync/en-US/e949b8d6-17ad-4afc-88cd-0019a3ac9df9/powershell-alternative-to-arp-a?forum=ITCG
    #>        
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
        
        $Props=@{
            Classname=  "Win32_Process";
            Property=   "ProcessId",
                        "ParentProcessId",
                        "ExecutablePath",
                        "CommandLine",
                        "CreationDate";
            Filter=     "ProcessId = $pid";
        }
    }
    process {
    }
    end {
        $Arp=@()
        $ArpOutput = arp -a 
        $ArpOutput = $ArpOutput[4..($ArpOutput.length-3)] 
        foreach($line in $ArpOutput){
            $cols = $line -split "\s+", 6
            $Arp+=[PSCustomObject]@{
                InternetAddress = $cols[1]
                PhysicalAddress = $cols[2]
                Type = $cols[3]
            }
        }
       return $Arp
    }
}

Export-ModuleMember -Function Get-Arp

