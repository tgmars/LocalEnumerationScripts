# LocalEnumerationScripts

## Tasks to complete

- Operating System and Version - done
- Operating System Patch Level - done, but could be more granular (wmi)
- Current Timestamp - done (wmi)
- Current Timezone - done (wmi)
- Installed Applications/packages - done (reg,finally)
- Process snapshot - done (wmi)
- Services snapshot - done (wmi)
- Current User Accounts - done (wmi)
- Current Admin Accounts - done (wmi)
- Login History - wip (eventquery.vbs)
- ARP History - done (arp -a)
- Network Connections -done (netstat)
- Network Interfaces - done (wmi)
- DNS History - done (ipconfig /displaydns)
- Scheduled Tasks/CronJobs - done
- Firewall Settings (reg) 
- USB History done (reg)
- Recently Accessed Files (reg)
- Retrieve File Content
- Named Pipes - wip (dir, need to investigate further & csv out)
- Prefetch Files - done 
- Group Policy Configuration
- Autoruns - done (wmi)
- Command Line History

## Requirements
- Bash - Ubuntu 10.04 or Centos 5.4
- Batch - Windows XP Service Pack 3
- PowerShell - Version 3, load .NET functionality if req'd, can use sysinternals if justified, need style guide.  