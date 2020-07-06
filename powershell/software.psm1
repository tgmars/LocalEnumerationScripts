function Get-InstalledSoftware {
    <#
    .SYNOPSIS
        Returns installed software using Uninstall keys in SOFTWARE\Microsoft and
        SOFTWARE\WoW6432Node
    #>    
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {

        $QueriesToEnumerate=@(
            "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
            "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
        )   
        $InstalledSoftware=@()
 
        foreach ($query in $QueriesToEnumerate){
            $QueryResults=Get-ItemProperty $query
            foreach ($key in $QueryResults) {
                $InstalledSoftware+=[PSCustomObject]@{
                    SourceKey=$key.PSParentPath;
                    DisplayName=$key.DisplayName;
                    Version=$key.DisplayVersion;
                    Publisher=$key.Publisher;
                    InstallDate=$key.InstallDate;
                }
            }
        }
        return $InstalledSoftware
    }
}

Export-ModuleMember -Function Get-InstalledSoftware

