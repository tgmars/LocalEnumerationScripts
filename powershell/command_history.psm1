function Get-CommandHistory {
    <#
    .SYNOPSIS
        Enumerates command history with the Get-History cmdlet and retrieving contents of *_History.txt files in
        # users PSReadline directories. 
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
        $CommandHistories=@()

        Get-ChildItem "C:\Users\*\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\*" -File | ForEach-Object {
            # Write-Host($_.FullName)
            $CommandHistories+=[PSCustomObject]@{
                Type="PSReadlineFile"
                FilePath = $_.FullName
                FileName=$_.Name
                UserProfile=$_.FullName.Split('\')[2]
                History=Get-Content $_.FullName
            }
        }
        $CommandHistories+=[PSCustomObject]@{
            Type="GetHistory"
            UserProfile=[Environment]::Username
            History=Get-History
        }

        return $CommandHistories
    }
}
Export-ModuleMember -Function Get-CommandHistory
