function Get-Prefetch {
    <#
    .SYNOPSIS
        Get content of and information about prefetch files
    .REFERENCES
    #>        
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        $PrefetchObjs=@()

        Get-ChildItem "C:\Windows\Prefetch\*.pf" -File -Force | ForEach-Object {
            $PrefetchObjs+=[PSCustomObject]@{
                ExecutableName=$_.Name.Split("-")[0]
                PrefetchID=$_.Name.Split("-")[1].Split(".")[0]
                CreatedUTC=$_.CreationTimeUtc
                ModifiedUTC=$_.LastWriteTimeUtc
                FullName=$_.FullName
            }
        }
        return $PrefetchObjs
    }
}

Export-ModuleMember -Function Get-Prefetch
