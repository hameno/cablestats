CableStats
==========

Installation
------------

1. Verzeichnisse erstellen und Dateien nach /root/rrd entpacken
/////////////////////////////////////////////////////

mkdir /root/rrd
cd /root/rrd
tar xfvz kdg.tgz

2. RRD erstellen (8 Mal fuer jede Frequenz)
/////////////////////////////////////////////////////

#!/bin/sh
freqs="546000000 554000000 562000000 570000000 578000000 586000000 594000000 602000000"
for freq in $freqs
do
rrdtool create $freq.rrd --step=60 \
DS:bandwidth:GAUGE:105:0:55620000 \
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

rrdtool create snr.rrd --step=60 \
DS:546:GAUGE:105:0:U \
DS:554:GAUGE:105:0:U \
DS:562:GAUGE:105:0:U \
DS:570:GAUGE:105:0:U \
DS:578:GAUGE:105:0:U \
DS:586:GAUGE:105:0:U \
DS:594:GAUGE:105:0:U \
DS:602:GAUGE:105:0:U \
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

3. Crontab hinzufuegen
----------------------

# Auslastung des Segments
* * * * * /root/rrd/freq_collect.sh
*/5 * * * * /root/rrd/cron_day.sh
*/30 * * * * /root/rrd/cron_week.sh
0 */2 * * * /root/rrd/cron_month.sh
0 0 * * * /root/rrd/cron_year.sh