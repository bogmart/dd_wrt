#!/bin/sh

cntUp=0
cntDown=0
hostIp=10.1.1.30

if [ -n "$1" ]
then
  hostIp="$1"
fi

while true
do
  ping -c 1 -W 1  $hostIp > /dev/null
  if [[ $? != 0 ]]; then
    date "+%Y-%m-%d %H:%M:%S  $hostIp is down (down=$cntDown up=$cntUp)"
    let cntDown=$cntDown+1
  else
    date "+%Y-%m-%d %H:%M:%S  $hostIp is UP   (down=$cntDown up=$cntUp)"
    let cntUp=$cntUp+1
  fi

  sleep 60
done


