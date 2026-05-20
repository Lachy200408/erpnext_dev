#!/bin/bash


function pmsg {
	echo "$1"
	local length=${#1}
	local i=0
	while [ $i -lt $length ]; do
		echo -n "_"
		i=$((i+1))
	done
	echo ""
}

function xend {
	pmsg "Exiting with error: $1"
	exit 1
}

function from_host_to_container {
	if command -v tar > /dev/null; then
		mkdir /home/frappe/extracted

		if [ -e './sites.tar' ]; then
			cp ./sites.tar /home/frappe/extracted/
			cd /home/frappe/extracted

			pmsg "Extracting sites.tar volume..."
			mkdir sites
			tar -xf ./sites.tar -C ./sites || xend "Couldnt extract sites volume"

			pmsg "Copying sites files..."
			cp -rf ./sites /home/frappe/frappe-bench/ || xend "Couldnt copy sites files"
		fi

		if [ -e './apps.tar' ]; then
			cp ./apps.tar /home/frappe/extracted/
			cd /home/frappe/extracted

			pmsg "Extracting apps.tar volume..."
			mkdir apps
			tar -xf ./apps.tar -C ./apps || xend "Couldnt extract apps volume"

			pmsg "Copying apps files..."
			cp -rf ./apps /home/frappe/frappe-bench/ || xend "Couldnt copy apps files"
		fi
	fi
}

function from_container_to_host {
	if command -v tar > /dev/null; then
		pmsg "Creating sites.tar volume..."
		cd /home/frappe/frappe-bench/sites
		tar -cf ./sites.tar ./ || xend "Couldnt create sites.tar volume"
		pmsg "Copying sites.tar volume..."
		cp -f ./sites.tar /home/frappe/volumes/

		pmsg "Creating apps.tar volume..."
		cd /home/frappe/frappe-bench/apps
		tar -cf ./apps.tar ./ || xend "Couldnt create apps.tar volume"
		pmsg "Copying apps.tar volume..."
		cp -f ./apps.tar /home/frappe/volumes/
	fi
}

if [ "$1" = "--from-host" ]; then
	from_host_to_container
else
	from_container_to_host
fi
