#!/bin/bash
echo 0 > /sys/module/dvb_core/parameters/dvb_powerdown_on_sleep
freqs="546000000 554000000 562000000 570000000 578000000 586000000 594000000 602000000 666000000 674000000 682000000 690000000"
for freq in $freqs
do
   PID=`pidof dvbsnoop`
   if [ $? -eq 0 ]; then
      echo "Killing dvbsnoop with pid $PID"
      kill -9 $PID
   fi
   timeout 5 dvbtune -f $freq -s 6950 -qam 256 > /dev/null 2>&1
   bw=`dvbsnoop -s bandwidth 8190 -n 3500 -hideproginfo | awk -F: 'END { print $NF }' | sed 's/^[ \t]*//' | awk '{print $1}'`
   echo "Freq: $freq Measured: $bw kbit/s"
done
echo 0 > /sys/module/dvb_core/parameters/dvb_powerdown_on_sleep

