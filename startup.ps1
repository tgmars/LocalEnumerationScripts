
<#
.SYNOPSIS
    Writes customized output to a host.
.DESCRIPTION
    startup.ps1 imports PowerShell modules and executes them, executes batch scripts,
    and if applicable runs bash scripts.
#>

Write-Host("Current Powershell Version: " + $PSVersionTable.PSVersion)

# Iterate through all the modules and force reload them
Get-ChildItem "./powershell" -Filter "*.psm1" -File | ForEach-Object {
    Import-Module $_.FullName -Force
}

Write-Object(Get-OSVersion)
Write-Object(Get-OSPatchLevel)
Write-Object(Get-Timestamp)
Write-Object(Get-TZ)
# Write-Object(Get-InstalledSoftware)
# Write-Object(Get-Services)
Write-NestedObject(Get-Processes)
# Write-Object(Get-UserAccounts)
# Write-Object(Get-AdminAccounts)

# mkdir .\batch\output
# # Batch startup
# Get-ChildItem "./batch" -Filter "*.bat" -File | ForEach-Object {
#     .$_.FullName
# }
