
function Get-Pipes {
    <#
    .SYNOPSIS
        Returns named pipes, sysinternals pipes may be a better use here.
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
        # return [System.IO.Directory]::GetFiles("\\.\\pipe\\")
        # (get-childitem \\.\pipe\) | gm
        $PipeListing=(Get-ChildItem -Path \\.\pipe\) | Select-Object Name
        foreach ($pipe in $PipeListing) {
            $PipeProc=-999999     
            $ProcName='unknown'       
            
            if ($pipe.Name -like "*pshost*") {
                $PipeProc=$pipe.Name.Split('.')[2]
                $ProcName=Get-Process -Id $PipeProc | Select-Object Name
            }

            if ($pipe.Name -like "*mojo*") {
                $PipeProc=$pipe.Name.Split('.')[1]
                $ProcName=Get-Process -Id $PipeProc | Select-Object Name
            }

            if ($pipe.Name -like "*winpty*") {
                $PipeProc=$pipe.Name.Split('-')[2]
                $ProcName=Get-Process -Id $PipeProc | Select-Object Name
            }

            $Pipes+=[PSCustomObject]@{
                Name=$pipe.Name
                AssociatedPID=$PipeProc
                AssociatedProcName=$ProcName.Name
            }
        }
        return $Pipes
    }
}
Export-ModuleMember -Function Get-Pipes

