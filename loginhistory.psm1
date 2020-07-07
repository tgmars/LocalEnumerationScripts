function Get-LoginHistory {
    <#
    .SYNOPSIS
        Returns installed software using Uninstall keys in SOFTWARE\Microsoft and
        SOFTWARE\WoW6432Node
    #>    
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)

        # $EventLogQuery=@{
        #     Logname=    "System";
        #     InstanceId= 20001;
        # }
    }
    process {
    }
    end {

        $USBDevices=@()
 
        foreach ($query in $QueriesToEnumerate){
            Write-Host $query 

            $QueryResults=Get-ItemProperty $query
            Write-Host $QueryResults 

            foreach ($key in $QueryResults) {
                # $USBDevices+=[PSCustomObject]@{
                #     SourceKey=$key.PSParentPath;
                #     DisplayName=$key.DisplayName;
                #     Version=$key.DisplayVersion;
                #     Publisher=$key.Publisher;
                #     InstallDate=$key.InstallDate;
                # }
            }
        }
        return $InstalledSoftware
    }
}

Export-ModuleMember -Function Get-LoginHistory

