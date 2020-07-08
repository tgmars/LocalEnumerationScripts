function Get-Services {
    <#
    .SYNOPSIS
        Returns services and their state on the current host.
        TODO - Query windows event logs for ID 4697
    #>    
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {    

        $Props=@{
            Property=   "Name",
                        "DisplayName",
                        "Description",
                        "InstallDate",
                        "PathName",
                        "ProcessId",
                        "State",
                        "Status",
                        "SystemName",
                        "StartMode",
                        "StartName"
        }

        $Win32Services = (Get-CimInstance -ClassName Win32_Service @Props) 
        return [PSCustomObject]@{
            Name=$Win32Services.Name; 
            DisplayName=$Win32Services.DisplayName; 
            Description=$Win32Services.Description; 
            InstallDate=$Win32Services.InstallDate;
            Imagename=$Win32Services.PathName;
            PID=$Win32Services.ProcessId;
            State=$Win32Services.State;
            Status=$Win32Services.Status;
            Systemname=$Win32Services.SystemName;
            Startmode=$Win32Services.StartMode;
            ServiceAccount=$Win32Services.StartName
        }
    }
}
Export-ModuleMember -Function Get-Services

