#! /bin/bash

WS_HELP="

  ${BLUE}Bienvenido a erpnext_dev workspace${NC}
  ==================================

  ${BLUE}Funciones disponibles:${NC}
  - ${GREEN}comp${NC}: Docker compose alias
  - ${GREEN}cbash${NC}: Executes bash inside the given service's container
  - ${GREEN}cp_apps${NC}: Copies apps folder from the container to the local workspace
  - ${GREEN}cp_sites${NC}: Copies sites folder from the container to the local workspace
  - ${GREEN}cp_logs${NC}: Copies logs folder from the container to the local workspace
  - ${GREEN}cp_files${NC}: Copies all the folders from the container to the local workspace

"

function cbash {
	comp exec $1 bash
}

function cp_apps {
	comp cp backend:/home/frappe/frappe-bench/apps ./
}

function cp_logs {
	comp cp backend:/home/frappe/frappe-bench/logs ./
}

function cp_sites {
	comp cp backend:/home/frappe/frappe-bench/sites ./
}

function cp_files {
	cp_apps
	cp_sites
	cp_logs
}

function comp {
	sudo docker compose -f ./pwd.yml $@
}

function wshelp {
  printf "$WS_HELP"
}

wshelp
