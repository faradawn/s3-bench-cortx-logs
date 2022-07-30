#!/bin/bash
# usage: sudo ./free_page_cache.sh 0.25

duration=$1 # in seconds
echo "Clearing page_cache per $duration s. Press [CTRL+C] to stop.."

while :
do
  sync; echo 1 > /proc/sys/vm/drop_caches
	sleep $duration
done

