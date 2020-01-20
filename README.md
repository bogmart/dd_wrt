# dd_wrt

#scripts location <br/>
/jffs/etc/config/<br/>
<br/>
#cron<br/>
*/10 * * * * root /tmp/etc/config/wl_checker.sh<br/>
0 9 * * 1-5 root /tmp/etc/config/myPingLog.sh   tv-lan<br/>
0 9 * * 1-5 root /tmp/etc/config/myPingLog.sh   tv-buc-lan<br/>
0 9 * * 1-5 root /tmp/etc/config/myPingLog.sh   pc-dell-lan<br/>
0 18 * * 1-5 root /tmp/etc/config/myPingKill.sh<br/>
0 20 * * 7   root /tmp/etc/config/cpLogs.sh<br/>
