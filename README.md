# dd_wrt

# scripts location
/jffs/etc/config/

# cron
*/10 * * * * root /tmp/etc/config/wl_checker.sh
0 9 * * 1-5 root /tmp/etc/config/myPingLog.sh   tv-lan
0 9 * * 1-5 root /tmp/etc/config/myPingLog.sh   tv-buc-lan
0 9 * * 1-5 root /tmp/etc/config/myPingLog.sh   pc-dell-lan
0 18 * * 1-5 root /tmp/etc/config/myPingKill.sh
0 20 * * 7   root /tmp/etc/config/cpLogs.sh
