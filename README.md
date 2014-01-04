CableStats
==========

Installation
------------

1. Clone repository
2. Install dependencies 
   Debian/Ubuntu: `apt-get install rrdtool dvbtune dvbsnoop`
3. Create RRDs: `./create_rrds.sh`
4. Edit crontab: `crontab -e`  

```
# Auslastung des Segments
* * * * * /root/cablestats/freq_collect.sh
*/5 * * * * /root/cablestats/cron.sh
```