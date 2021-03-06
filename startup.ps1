
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

# Uncomment each of the modules that you want to execute below.

# Write-Object(Get-OSVersion)
# Write-Object(Get-OSPatchLevel)
# Write-Object(Get-Timestamp)
# Write-Object(Get-TimeZoneHCM)
# Write-Object(Get-InstalledSoftware)
# Write-Object(Get-Services)
# Write-Object(Get-Processes)
# Write-Object(Get-Accounts)
# Write-Object(Get-GroupsAndUsers)
# Write-Object(Get-USBDevices)
# Write-Object(Get-Pipes)
# Write-Object(Get-CommandHistory)
# Get-FileContent "Full_input_filepath" "Full_output_filepath"
# Write-Object(Get-LoginHistory)    
# Write-Object(Get-Arp)
# Write-Object(Get-DNSClientCacheHCM)
# Write-Object(Get-NetInterfaces)
# Write-Object(Get-Netconns)
# Write-Object(Get-SchedTasks)
# Write-Object(Get-Firewall)
# Write-Object(Get-Recentfiles)
# Write-Object(Get-Prefetch)
# Write-Object(Get-GroupPolicy)


# mkdir .\batch\output
# # Batch startup
# Get-ChildItem "./batch" -Filter "*.bat" -File | ForEach-Object {
#     .$_.FullName
# }
