
function Get-Pipes {
    <#
    .SYNOPSIS
        Returns named pipes, sysinternals pipes may be a better use here.
        Enumerates associated processes for named pipes pids in their names.
    .REFERENCE
        https://stackoverflow.com/questions/258701/how-can-i-get-a-list-of-all-open-named-pipes-in-windows
        MOJO Pipes -https://chromium.googlesource.com/chromium/src.git/+/master/mojo/README.md
    #>            
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        $Pipes=@()
        $PipeListing=[System.IO.Directory]::GetFiles("\\.\\pipe\\")
        foreach ($pipe in $PipeListing) {
            $PipeProc=-999999     
            $ProcName='unknown'       
            
            if ($pipe -like "*pshost*") {
                $PipeProc=$pipe.Split('.')[3]
                $ProcName=Get-Process -Id $PipeProc | Select-Object Name
            }

            if ($pipe -like "*mojo*") {
                $PipeProc=$pipe.Split('.')[2]
                $ProcName=Get-Process -Id $PipeProc | Select-Object Name
            }

            if ($pipe -like "*winpty*") {
                $PipeProc=$pipe.Split('-')[2]
                $ProcName=Get-Process -Id $PipeProc | Select-Object Name
            }

            $Pipes+=[PSCustomObject]@{
                Name=$pipe
                AssociatedPID=$PipeProc
                AssociatedProcName=$ProcName.Name
            }
        }
        return $Pipes
    }
}
Export-ModuleMember -Function Get-Pipes

