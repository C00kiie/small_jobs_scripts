#!/bin/bash
#
# Author: Tyr4n7
# This is a simple tool faciliate simple post-recon after gathering information about multiple domains,
# it simply works out the port scanning on port 80/443/8080/22/21
if [ $# -eq 0 ]
  then
    echo "$0 domain.txt output.txt";exit
fi

echo '#1 => closed, #0 -> opened';
echo 'IP | domain | port_80 | port 443 | port 8080 | port 22 | port 21';
counter=1;
total=$(wc -l $1 | awk '{print $1}')
for i in $(cat $1);
do

        echo -ne "[$counter / $total]\r"
        let counter=counter+1;
        ping_output=$(dig +short $i 2>/dev/null | grep -E "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
        if [ $? -eq 0 ]
                then
                        IP=$(echo $ping_output | grep -E "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
                        port_443=$(nc -zvw2 $i 443 2>/dev/null 1>/dev/null);
                        port_443_state=$?;

                        port_8080=$(nc -zvw2 192.168.0.1 8080 2>/dev/null 1>/dev/null);
                        port_8080_state=$?;

                        port_22=$(nc -zvw2 192.168.0.1 8080 2>/dev/null 1>/dev/null);
                        port_22_state=$?;

                        port_80=$(nc -zvw2 192.168.0.1 8080 2>/dev/null 1>/dev/null);
                        port_80_state=$?;

                        port_21=$(nc -zvw2 192.168.0.1 8080 2>/dev/null 1>/dev/null);
                        port_21_state=$?;
                        ip=$(echo $ping_output | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | head -n1);
                        output="$ip $i $port_80_state $port_443_state $port_8080_state $port_22_state $port_21_state";
                        echo $output;
                        echo $output >> $2;
        fi
done
