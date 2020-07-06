# LocalEnumerationScripts

## Tasks to complete (Powershell)
- Operating System and Version - done (CIM Win32_OS)
- Operating System Patch Level - done (CIM QFE)
- Current Timestamp - done (Get date)
- Current Timezone - done (Get timezone)
- Installed Applications/packages - done (Uninstall REG keys)
- Process snapshot - done (CIM Win32_Process and .NET System.Diagnostics.Process)
- Services snapshot -
- Current User Accounts  -
- Current Admin Accounts -
- Login History -
- ARP History -
- Network Connections -
- Network Interfaces -
- DNS History -
- Scheduled Tasks/CronJobs -
- Firewall Settings -
- USB History - 
- Recently Accessed Files -
- Retrieve File Content -
- Named Pipes -
- Prefetch Files 
- Group Policy Configuration - 
- Autoruns -
- Command Line History - 

## Requirements
- Bash - Ubuntu 10.04 or Centos 5.4
- Batch - Windows XP Service Pack 3
- PowerShell - Version 3, load .NET functionality if req'd, can use sysinternals if justified, need style guide.  


#### Batch
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
- USB History - done (reg) - Need to add USBSTOR key
- Recently Accessed Files - done (dir)
- Retrieve File Content - N/A in batch
- Named Pipes - N/A in batch
- Prefetch Files - done (dir)
- Group Policy Configuration - done (gpresult)
- Autoruns - done (wmi)
- Command Line History - done (doskey /history)

#### Bash
- Operating System and Version - done (lsb_release -a)
- Operating System Patch Level - done (apt/history.log and dpkg.log)
- Current Timestamp - done (date)
- Current Timezone - done (date and /etc/timezone)
- Installed Applications/packages - done (dpkg)
- Process snapshot - done (ps)
- Services snapshot - done (services --status-all and initctl )
- Current User Accounts  - done (getent passwd & groups)
- Current Admin Accounts - done (getent passwd & groups)
- Login History - done (auth.log)
- ARP History - done (arp -a)
- Network Connections - done (netstat)
- Network Interfaces - done (ip link show)
- DNS History - done (/etc/hosts)
- Scheduled Tasks/CronJobs - done (crontabs)
- Firewall Settings - done (iptables)
- USB History - done (dmesg)
- Recently Accessed Files - done (find)
- Retrieve File Content - done (dd)
- Named Pipes - done (find)
- Prefetch Files - N/A
- Group Policy Configuration - N/A (get /etc)
- Autoruns - done (.bash*, /etc/local.rc /etc/profile)
- Command Line History - done (history and ~/.bash_history)