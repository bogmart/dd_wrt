#!/bin/sh

### purpose:          cron script to disable WiFi 2.4GHz & 5GHz when no clients are connected (see wait_for_WiFi_clients)
### script location:  /tmp/etc/config/
### cron config:      Management -> Cron
### cron ex:          */10 * * * * root /tmp/etc/config/wl_checker.sh
### output            /tmp/logWl.txt
### steps:            cp -p <script>; chmod +x


wait_for_WiFi_clients=3610

#ignore: priza-suf, tel-radu, tel-vlad
ignore_clients="1c:61:b4:4c:b4:61|8C:B8:4A:66:8B:F8|6C:C7:EC:B4:C6:14"

ifaces_WiFi=$(ifconfig | grep -oE "ath[.0-9]+")

log_file=/tmp/myLogs/logWl.txt
mkdir -p `dirname ${log_file}`

#echo $(date)
echo proc="$0"  script="${0##*/}"  pid=$$


wiFi_state="off"
for intf in ${ifaces_WiFi}; do
  if [ "$( (ifconfig $intf) | grep -o RUNNING)" ]; then
    #echo "WiFi active on " ${intf}
    wiFi_state="on"
    break
  fi
done

if [ "${wiFi_state}" == "on" ]; then
  existing_proc_pid="$(pidof ${0##*/})"
  #echo existing_proc_pid $existing_proc_pid

  wiFi_clients="false"
  for intf in $ifaces_WiFi; do
    if [ "$( (iw dev ${intf} station dump) | grep Station | grep -vE ${ignore_clients} )" ]; then
      #echo "WiFi client(s) present(s) on " ${intf}
      wiFi_clients="true"
      break
    fi
  done

  if [ ${wiFi_clients} == "true" ]; then
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


