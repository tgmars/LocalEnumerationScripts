@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

echo "interfaces.bat"
wmic NICCONFIG GET /FORMAT:CSV > .\batch\output\interfaces.csv

REM C:\Users\TomLaptop\OneDrive\RAAF_Cyber\DCO\LocalEnumerationScripts>wmic NICCONFIG LIST BRIEF
REM DefaultIPGateway  Description                               DHCPEnabled  DNSDomain        Index  IPAddress                                      ServiceName
REM                   Microsoft Kernel Debug Network Adapter    TRUE                          0                                                     kdnic
REM                   Hyper-V Virtual Switch Extension Adapter  FALSE                         1                                                     VMSMP
REM                   Hyper-V Virtual Switch Extension Adapter  FALSE                         2                                                     VMSMP
REM                   TAP-NordVPN Windows Adapter V9            TRUE                          3                                                     tapnordvpn
REM                   Hyper-V Virtual Ethernet Adapter          TRUE                          4      {"172.31.48.1", "fe80::b4fa:b7fb:b012:7023"}   VMSNPXYMP
REM                   VirtualBox Host-Only Ethernet Adapter     FALSE                         5      {"192.168.56.1", "fe80::fc98:2e8a:1d95:8f32"}  VBoxNetAdp
REM                   Hyper-V Virtual Ethernet Adapter #2       FALSE                         6      {"10.0.75.1", "fe80::68ef:a9d7:374d:47f4"}     VMSNPXYMP
REM {"10.20.48.1"}    Dell Wireless 1820A 802.11ac              TRUE         TALLAN.internal  7      {"10.20.48.23", "fe80::54b8:5cd0:7c8b:a18b"}   BCMPCIEDHD63
REM                   Microsoft Wi-Fi Direct Virtual Adapter    TRUE                          8                                                     vwifimp
REM                   Microsoft Wi-Fi Direct Virtual Adapter    TRUE                          9                                                     vwifimp
REM                   WAN Miniport (SSTP)                       FALSE                         10                                                    RasSstp
REM                   WAN Miniport (IKEv2)                      FALSE                         11                                                    RasAgileVpn
REM                   WAN Miniport (L2TP)                       FALSE                         12                                                    Rasl2tp
REM                   WAN Miniport (PPTP)                       FALSE                         13                                                    PptpMiniport
REM                   WAN Miniport (PPPOE)                      FALSE                         14                                                    RasPppoe
REM                   WAN Miniport (IP)                         FALSE                         15                                                    NdisWan
REM                   WAN Miniport (IPv6)                       FALSE                         16                                                    NdisWan
REM                   WAN Miniport (Network Monitor)            FALSE                         17                                                    NdisWan
REM                   Remote NDIS Compatible Device             TRUE                          18                                                    usbrndis6
REM                   RAS Async Adapter                         FALSE                         19                                                    AsyncMac
REM                   Bluetooth Device (Personal Area Network)  TRUE                          20                                                    BthPan