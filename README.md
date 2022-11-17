Dockerfile that builds a basic Surf server for CSGO. It uses jonisj/csgo-sourcemod as a base and installs SurfTimer and additional surf plugins to build a basic surf server.

## Required Environment Variables
SurfTimer requires a working database, so the following environment variables are required:
```dockerfile
# Provide your database details
DB_HOST:
DB_PORT:
DB_DATABASE:
DB_USER:
DB_PASS:
```

- SRCDS_TOKEN is required to be listed & reachable: [https://steamcommunity.com/dev/managegameservers](https://steamcommunity.com/dev/managegameservers)
- SRCDS_WORKSHOP_AUTHKEY is required to use the workshop: [https://steamcommunity.com/dev/apikey](https://steamcommunity.com/dev/apikey)
```dockerfile
SRCDS_TOKEN:
SRCDS_WORKSHOP_AUTHKEY:
```

It's also recommended to use "--cpuset-cpus=" to limit the game server to a specific core & thread.
The container will automatically update the game on startup, so if there is a game update just restart the container.

## Environment Variables
Feel free to overwrite these environment variables, using -e (--env):
```dockerfile
SRCDS_TOKEN="changeme" (value is is required to be listed & reachable, retrieve token here: https://steamcommunity.com/dev/managegameservers)
SRCDS_RCONPW="changeme" (value can be overwritten by csgo/cfg/server.cfg)
SRCDS_PW="changeme" (value can be overwritten by csgo/cfg/server.cfg)
SRCDS_PORT=27015
SRCDS_TV_PORT=27020
SRCDS_NET_PUBLIC_ADDRESS="0" (public facing ip, useful for local network setups)
SRCDS_IP="0" (local ip to bind)
SRCDS_FPSMAX=300
SRCDS_TICKRATE=64
SRCDS_MAXPLAYERS=14
SRCDS_STARTMAP="de_dust2"
SRCDS_REGION=3
SRCDS_MAPGROUP="mg_active"
SRCDS_GAMETYPE=0
SRCDS_GAMEMODE=1
SRCDS_HOSTNAME="SurfTimer Server"
SRCDS_WORKSHOP_START_MAP=0
SRCDS_HOST_WORKSHOP_COLLECTION=0
SRCDS_WORKSHOP_AUTHKEY="" (required to use host_workshop_map)
ADDITIONAL_ARGS="" (Pass additional arguments to srcds. Make sure to escape correctly!)

METAMOD_VERSION="1.11"
SOURCEMOD_VERSION="1.11"

# Required DB variables
DB_HOST=""
DB_PORT="3306"
DB_DATABASE=""
DB_USER=""
DB_PASS=""

# Surftimer Versions
DHOOKS_VERSION="2.2.0-detours16"
STEAMWORKS_VERSION="1.2.3c"
SMLIB_VERSION="0.11"
STRIPPER_URL="1.2.2-git129"
SMJANSSON_VERSION="e808f0f73a90988b1bbb78289fed27a337b3f073"
SURFTIMER_VERSION="1.1.3"

# Map syncing variables
SV_DOWNLOADURL="" (Your FastDL URL)
MAPLIST_URL=""
ZONED_MAPS_ONLY=""

```

## Map Synchronization with FastDL
In order to automatically synchronize maps between your FastDL and the server, you have to specify the following environment variables:

```dockerfile
SV_DOWNLOADURL: (Your FastDL URL)
MAPLIST_URL:  (URL to a file that contains a list of mapfiles on your FastDL server separated by a line change. Eg. surf_kitsune.bsp.bz2)
ZONED_MAPS_ONLY:  (If set, only maps that are zoned will be downloaded from the FastDL and used in the mapcycle)
```
