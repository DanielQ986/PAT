@echo off
title
color 0A
REM Chocalatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
REM Admin and Guest
net user administrator /active:no
net user guest /active:no
REM Firewall
sc config "MpsSvc" start= auto
sc start "MpsSvc"
netsh advfirewall set allprofiles state on
REM Automatic Updates (by hand)
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 0 /f
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 4 /f
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v AutoInstallMinorUpdates /t REG_DWORD /d 1 /f
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v NoAutoUpdate /t REG_DWORD /d 0 /f
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v AUOptions /t REG_DWORD /d 4 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 4 /f
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v DisableWindowsUpdateAccess /t REG_DWORD /d 0 /f
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v ElevateNonAdmins /t REG_DWORD /d 0 /f
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoWindowsUpdate /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\Internet Communication Management\Internet Communication" /v DisableWindowsUpdateAccess /t REG_DWORD /d 0 /f
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate /v DisableWindowsUpdateAccess /t REG_DWORD /d 0 /f
REM registy
reg ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AllocateCDRoms /t REG_DWORD /d 1 /f REM CD ROM
reg ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AllocateFloppies /t REG_DWORD /d 1 /f REM Disable remote access to floppy disk
reg ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_DWORD /d 0 /f REM disable auto admin login
reg ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f REM Clear page file
reg ADD "HKLM\SYSTEM\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers" /v AddPrinterDrivers /t REG_DWORD /d 1 /f REM remove printer driver
REM Telnet
DISM /online /disable-feature /featurename:TelnetClient
DISM /online /disable-feature /featurename:TelnetServer
sc stop "TnltSvr"
sc config "TlntSvr" start= disabled
REM Remote Desktop
sc stop "TermService"
sc config "TermService" start= disabled
sc stop "SessionEnv"
sc config "SessionEnv" start= disabled
sc stop "UmRdpService"
sc config "UmRdpService" start= disabled
sc stop "RemoteRegistry"
sc config "RemoteRegistry" start= disabled
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
REM IP Helper
sc stop "iphlpsvc"
sc config "iphlpsvc" start= disabled
REM ICS
sc stop "SharedAccess"
sc config "SharedAccess" start= disabled
REM SSDP Discovery
sc stop "SSDPSRV" 
sc config "SSDPSRV" start= disabled
REM UPnP Device Host
sc stop "upnphost"
sc config "upnphost" start= disabled
REM RpcLocator
sc stop "RpcLocator"
sc config "RpcLocator" start= disabled
REM Telephony
sc stop "TapiSrv"
sc config "TapiSrv" start= disabled
REM FTP(CHECK)
sc stop "msftpsvc"
sc config "msftpsvc" start= disabled
REM SNMP TRAP
sc stop "SNMPTRAP"
sc config "SNMPTRAP" start= disabled
REM Server
sc stop "LanmanServer" 
sc config "LanmanServer" start= disabled
REM WWW Publishing
sc stop "W3SVC"
sc config "W3SVC" start= disabled
REM Net.tcp Port sharing
sc stop "NetTcpPortSharing"
sc config "NetTcpPortSharing" start= disabled
REM ActiveX 
sc stop "AxInstSV"
sc config "AxInstSV" start= disabled
REM Fax 
sc stop "Fax"
sc config "Fax" start= disabled
REM Homegroup listener & provider
sc stop "HomeGroupListener"
sc config "HomeGroupListener" start= disabled
sc stop "HomeGroupProvider"
sc config "HomeGroupProvider" start= disabled
REM Routing & Remote access
sc stop "RemoteAccess"
sc config "RemoteAccess" start= disabled
REM DNS Client
sc stop "Dnscache"
sc config "Dnscache" start= disabled
REM Windows Event Log
sc config "EventLog" start= auto
sc start "EventLog"
REM Windows Updates
sc config "wuauserv" start= auto
sc start "wuauserv"
REM Windows Defender service
REM add at competition for exact service name
REM DHCP Client
sc config "Dhcp" start= auto
sc start "Dhcp"
REM FTP Feature
DISM /online /disable-feature /featurename:IIS-FTPServer
DISM /online /disable-feature /featurename:IIS-FTPSvc
DISM /online /disable-feature /featurename:TFTP
REM SNMP Feature
DISM /online /disable-feature /featurename:SNMP
REM Password Policy
copy /y "C:\Users\%USERNAME%\Desktop\PAT\local.cfg" C:\Users\Public
secedit /configure /db %windir%\security\local.sdb /cfg c:\Users\Public\local.cfg /areas SECURITYPOLICY
REM Auditing
auditpol /set /category:"Account Logon" /success:enable /failure:enable
auditpol /set /category:"Account Management" /success:enable /failure:enable
auditpol /set /category:"Detailed Tracking" /success:enable /failure:enable
auditpol /set /category:"DS Access" /success:enable /failure:enable
auditpol /set /category:"Logon/Logoff" /success:enable /failure:enable
auditpol /set /category:"Object Access" /success:enable /failure:enable
auditpol /set /category:"Policy Change" /success:enable /failure:enable
auditpol /set /category:"Privilege Use" /success:enable /failure:enable
auditpol /set /category:"System" /success:enable /failure:enable



