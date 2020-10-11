#!/bin/bash
#
# Author: tyr4n7
# This is only compatiable with bash 4.0 or higher since it uses an associative hashmap
# can be used to count entity of a certain kind, it cuts the first field and counts it
# for example to count the number of requests an IP did on apache server
# we can just `cat apache_log | bash count_occurences.sh` 


declare -A hashmap

for i in $(cat $i | cut -d' ' -f1); # get stdin in a 1337 way
do
	let hashmap[$i]++;
done

counter=0;
echo entity: count
for j in "${!hashmap[@]}";
do
	echo "$j:${hashmap[$j]}"
done
