<!-- Powershell template -->
function Get-ExampleData {
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
Export-ModuleMember -Function Get-ExampleData


<!-- Batch template -->
@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

echo "file_function.bat"
command > .\batch\output\filename.ext

<!-- Bash template -->