#!/bin/sh

log_file=/tmp/myLogs/logWl.txt
mkdir -p `dirname ${log_file}`

stopservice wland

nvram set ath0_net_mode=disabled
nvram set ath0_gmode=-1

nvram set ath1_net_mode=disabled
nvram set ath1_gmode=-1

killall hostapd

echo "$(date): WiFi off for ath0 and ath1" | tee -a ${log_file}


