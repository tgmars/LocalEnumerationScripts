# LocalEnumerationScripts

## Tasks to complete

- Operating System and Version - done
- Operating System Patch Level - done, but could be more granular (wmi)
- Current Timestamp - done (wmi)
- Current Timezone - done (wmi)
- Installed Applications/packages - done (reg)
- Process snapshot - done (wmi)
- Services snapshot - done (wmi)
- Current User Accounts - done (wmi)
- Current Admin Accounts - done (wmi)
- Login History - done (eventquery.vbs)
- ARP History - done (arp -a)
- Network Connections -done (netstat)
- Network Interfaces - done (wmi)
- DNS History - done (ipconfig /displaydns)
- Scheduled Tasks/CronJobs - done (wmi)
- Firewall Settings - done (reg)
- USB History - done (reg)
- Recently Accessed Files - done (dir)
- Retrieve File Content - N/A in batch
- Named Pipes - N/A in batch
- Prefetch Files - done (dir)
- Group Policy Configuration - done (gpresult)
- Autoruns - done (wmi)
- Command Line History - done (doskey /history)

## Requirements
- Bash - Ubuntu 10.04 or Centos 5.4
- Batch - Windows XP Service Pack 3
- PowerShell - Version 3, load .NET functionality if req'd, can use sysinternals if justified, need style guide.  