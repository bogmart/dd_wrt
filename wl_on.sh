#!/bin/sh

log_file=/tmp/myLogs/logWl.txt
mkdir -p `dirname ${log_file}`

nvram set ath0_net_mode=acn-mixed
nvram set ath0_gmode=1

nvram set ath1_net_mode=mixed
nvram set ath1_gmode=1

startservice wland
stopservice lan
sleep 1
startservice lan

echo "$(date): WiFi enabled for ath0 and ath1" | tee -a ${log_file}


