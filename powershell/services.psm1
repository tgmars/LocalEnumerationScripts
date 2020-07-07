function Get-Services {
    <#
    .SYNOPSIS
        Returns services and their state on the current host
    #>    
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {    
        $Win32Services = (Get-CimInstance -ClassName Win32_Service) 
        return [PSCustomObject]@{
            Name=$Win32Services | Select-Object Name; 
            DisplayName=$Win32Services | Select-Object DisplayName; 
            Description=$Win32Services | Select-Object Description; 
            InstallDate=$Win32Services | Select-Object InstallDate;
            Imagename=$Win32Services | Select-Object PathName;
            PID=$Win32Services | Select-Object ProcessId;
            State=$Win32Services | Select-Object State;
            Status=$Win32Services | Select-Object Status;
            Systemname=$Win32Services | Select-Object SystemName;
            Startmode=$Win32Services | Select-Object StartMode;
            ServiceAccount=$Win32Services | Select-Object StartName

        }
    }
}
Export-ModuleMember -Function Get-Services

