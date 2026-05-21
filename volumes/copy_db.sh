#!/bin/bash

source ./utils.sh

function from_host_to_container {
	if command -v tar > /dev/null; then
		cd /db_volume

		if [ -e './mysql.tar' ]; then
			mkdir /mysql

			pmsg "Extracting mysql.tar volume..."
			tar -xf /db_volume/mysql.tar -C /mysql || xend "Couldnt extract mysql volume"

			chown -R 999:999 /mysql
			
			pmsg "Copying mysql files..."
			cp -rf /mysql /var/lib/ || xend "Couldnt copy db files"
		fi
	fi
}

function from_container_to_host {
	if command -v tar > /dev/null; then
		cd /var/lib/mysql
		
		pmsg "Creating mysql.tar volume..."
		tar -cf ./mysql.tar ./ || xend "Couldnt create mysql.tar volume"
		
		pmsg "Copying mysql.tar volume..."
		cp ./mysql.tar /db_volume/
	fi
}

if [ "$1" = "--from-host" ]; then
	from_host_to_container
else
	from_container_to_host
fi