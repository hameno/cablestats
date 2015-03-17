#!/bin/bash

# Load configuration
source ./config.sh
# Constants
source ./constants.sh

echo 0 > /sys/module/dvb_core/parameters/dvb_powerdown_on_sleep
for i in "${!FREQUENCIES[@]}"; do
    PID=`pidof dvbsnoop`
    if [ $? -eq 0 ]; then
        echo "Killing dvbsnoop with pid $PID"
        kill -9 ${PID}
    fi
    timeout 5 dvbtune -f ${FREQUENCIES[$i]} -s 6950 -qam 256 > /dev/null 2>&1
    SNOOP_RESULT=`timeout 10 dvbsnoop -s bandwidth 8190 -n 3500 -hideproginfo`
    # if [ $? -ne 0 ]; then
    #     echo "Error during dvb snoop"
    #     exit 1
    # fi
    BW=`echo ${SNOOP_RESULT} | awk -F: 'END { print $NF }' | sed 's/^[ \t]*//' | awk '{print $1}'`
    if [ ${BW} != '15)' ]; then
        echo "Freq: ${FREQUENCIES[$i]} Measured: ${BW} kbit/s"
        rrdtool update ${BASE_DIR}/${FREQUENCIES[$i]}.rrd N:${BW}
    fi
done
echo 0 > /sys/module/dvb_core/parameters/dvb_powerdown_on_sleep
