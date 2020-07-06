function Get-OSPatchLevel {
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        return [PSCustomObject]$PatchLevel=@{
            BuildNumber=(Get-CimInstance -ClassName Win32_OperatingSystem).BuildNumber;
            Patches=(Get-CimInstance -ClassName Win32_QuickFixEngineering) | Select-Object HotfixID, InstalledBy, InstalledOn
        }
    }
}
