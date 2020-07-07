function Get-UserAccounts {
    <#
    .SYNOPSIS
        Return all user accounts of the current host. If run on a workstation or server,
        return local & service accounts. If run on a domain controller, return AD accounts
        in addition to local & service accs. 
    .REFERENCE
        https://getadmx.com/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsLogon::EnumerateLocalUsers

    #>            
    [CmdletBinding()]
    param()
    begin {
        Import-Module ActiveDirectory
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)

        # AccountType vallues returned by CIM class Win32_UserAccount are uint32
        $AccountTypeMap = @{
            [uint32]256 = "UF_TEMP_DUPLICATE_ACCOUNT";
            [uint32]512 = "UF_NORMAL_ACCOUNT";
            [uint32]2048 = "UF_INTERDOMAIN_TRUST_ACCOUNT";
            [uint32]4096 = "UF_WORKSTATION_TRUST_ACCOUNT";
            [uint32]8192 = "UF_SERVER_TRUST_ACCOUNT"
        }
        
        # These only match on accountTypes that map nicely to one of the following flags
        # Should write some logic to calculate the account types for a given set of flags that
        # don't have an entry in the map.
    }
    process {
    }
    end {
        $UserAccounts=@()

        $Win32UserAccounts=(Get-CimInstance -ClassName Win32_UserAccount) 
        foreach ($account in $Win32UserAccounts) {
            $UserAccounts+=[PSCustomObject]@{
                Type="Win32_UserAccount"
                Domain=$account.Domain;
                Name=$account.Name;
                LocalAccount=$account.LocalAccount;
                AccountType=$AccountTypeMap[$account.AccountType];
                CreationDate=$account.Description;
                SID=$account.SID;
                Status=$account.Status;`
            }
        }

        $Win32ServiceAccounts= (Get-CimInstance -ClassName Win32_Service) | Select-Object StartName -Unique 
        foreach ($account in $Win32ServiceAccounts) {
            $UserAccounts+=[PSCustomObject]@{
                Type="Win32_ServiceAccount";
                Name=$account.StartName;
            }
        }
        return $UserAccounts
    }
}
Export-ModuleMember -Function Get-UserAccounts
