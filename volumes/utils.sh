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