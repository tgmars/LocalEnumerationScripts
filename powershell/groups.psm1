function Get-GroupsAndUsers {
    <#
    .SYNOPSIS
        Only enumerates local groups and their users. This identifies admin accounts based on 
        whether they're present in the local Administrator group.
    .REFERENCE
        https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-powershell-1.0/ff730963(v=technet.10)?redirectedfrom=MSDN
        https://stackoverflow.com/questions/5072996/how-to-get-all-groups-that-a-user-is-a-member-of
    #>            
    [CmdletBinding()]
    param()
    begin {
        Import-Module ActiveDirectory
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)     
    }
    process {
    }
    end {
        $AllGroups=@()

        $LocalGroups=(Get-LocalGroup) 
        foreach ($groups in $LocalGroups) {
            $UsersInCurrentGroup=Get-LocalGroupMember $groups
            $AllGroups+=[PSCustomObject]@{
                Type="LocalGroups"
                Name=$groups.Name;
                SID=$groups.SID;
                Description=$account.Description;
                PrincipalSource=$groups.PrincipalSource;
                Users=$UsersInCurrentGroup;
            }
        }
        return $AllGroups
    }
}
Export-ModuleMember -Function Get-GroupsAndUsers
