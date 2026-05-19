#!/bin/bash


function xend {
	echo "Exiting with error: $1"
	exit 1
}

if command -v tar > /dev/null; then
	echo "Extracting mysql.tar volume"
  tar -xf ./mysql.tar ./mysql || xend "Couldnt extract mysql volume"

	echo "Extracting sites.tar volume"
	tar -xf ./sites.tar ./sites || xend "Couldnt extract sites volume"
fi

for file in "$@"; do
  echo "Copying $file"
  docker cp "$file" frappe:/home/frappe/frappe-bench/sites/assets/erpnext/public/files/
done