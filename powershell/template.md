<!-- Powershell template -->
function Get-ExampleData {
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
        $localVariable = Get-CimInstance Win32_OperatingSystem 
        Write-Host($localVariable)

        # Stub
        # $lvJSON = ConvertTo-Json($localVariable)
    }
    end {
    }
}

<!-- Batch template -->
@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

echo "file_function.bat"
command > .\batch\output\filename.ext

<!-- Bash template -->