#!/bin/sh

log_file=/tmp/myLogs/logWl.txt
mkdir -p `dirname ${log_file}`

for i in 0 1 ; do
  wifi_mode="mixed"

  phy_name="phy"${i}
  intf_name="ath"${i}

  intf_is_5g=`iw phy ${phy_name} channels | grep -c "5500"`
  if [ "${intf_is_5g}" == "1" ]; then
    # echo "${phy_iter} 5500 MHz"
    wifi_mode="acn-mixed"
  fi

  nvram set ${intf_name}_net_mode=${wifi_mode}
  nvram set ${intf_name}_gmode=1
done

startservice wland
stopservice lan
sleep 1
startservice lan

echo "$(date): WiFi enabled for ath0 and ath1" | tee -a ${log_file}
