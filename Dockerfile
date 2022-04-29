FROM jonisj/csgo-sourcemod

## Surftimer
# https://github.com/surftimer/Surftimer-Official/releases

## Dependencies
# DHooks: https://github.com/peace-maker/DHooks2/releases/latest
# SteamWorks: https://github.com/KyleSanderson/SteamWorks/releases/latest
# SMLib: https://github.com/bcserv/smlib/tags
# Stripper: Source: https://forums.alliedmods.net/showthread.php?t=39439
# SMJansson: https://github.com/thraaawn/SMJansson

## Additional plugins
# Movement Unlocker: https://forums.alliedmods.net/showthread.php?t=255298

## Optional plugins
# Ultimate Map Chooser: https://github.com/Silenci0/UMC

ENV DHOOKS_VERSION="2.2.0-detours16" \ 
	STEAMWORKS_VERSION="1.2.3c" \
	SMLIB_VERSION="0.11" \
	STRIPPER_VERSION="1.2.2-git129" \
	SMJANSSON_VERSION="e808f0f73a90988b1bbb78289fed27a337b3f073" \
	SURFTIMER_VERSION="1.0.2" \
	UMC_VERSION="" \
	GENERATE_UMC_MAPCYCLE="" \
	DB_HOST="" \
	DB_PORT="3306" \
	DB_DATABASE="" \
	DB_USER="" \
	DB_PASS="" \
	MAPLIST_URL="" \
	ZONED_MAPS_ONLY="" \
	SRCDS_GAMEMODE=0 \
	SRCDS_GAMEMODE=0 

USER root
RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		unzip \
		default-mysql-client \
		bzip2 \
	&& rm -rf /var/lib/apt/lists/* 
USER steam

COPY "etc/" "${HOMEDIR}/"


CMD ["surf-entry.sh"]