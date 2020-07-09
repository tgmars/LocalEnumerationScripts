function Get-OSPatchLevel {
    <#
    .SYNOPSIS
        Returns patch level of the current system by enumerating OS build number and QFE hotfixes.
    #>
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
Export-ModuleMember -Function Get-OSPatchLevel
