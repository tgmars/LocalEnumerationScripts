function Get-UserAccounts {
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
        
        # These only match on accountTypes that map nicely to one of the following flags
        # Should write some logic to calculate the account types for a given set of flags that
        # don't have an entry in the map.
        $accountTypes = @{
            256 = "UF_TEMP_DUPLICATE_ACCOUNT";
            512 = "UF_NORMAL_ACCOUNT";
            2048 = "UF_INTERDOMAIN_TRUST_ACCOUNT";
            4096 = "UF_WORKSTATION_TRUST_ACCOUNT";
            8192 = "UF_SERVER_TRUST_ACCOUNT"
        }
    }
    process {
        $localVariable = (Get-CimInstance -ClassName Win32_UserAccount -Filter "Name = 'TomLaptop'") | Select-Object Domain, Name, LocalAccount, AccountType, Description, SID, Status
        Write-Host($accountTypes[$localVariable.AccountType])
        # Write-Host($localVariable)
        Write-Host($stringVar)
        # Stub
        # $lvJSON = ConvertTo-Json($localVariable)
    }
    end {
    }
}
