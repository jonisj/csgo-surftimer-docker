## Install SurfTimer
# https://github.com/surftimer/Surftimer-Official
function install_surftimer {
	echo ">>>> Checking SurfTimer version"
	case "$(check_version "surftimer" "${SURFTIMER_VERSION}")" in
		"install" | "update")
			echo ">>> Installing SurfTimer ${SURFTIMER_VERSION}"

			# Folder structure and files in releases changes every time,
			# don't bother trying to make anything fancy here
			dl_extract "zip" "surftimer" "https://github.com/surftimer/SurfTimer/releases/download/1.1.3.1/SurfTimer.1.1.3.1.912.01b3153.SM1.11.zip"

			cp -R "$TEMPDIR/surftimer/addons/sourcemod/plugins/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
			cp -Rn "$TEMPDIR/surftimer/addons/sourcemod/configs/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/configs/"
			cp -R "$TEMPDIR/surftimer/addons/sourcemod/translations/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/translations/"
			cp -R "$TEMPDIR/surftimer/addons/sourcemod/gamedata/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/gamedata/"
			cp -Rn "$TEMPDIR/surftimer/addons/stripper/" "${STEAMAPPDIR}/${STEAMAPP}/addons/"

			cp -Rn "$TEMPDIR/surftimer/cfg/"* "${STEAMAPPDIR}/${STEAMAPP}/cfg/"
			cp -R "$TEMPDIR/surftimer/maps/"* "${STEAMAPPDIR}/${STEAMAPP}/maps/"
			cp -R "$TEMPDIR/surftimer/sound/"* "${STEAMAPPDIR}/${STEAMAPP}/sound/"

			echo "$SURFTIMER_VERSION" > "${PLUGINVERDIR}/surftimer.version"
			;;&

		"install")
			echo ">>> Initializing SurfTimer Database"

			#  Run MySQL scripts on first install
			mysql --defaults-file="${MYSQL_CONFIG}" < "$TEMPDIR/surftimer/scripts/mysql-files/fresh_install.sql"

			# Download and import combined maptier and zone data
			mkdir -p "${TEMPDIR}/db-data"

			wget -q "https://github.com/jonisj/SurfTimer-Combined-Zones-and-Maptiers/releases/download/v1.0.0/ck_maptier.sql" -P "${TEMPDIR}/db-data/"
			wget -q "https://github.com/jonisj/SurfTimer-Combined-Zones-and-Maptiers/releases/download/v1.0.0/ck_zones.sql" -P "${TEMPDIR}/db-data/"

			mysql --defaults-file="${MYSQL_CONFIG}" < "${TEMPDIR}/db-data/ck_maptier.sql"
			mysql --defaults-file="${MYSQL_CONFIG}" < "${TEMPDIR}/db-data/ck_zones.sql"

			# Install updated Stripper files from Demented Gaming
			# Surftimer-Official Stripper Config by Demented Gaming https://github.com/Kyli3Boi/Surftimer-Official-Stripper-Config
			dl_extract "zip" "demented-gaming-stripper" https://github.com/Kyli3Boi/Surftimer-Official-Stripper-Config/archive/29584f9a1b9bfcf35fd808a042d23fc96377785f.zip

			cp -R "$TEMPDIR/demented-gaming-stripper/Surftimer-Official-Stripper-Config-29584f9a1b9bfcf35fd808a042d23fc96377785f/addons/stripper/" "${STEAMAPPDIR}/${STEAMAPP}/addons/"

			;;
		*)
			echo ">>> SurfTimer is up-to-date"
			;;
	esac
	echo ''
}


