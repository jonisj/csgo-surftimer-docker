#!/bin/bash
set -e

source ./functions/helpers.sh
source ./functions/check_version.sh
source ./functions/prepare_db_config.sh
source ./functions/install_surftimer.sh
source ./functions/dl_extras.sh
source ./functions/dl_maps.sh
source ./functions/cleanup.sh

## Create a temp directory and setup cleaning
TEMPDIR="$(mktemp -d)"
trap cleanup EXIT

# Setup server
prepare_mysql_client_configs
install_surftimer
download_extras
download_maps

cleanup

echo "Starting server..."
echo "------------------------------------------"

bash "./start.sh"