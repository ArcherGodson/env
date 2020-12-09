#!/usr/bin/env bash
function getip() {
logfile="/var/log/messages.log"
#return 1
for (( i=1000; i<="$(< $logfile wc -l)"; i=$(($i*10)) ));
do
  ip=$(tail -$i $logfile | grep -o "net_addr_ptp_v4_add: [^ ]*"| tail -1 | grep -o "[0-9.]*$")
  if [ ! -z "$ip" ]; then
#    echo "$i"
    echo "$ip"
    return 0
  fi
done
return 1
}

ovpnip=$(getip)
#echo "$ovpnip"
if [ -z $ovpnip ]; then 
  echo "OpenVPN IP not found"
  exit 1
fi
if ip a sh | grep -q "$ovpnip"; then
#if echo 123 | grep -q "$ovpnip"; then
  echo "$ovpnip"
else 
  echo "OpenVPN IP: '$ovpnip' is not found on 'ip address show'"
fi
exit 0
