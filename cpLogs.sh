#!/bin/sh

#copy wireless logs
mv /tmp/myLogs/logWl.txt /jffs/myLogs/logWl_$(date +%y.%m.%d_%a).txt

#copy TV logs
cp -p  /tmp/myLogs/*  /jffs/myLogs/
rm /tmp/myLogs/*

#copy system logs
cp /var/log/messages  /jffs/myLogs/var_logs_$(date +%y.%m.%d_%a).txt



