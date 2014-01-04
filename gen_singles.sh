#!/bin/bash

# Load configuration
source ./config.sh
# Constants
source ./constants.sh

for i in "${!FREQUENCIES[@]}"; do
    for j in "${!TIMES[@]}"; do
        rrdtool graph ${BASE_DIR}/images/${FREQUENCIES[$i]}-${FILE_NAMES[$j]}.png \
        --title="${LOCATION} | ${FREQUENCIES[$i]} Hz - QAM256 - 6952kHz | ${TIMES_NAMES[$j]}" \
        --vertical-label='kBit per Second' \
        -W "$HOST @ $(date '+%F %T %Z')" \
        --slope-mode \
        -w 600 -h 150 \
        -l 0 -u 55620 \
        DEF:bmin=${BASE_DIR}/$1.rrd:bandwidth:MIN \
        DEF:bmax=${BASE_DIR}/$1.rrd:bandwidth:MAX \
        DEF:blast=${BASE_DIR}/$1.rrd:bandwidth:LAST \
        DEF:bavg=${BASE_DIR}/$1.rrd:bandwidth:AVERAGE \
        AREA:55620#c9feb8 \
        STACK:4380#feb8b8 \
        VDEF:allmax=bavg,MAXIMUM \
        VDEF:allavg=bavg,AVERAGE \
        VDEF:allmin=bavg,MINIMUM \
        VDEF:allstdev=bavg,STDEV \
        CDEF:lowtraf=bavg,13905,LE,bavg,UNKN,IF \
        CDEF:mediumtraf=bavg,41715,LE,bavg,UNKN,IF \
        CDEF:lowpct=bmin,55620,/,100,* \
        CDEF:avgpct=bavg,55620,/,100,* \
        CDEF:maxpct=bmax,55620,/,100,* \
        CDEF:lastpct=blast,55620,/,100,* \
        AREA:bavg#ff572a:"High Traffic (>80%)" \
        GPRINT:bmax:MAX:"                 Max\:%8.2lf %s" \
        GPRINT:maxpct:MAX:"%8.2lf (%%)  \n" \
        AREA:mediumtraf#ffb62a:"Medium Traffic (>20%)" \
        GPRINT:bavg:AVERAGE:"               Avg\:%8.2lf %s" \
        GPRINT:avgpct:AVERAGE:"%8.2lf (%%)  \n" \
        AREA:lowtraf#ffed2a:"Low Traffic (>0%)" \
        GPRINT:bmin:MIN:"                   Min\:%8.2lf %s" \
        GPRINT:lowpct:MIN:"%8.2lf (%%)  \n" \
        GPRINT:blast:LAST:"                                       Last\:%8.2lf %s" \
        GPRINT:lastpct:LAST:"%8.2lf (%%)  \n" \
        HRULE:55620#000000:"CAP (55.62 Mbit/s)":dashes=5 \
        LINE1:bmax#5f5f5f:"Peak-Bandwidth"
        echo ""
    done
done