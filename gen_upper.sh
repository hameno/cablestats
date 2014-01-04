#!/bin/bash

# Load configuration
source ./config.sh
# Constants
source ./constants.sh

for i in "${!TIMES[@]}"; do
    rrdtool graph ${BASE_DIR}/images/upper-${FILE_NAMES[$i]}.png \
    --title="${LOCATION} | Upper Channels | ${TIMES_NAMES[$i]}" \
    --vertical-label='kBit per Second' \
    -W "${HOST} @ $(date '+%F %T %Z')" \
    --start ${TIMES[$i]} \
    --slope-mode \
    -w 600 -h 150 \
    -l 0 -u 333720 \
    --color BACK#ededed \
    --color ARROW#0042ff \
    DEF:b594min=/root/rrd/594000000.rrd:bandwidth:MIN \
    DEF:b594avg=/root/rrd/594000000.rrd:bandwidth:AVERAGE \
    DEF:b594max=/root/rrd/594000000.rrd:bandwidth:MAX \
    DEF:b594last=/root/rrd/594000000.rrd:bandwidth:LAST \
    DEF:b602min=/root/rrd/602000000.rrd:bandwidth:MIN \
    DEF:b602avg=/root/rrd/602000000.rrd:bandwidth:AVERAGE \
    DEF:b602max=/root/rrd/602000000.rrd:bandwidth:MAX \
    DEF:b602last=/root/rrd/602000000.rrd:bandwidth:LAST \
    DEF:b666min=/root/rrd/666000000.rrd:bandwidth:MIN \
    DEF:b666avg=/root/rrd/666000000.rrd:bandwidth:AVERAGE \
    DEF:b666max=/root/rrd/666000000.rrd:bandwidth:MAX \
    DEF:b666last=/root/rrd/666000000.rrd:bandwidth:LAST \
    DEF:b674min=/root/rrd/674000000.rrd:bandwidth:MIN \
    DEF:b674avg=/root/rrd/674000000.rrd:bandwidth:AVERAGE \
    DEF:b674max=/root/rrd/674000000.rrd:bandwidth:MAX \
    DEF:b674last=/root/rrd/674000000.rrd:bandwidth:LAST \
    DEF:b682min=/root/rrd/682000000.rrd:bandwidth:MIN \
    DEF:b682avg=/root/rrd/682000000.rrd:bandwidth:AVERAGE \
    DEF:b682max=/root/rrd/682000000.rrd:bandwidth:MAX \
    DEF:b682last=/root/rrd/682000000.rrd:bandwidth:LAST \
    DEF:b690min=/root/rrd/690000000.rrd:bandwidth:MIN \
    DEF:b690avg=/root/rrd/690000000.rrd:bandwidth:AVERAGE \
    DEF:b690max=/root/rrd/690000000.rrd:bandwidth:MAX \
    DEF:b690last=/root/rrd/690000000.rrd:bandwidth:LAST \
    CDEF:bmin=b594min,b602min,b666min,b674min,b682min,b690min,ADDNAN,ADDNAN,ADDNAN,ADDNAN,ADDNAN \
    CDEF:bavg=b594avg,b602avg,b666avg,b674avg,b682avg,b690avg,ADDNAN,ADDNAN,ADDNAN,ADDNAN,ADDNAN \
    CDEF:bmax=b594max,b602max,b666max,b674max,b682max,b690max,ADDNAN,ADDNAN,ADDNAN,ADDNAN,ADDNAN \
    CDEF:blast=b594last,b602last,b666last,b674last,b682last,b690last,ADDNAN,ADDNAN,ADDNAN,ADDNAN,ADDNAN \
    AREA:333720#c9feb8 \
    STACK:27520#feb8b8 \
    COMMENT:"Separate Channel Statistics\n" \
    AREA:b594avg#0066ff:'594 Mhz      ' \
    GPRINT:b594avg:AVERAGE:"Avg %5.2lf %s   " \
    GPRINT:b594min:MIN:"Min %5.2lf %s   " \
    GPRINT:b594max:MAX:"Max %5.2lf %s" \
    GPRINT:b594last:LAST:"  Last %5.2lf %s\n" \
    STACK:b602avg#0042ff:'602 Mhz      ' \
    GPRINT:b602avg:AVERAGE:"Avg %5.2lf %s   " \
    GPRINT:b602min:MIN:"Min %5.2lf %s   " \
    GPRINT:b602max:MAX:"Max %5.2lf %s" \
    GPRINT:b602last:LAST:"  Last %5.2lf %s\n" \
    STACK:b666avg#c600ff:'666 Mhz      ' \
    GPRINT:b666avg:AVERAGE:"Avg %5.2lf %s   " \
    GPRINT:b666min:MIN:"Min %5.2lf %s   " \
    GPRINT:b666max:MAX:"Max %5.2lf %s" \
    GPRINT:b666last:LAST:"  Last %5.2lf %s\n" \
    STACK:b674avg#9000ff:'674 Mhz      ' \
    GPRINT:b674avg:AVERAGE:"Avg %5.2lf %s   " \
    GPRINT:b674min:MIN:"Min %5.2lf %s   " \
    GPRINT:b674max:MAX:"Max %5.2lf %s" \
    GPRINT:b674last:LAST:"  Last %5.2lf %s\n" \
    STACK:b682avg#6600ff:'682 Mhz      ' \
    GPRINT:b682avg:AVERAGE:"Avg %5.2lf %s   " \
    GPRINT:b682min:MIN:"Min %5.2lf %s   " \
    GPRINT:b682max:MAX:"Max %5.2lf %s" \
    GPRINT:b682last:LAST:"  Last %5.2lf %s\n" \
    STACK:b690avg#4200ff:'690 Mhz      ' \
    GPRINT:b690avg:AVERAGE:"Avg %5.2lf %s   " \
    GPRINT:b690min:MIN:"Min %5.2lf %s   " \
    GPRINT:b690max:MAX:"Max %5.2lf %s" \
    GPRINT:b690last:LAST:"  Last %5.2lf %s\n" \
    COMMENT:"Overall Channel Statistics\n" \
    GPRINT:bavg:AVERAGE:"                 Avg %5.2lf %s" \
    GPRINT:bmin:MIN:"   Min %5.2lf %s" \
    GPRINT:bmax:MAX:"   Max %5.2lf %s" \
    GPRINT:blast:LAST:" Last %5.2lf %s\n" \
    HRULE:333720#000000:'CAP (333.72 Mbit/s)':dashes=5 \
    LINE1:bmax#5f5f5f:"Peak-Bandwidth"
    echo ""
done