function Get-GroupsAndUsers {
    <#
    .SYNOPSIS
        Enumerates local groups using Win32_Group and net localgroup output
    .REFERENCE
        https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-powershell-1.0/ff730963(v=technet.10)?redirectedfrom=MSDN
        https://stackoverflow.com/questions/5072996/how-to-get-all-groups-that-a-user-is-a-member-of
    #>            
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)     
    }
    process {
    }
    end {
        $AllGroups=@()

        $LocalGroups=(Get-CimInstance -ClassName Win32_Group -Filter "domain='$env:COMPUTERNAME'" | Select-Object Name, SID)
        foreach ($groups in $LocalGroups) {
            $accounts=@()
            $GrabUsers=$false
            net localgroup $groups.Name | ForEach-Object {
                if($_ -match "command\scompleted"){
                    $GrabUsers=$false
                }
                if($GrabUsers -eq $true -and [string]::IsNullOrWhiteSpace($_) -eq $false){
                    $accounts+=$_
                }
                if($_ -match "--------"){
                    $GrabUsers=$true
                }

            }
            $AllGroups+=[PSCustomObject]@{
                Type="LocalGroups"
                Name=$groups.Name;
                SID=$groups.SID;
                Users=$accounts
            }
        }
        return $AllGroups
    }
}
Export-ModuleMember -Function Get-GroupsAndUsers
