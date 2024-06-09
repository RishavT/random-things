#!/bin/bash

# Define the base IP parts
[ -z "$A" ] && A=192
[ -z "$B" ] && B=168
[ -z "$C" ] && C=22

echo "sweeping $A.$B.$C.*"
echo "" > ssh.txt
echo "" > reachable.txt

# Loop through all IPs from a.b.c.1 to a.b.c.254
for i in {1..254}; do
  # time to catch sigint
  sleep 0.01

  IP_ADDRESS="$A.$B.$C.$i"

  echo "pinging $IP_ADDRESS"
  # Ping the IP address to check if it's reachable
  ping -c 1 -W 1 -i 0.01 $IP_ADDRESS > /dev/null 2>&1

  if [ $? -eq 0 ]; then
    echo "IP address $IP_ADDRESS is reachable."
    
    # Resolve the hostname using nslookup
    HOSTNAME=$(nslookup $IP_ADDRESS | grep 'name = ' | awk '{print $4}' | sed 's/\.$//')

    if [ -z "$HOSTNAME" ]; then
      echo "Hostname for IP address $IP_ADDRESS could not be found."
    else
      echo "Hostname for IP address $IP_ADDRESS is $HOSTNAME."
    fi

    # Check if SSH port 22 is open
    nc -z -w 1 $IP_ADDRESS 22
    if [ $? -eq 0 ]; then
      echo "SSH port 22 is open on $IP_ADDRESS."
      echo "$IP_ADDRESS" >> ssh.txt
    else
      echo "SSH port 22 is not open on $IP_ADDRESS."
    fi

    echo "$IP_ADDRESS,$HOSTNAME" >> reachable.txt
  else
    echo "IP address $IP_ADDRESS is not reachable."
  fi
done
