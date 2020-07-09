function Get-USBDevices {
    <#
    .SYNOPSIS
        Returns installed software using Uninstall keys in SOFTWARE\Microsoft and
        SOFTWARE\WoW6432Node
    #>    
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)

        $USBSTOR="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USBSTOR\"
        
        # Not pulling these keys back yet - placeholders for once there's more context about how 
        # usb data is correlated within DCOT.
        # $MountedDevices="Registry::HKEY_LOCAL_MACHINE:SYSTEM\MountedDevices\"
        # $UserMountPoints="REGISTRY::HKEY_USERS\*\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\" 

        $Time24HoursAgo=(Get-Date).AddHours(-24)
        Write-Host($Time24HoursAgo)

        $PNPEventQuery=@{
            Logname=    "System";
            ID=         "20001";
            StartTime=  "$Time24HoursAgo";
        }
        
    }
    process {
    }
    end {
        $USBDevices=@()

        foreach($Device in Get-ChildItem $USBSTOR){
            $Device=$Device -replace "HKEY_LOCAL_MACHINE","HKLM:"
            $DeviceID=(Get-ChildItem $Device)
            $DeviceID=$DeviceID -replace "HKEY_LOCAL_MACHINE","HKLM:"
            Get-ItemProperty -Path $DeviceID | ForEach-Object {
                # $testvar=($_ | Get-Member -MemberType NoteProperty)
                # $testvar = ($_ | Get-Member -MemberType Property)
                $USBDevices+=$_.HardwareID
                Write-Host($_.$_)
            }
        }

        $Events=Get-WinEvent -ErrorAction SilentlyContinue -FilterHashtable $PNPEventQuery
        if($Events.Length -gt 0){
            $USBDevices+=[PSCustomObject]@{
                Type="PlugnPlayEvents"
                RawEvents=$Events
                XMLEvents=$Events | ConvertTo-XML -Depth 99
                # StructuredEvents=$Events | ConvertTo-XML
            }  
        }
        return $USBDevices
    }
}

Export-ModuleMember -Function Get-USBDevices

