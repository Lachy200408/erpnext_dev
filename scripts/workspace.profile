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
  - ${GREEN}backup${NC}: Docker compose for the backup container
  - ${GREEN}backup-db${NC}: Backups the database
  - ${GREEN}sync-db${NC}: Syncs the database

"

function comp {
	sudo docker compose -f ./pwd.yml $@
}

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

function backup {
	sudo docker compose -f ./backup.yml $@
}

function backup-db {
	sudo docker run --rm \
		-v erpnext_dev_db-data:/var/lib/mysql \
		-v $(pwd)/volumes:/db_volume \
		ubuntu:22.04 \
		bash -c "cd /db_volume && ./copy_db.sh"
}

function sync-db {
	sudo docker run --rm \
		-v erpnext_dev_db-data:/var/lib/mysql \
		-v $(pwd)/volumes:/db_volume \
		ubuntu:22.04 \
		bash -c "cd /db_volume && ./copy_db.sh --from-host"
}

function wshelp {
  printf "$WS_HELP"
}

wshelp
