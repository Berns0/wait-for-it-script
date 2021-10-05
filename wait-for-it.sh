#!/bin/sh
host="$1";
shift
cmd="$@";
curl_status=$(curl --write-out "%{http_code}\n" "$host" --output /dev/null --silent -L)
echo $curl_status;
while [ "$curl_status" != "200" ]; do 
echo "$host is not up yet - $curl_status"
sleep 10;
curl_status=$(curl --write-out "%{http_code}\n" "$host" --output /dev/null --silent -L)
done

echo "$host is up and running"

exec $cmd
