#!/bin/bash
set -e

# Load functions
source ./functions/cleanup.sh
source ./functions/dlDependencies.sh
source ./functions/dlMaps.sh
source ./functions/installSurfTimer.sh
source ./functions/installUMC.sh
source ./functions/prepareDbConfig.sh

## Create a temp directory and setup cleaning
TEMPDIR="$(mktemp -d)"
trap cleanup EXIT

# Setup server
prepareMySQLClientConfigs
downloadDependencies
installSurftimer
downloadMaps
installUMC

cleanup

echo "Starting server..."
echo "------------------------------------------"

bash "./start.sh"