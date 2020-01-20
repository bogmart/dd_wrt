#!/bin/sh

hostIp=tv-lan

logPath=/tmp/myLogs
mkdir -p ${logPath}

if [ -n "$1" ]
then
  hostIp="$1"
fi

logFile=logPing_${hostIp}_$(date +%y.%m.%d_%a).txt

mkdir -p $logPath
/tmp/etc/config/myPing.sh  $hostIp  >  $logPath/$logFile

