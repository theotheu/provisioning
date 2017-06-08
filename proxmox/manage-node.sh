#!/bin/bash

# This file is a quick command line interface to create, start, stop and delete Proxmox LXC
# Change the APINODE_USERNAME, APINODE_PASSWORD and CONTAINER_PASSWORD.
# Verify the IP address and gateway.
# Verify that the template is available at your storage.
# Modify other settings as you please.
# Run with
# ./manage_node -a [ create | start | stop | delete ]



# Requirements for Mac OS X
# `jq`
# Install with `brew install jq`

# @see https://pve.proxmox.com/wiki/Proxmox_VE_API


export APINODE=host.example.com
export TARGETNODE=proxmox
export APINODE_USERNAME=___YOUR_USERNAME___
export APINODE_PASSWORD=___YOUR_PASSWORD___
export CONTAINER_PASSWORD=___YOUR_CONTAINER_PASSWORD___
export VMID=100
export IP=145.74.104.100
export GATEWAY=145.74.104.254
export HOSTNAME=guest.example.com
export OSTEMPLATE="local:vztmpl/experiment-16.04-standard_16.04-1_amd64.tar.gz"


while getopts a: option
do
 case "${option}" in
	 a) ACTION=${OPTARG};;
	 s) START=${OPTARG};;
 esac
done

curl --silent --insecure --data "username=$APINODE_USERNAME@pam&password=$APINODE_PASSWORD" \
 https://$APINODE:8006/api2/json/access/ticket\
| jq --raw-output '.data.ticket' | sed 's/^/PVEAuthCookie=/' > cookie

curl --silent --insecure --data "username=$APINODE_USERNAME@pam&password=$APINODE_PASSWORD" \
 https://$APINODE:8006/api2/json/access/ticket \
| jq --raw-output '.data.CSRFPreventionToken' | sed 's/^/CSRFPreventionToken:/' > csrftoken


if [ $ACTION = "create" ]; then
	curl -insecure -k \
	 --cookie "$(<cookie)" --header "$(<csrftoken)" -X POST\
	 --data-urlencode net0="name=myct0,bridge=vmbr0,ip=$IP/24,gw=$GATEWAY" \
	 --data-urlencode ostemplate="$OSTEMPLATE" \
	 --data-urlencode memory="4512" \
	 --data-urlencode swap="1512" \
	 --data-urlencode cpulimit="8" \
	 --data-urlencode cpuunits="8024" \
	 --data-urlencode rootfs="local-lvm:32" \
	 --data-urlencode password="$CONTAINER_PASSWORD" \
	 --data-urlencode hostname="$HOSTNAME" \
	 --data vmid=$VMID \
	 https://$APINODE:8006/api2/json/nodes/$TARGETNODE/lxc
elif [ $ACTION = "delete" ]; then
	curl -insecure -k \
		 --cookie "$(<cookie)" --header "$(<csrftoken)" -X DELETE \
		 https://$APINODE:8006/api2/json/nodes/$TARGETNODE/lxc/$VMID		 
elif [ $ACTION = "start" ]; then
	echo /api2/json/nodes/{node}/lxc/{vmid}/status/start
	curl -insecure -k \
		 --cookie "$(<cookie)" --header "$(<csrftoken)" -X POST \
		 https://$APINODE:8006/api2/json/nodes/$TARGETNODE/lxc/$VMID/status/start
elif [ $ACTION = "stop" ]; then
	echo /api2/json/nodes/{node}/lxc/{vmid}/status/start
	curl -insecure -k \
		 --cookie "$(<cookie)" --header "$(<csrftoken)" -X POST \
		 https://$APINODE:8006/api2/json/nodes/$TARGETNODE/lxc/$VMID/status/stop
fi


echo
