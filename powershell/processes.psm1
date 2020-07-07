function Get-Processes {
    <#
    .SYNOPSIS
        Returns process information derived from .NET and Win32_Process 
        classes. This is pretty slow because we're enumerating each PID
        and making a call to .NET and CIM for each PID, taking data from
        each and mashing them into a PSCustomObject.
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
        $PIDs=Get-Process | Select-Object Id
        
        $CurrentProcs=@()

        foreach ($pid in $PIDs.Id){
            # $Filter=@{Filter="ProcessId = $pid"}
            $Win32Proc=Get-CimInstance @Props 
            $DotNETProc=[System.Diagnostics.Process]::GetProcessById($pid)
            $CurrentProcs+=[PSCustomObject]@{
                PID=$Win32Proc.ProcessId;
                PPID=$Win32Proc.ParentProcessId;
                ImagePath=$Win32Proc.ExecutablePath;
                CommandLine=$Win32Proc.CommandLine;
                CreationDate=$Win32Proc.CreationDate;
                ProcName=$DotNETProc.ProcessName;
                Threads=$DotNETProc.Threads;
                Modules=$DotNETProc.Modules;
                Handles=$DotNETProc.Handles;
            }
        }
        return $CurrentProcs
    }
}

Export-ModuleMember -Function Get-Processes

