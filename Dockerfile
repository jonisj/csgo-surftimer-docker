FROM jonisj/csgo-sourcemod

ENV STRIPPER_VERSION="1.2.2" \
	MOVEMEMNTUNLOCK_VERSION="141520" \
	SURFTIMERMC_VERSION="2.0.2" \
	MOMENTUMFIX_VERSION="1.1.5" \
	RNGFIX_VERSION="1.1.2d" \
	HEADBUGFIX_VERSION="1.0.0" \
	PUSHFIX_VERSION="1.0.0" \
	CROUCHBOOSTFIX_VERSION="2.0.2" \
	NORMALIZEDSPEED_VERSION="master" \
	SURFTIMER_VERSION="1.1.3" \
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

CMD ["surf_entry.sh"]