#!/bin/sh

# Load configuration
source ./config.sh
# Constants
source ./constants.sh

for i in "${!FREQUENCIES[@]}"; do
    rrdtool create ${FREQUENCIES[$i]}.rrd
    --step 60 \
    DS:bandwidth:GAUGE:105:0:U \
    RRA:MIN:0.5:5:288 \
    RRA:MIN:0.5:30:336 \
    RRA:MIN:0.5:120:372 \
    RRA:MIN:0.5:1440:366 \
    RRA:MIN:0.5:2880:732 \
    RRA:MAX:0.5:5:288 \
    RRA:MAX:0.5:30:336 \
    RRA:MAX:0.5:120:372 \
    RRA:MAX:0.5:1440:366 \
    RRA:MAX:0.5:2880:732 \
    RRA:AVERAGE:0.5:5:288 \
    RRA:AVERAGE:0.5:30:336 \
    RRA:AVERAGE:0.5:120:372 \
    RRA:AVERAGE:0.5:1440:366 \
    RRA:AVERAGE:0.5:2880:732 \
    RRA:LAST:0.5:5:288 \
    RRA:LAST:0.5:30:336 \
    RRA:LAST:0.5:120:372 \
    RRA:LAST:0.5:1440:366 \
    RRA:LAST:0.5:2880:732
done
