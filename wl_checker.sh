#!/bin/sh

### purpose:          cron script to disable WiFi 2.4GHz & 5GHz when no clients are connected (see wait_for_WiFi_clients)
### script location:  /tmp/etc/config/
### cron config:      Management -> Cron
### cron ex:          */10 * * * * root /tmp/etc/config/wl_checker.sh
### output            /tmp/logWl.txt
### steps:            cp -p <script>; chmod +x

wait_for_WiFi_clients=3610
interf_WiFi_0=ath0
interf_WiFi_1=ath1

log_file=/tmp/myLogs/logWl.txt
mkdir -p `dirname ${log_file}`

#echo $(date)
echo proc="$0"  script="${0##*/}"  pid=$$

if [ "$( (ifconfig $interf_WiFi_0 ; ifconfig $interf_WiFi_1) | grep -o RUNNING)" ]; then
  existing_proc_pid="$(pidof ${0##*/})"
  #echo existing_proc_pid $existing_proc_pid
  
  if [ "$( (iw dev $interf_WiFi_0 station dump ; iw dev $interf_WiFi_1 station dump) | grep Station)" ]; then
    #echo "WiFi client(s) present(s)"
    for pid in $existing_proc_pid; do
      if [ $pid != $$ ]; then
        echo "$(date): kill process running with PID $pid" | tee -a $log_file
        kill -9 $pid
        kill -9 `ps | grep "sleep $wait_for_WiFi_clients" | grep -v grep | awk '{ print $1 }'`
        killall inotifywait
        exit 1
      fi
    done
  else
    #echo "No WiFi client(s)"
    for pid in $existing_proc_pid; do
      if [ $pid != $$ ]; then
        #echo "process already running with PID $pid"
        exit 2
      fi
    done

    echo "$(date): sleep $wait_for_WiFi_clients ..." | tee -a $log_file
    sleep $wait_for_WiFi_clients
    /tmp/etc/config/wl_off.sh
  fi
fi


