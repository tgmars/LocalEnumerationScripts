
<#
.SYNOPSIS
    Writes customized output to a host.
.DESCRIPTION
    startup.ps1 imports PowerShell modules and executes them, executes batch scripts,
    and if applicable runs bash scripts.
#>

# $PSVersion = Get-Host.Version
# Write-Host("Current Powershell Version: " + $PSVersionTable.PSVersion)

# Get-ChildItem "./powershell" -Filter "*.psm1" -File | ForEach-Object {
#     Import-Module $_.FullName -Force
# }

# Get-OSVersion   
# Get-OSPatchLevel
# Get-Timestamp
# Get-TZ
# # Get-InstalledSoftware
# # Get-Services
# # Get-Processes
# Get-UserAccounts
# # Get-AdminAccounts

mkdir .\batch\output
# Batch startup
Get-ChildItem "./batch" -Filter "*.bat" -File | ForEach-Object {
    .$_.FullName
}
