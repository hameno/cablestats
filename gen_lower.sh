#!/bin/bash

# Load configuration
source ./config.sh
# Constants
source ./constants.sh

for i in "${!TIMES[@]}"; do
    rrdtool graph ${BASE_DIR}/images/lower-${FILE_NAMES[$i]}.png \
    --title="${LOCATION} | Lower Channels | ${TIMES_NAMES[$i]}" \
    --vertical-label='kBit per Second' \
    -W "${HOST} @ $(date '+%F %T %Z')" \
    --start ${TIMES[$i]} \
    --slope-mode \
    -w 600 -h 150 \
    -l 0 -u 333720 \
    --color BACK#ededed \
    --color ARROW#ff6c00 \
    DEF:b546min=${BASE_DIR}/546000000.rrd:bandwidth:MIN \
    DEF:b546avg=${BASE_DIR}/546000000.rrd:bandwidth:AVERAGE \
    DEF:b546max=${BASE_DIR}/546000000.rrd:bandwidth:MAX \
    DEF:b546last=${BASE_DIR}/546000000.rrd:bandwidth:LAST \
    DEF:b554min=${BASE_DIR}/554000000.rrd:bandwidth:MIN \
    DEF:b554avg=${BASE_DIR}/554000000.rrd:bandwidth:AVERAGE \
    DEF:b554max=${BASE_DIR}/554000000.rrd:bandwidth:MAX \
    DEF:b554last=${BASE_DIR}/554000000.rrd:bandwidth:LAST \
    DEF:b562min=${BASE_DIR}/562000000.rrd:bandwidth:MIN \
    DEF:b562avg=${BASE_DIR}/562000000.rrd:bandwidth:AVERAGE \
    DEF:b562max=${BASE_DIR}/562000000.rrd:bandwidth:MAX \
    DEF:b562last=${BASE_DIR}/562000000.rrd:bandwidth:LAST \
    DEF:b570min=${BASE_DIR}/570000000.rrd:bandwidth:MIN \
    DEF:b570avg=${BASE_DIR}/570000000.rrd:bandwidth:AVERAGE \
    DEF:b570max=${BASE_DIR}/570000000.rrd:bandwidth:MAX \
    DEF:b570last=${BASE_DIR}/570000000.rrd:bandwidth:LAST \
    DEF:b578min=${BASE_DIR}/578000000.rrd:bandwidth:MIN \
    DEF:b578avg=${BASE_DIR}/578000000.rrd:bandwidth:AVERAGE \
    DEF:b578max=${BASE_DIR}/578000000.rrd:bandwidth:MAX \
    DEF:b578last=${BASE_DIR}/578000000.rrd:bandwidth:LAST \
    DEF:b586min=${BASE_DIR}/586000000.rrd:bandwidth:MIN \
    DEF:b586avg=${BASE_DIR}/586000000.rrd:bandwidth:AVERAGE \
    DEF:b586max=${BASE_DIR}/586000000.rrd:bandwidth:MAX \
    DEF:b586last=${BASE_DIR}/586000000.rrd:bandwidth:LAST \
    CDEF:bmin=b546min,b554min,b562min,b570min,b578min,b586min,ADDNAN,ADDNAN,ADDNAN,ADDNAN,ADDNAN \
    CDEF:bavg=b546avg,b554avg,b562avg,b570avg,b578avg,b586avg,ADDNAN,ADDNAN,ADDNAN,ADDNAN,ADDNAN \
    CDEF:bmax=b546max,b554max,b562max,b570max,b578max,b586max,ADDNAN,ADDNAN,ADDNAN,ADDNAN,ADDNAN \
    CDEF:blast=b546last,b554last,b562last,b570last,b578last,b586last,ADDNAN,ADDNAN,ADDNAN,ADDNAN,ADDNAN \
    AREA:333720#c9feb8 \
    STACK:27520#feb8b8 \
    COMMENT:"Separate Channel Statistics\n" \
    AREA:b546avg#fffc00:'546 Mhz      ' \
    GPRINT:b546avg:AVERAGE:"Avg %5.2lf %s   " \
    GPRINT:b546min:MIN:"Min %5.2lf %s   " \
    GPRINT:b546max:MAX:"Max %5.2lf %s" \
    GPRINT:b546last:LAST:"  Last %5.2lf %s\n" \
    STACK:b554avg#ffc600:'554 Mhz      ' \
    GPRINT:b554avg:AVERAGE:"Avg %5.2lf %s   " \
    GPRINT:b554min:MIN:"Min %5.2lf %s   " \
    GPRINT:b554max:MAX:"Max %5.2lf %s" \
    GPRINT:b554last:LAST:"  Last %5.2lf %s\n" \
    STACK:b562avg#ffa200:'562 Mhz      ' \
    GPRINT:b562avg:AVERAGE:"Avg %5.2lf %s   " \
    GPRINT:b562min:MIN:"Min %5.2lf %s   " \
    GPRINT:b562max:MAX:"Max %5.2lf %s" \
    GPRINT:b562last:LAST:"  Last %5.2lf %s\n" \
    STACK:b570avg#ff6c00:'570 Mhz      ' \
    GPRINT:b570avg:AVERAGE:"Avg %5.2lf %s   " \
    GPRINT:b570min:MIN:"Min %5.2lf %s   " \
    GPRINT:b570max:MAX:"Max %5.2lf %s" \
    GPRINT:b570last:LAST:"  Last %5.2lf %s\n" \
    STACK:b578avg#00c6ff:'578 Mhz      ' \
    GPRINT:b578avg:AVERAGE:"Avg %5.2lf %s   " \
    GPRINT:b578min:MIN:"Min %5.2lf %s   " \
    GPRINT:b578max:MAX:"Max %5.2lf %s" \
    GPRINT:b578last:LAST:"  Last %5.2lf %s\n" \
    STACK:b586avg#0090ff:'586 Mhz      ' \
    GPRINT:b586avg:AVERAGE:"Avg %5.2lf %s   " \
    GPRINT:b586min:MIN:"Min %5.2lf %s   " \
    GPRINT:b586max:MAX:"Max %5.2lf %s" \
    GPRINT:b586last:LAST:"  Last %5.2lf %s\n" \
    COMMENT:"Overall Channel Statistics\n" \
    GPRINT:bavg:AVERAGE:"                 Avg %5.2lf %s" \
    GPRINT:bmin:MIN:"   Min %5.2lf %s" \
    GPRINT:bmax:MAX:"   Max %5.2lf %s" \
    GPRINT:blast:LAST:"  Last %5.2lf %s\n" \
    HRULE:333720#000000:'CAP (333.72 Mbit/s)':dashes=5 \
    LINE1:bmax#5f5f5f:"Peak-Bandwidth"
    echo ""
done