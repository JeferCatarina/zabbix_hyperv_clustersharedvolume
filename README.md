# Zabbix Hyper-V Cluster Shared Volume LLD.

Requirement: Zabbix 4.0 +

Installation guide:
- Import Template;
- Copy "win_clustersv.ps1" to Zabbix Agent folder;
- Add following UserParameter in zabbix_agentd.conf:
* UserParameter=windowscsvfs.discovery[*],powershell -NoProfile -ExecutionPolicy Bypass -File C:\zabbix\win_clustersv.ps $1
- Link template to host;
