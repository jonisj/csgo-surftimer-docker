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

			# Import default SurfTimer zones and maptiers
			mysql --defaults-file="${MYSQL_CONFIG}" < "$TEMPDIR/surftimer/scripts/mysql-files/ck_maptier.sql"
			mysql --defaults-file="${MYSQL_CONFIG}" < "$TEMPDIR/surftimer/scripts/mysql-files/ck_zones.sql"

			# Download and import updated zones and maptiers from Demented Gaming
			# Surftimer-Official Zones by Demented Gaming https://github.com/Kyli3Boi/Surftimer-Official-Zones
			dl_extract "zip" "demented-gaming-zones" "https://github.com/Kyli3Boi/Surftimer-Official-Zones/archive/e351d74a324d3b1523b37bb84e1714466a5475f8.zip"

			# Replace INSERT INTO statements with REPLACE INTO to overwrite default zones and maptiers
			sed -i -e 's/INSERT/REPLACE/g' $TEMPDIR/demented-gaming-zones/All/All_maptier.sql
			sed -i -e 's/INSERT/REPLACE/g' $TEMPDIR/demented-gaming-zones/All/All_zones.sql

			mysql --defaults-file="${MYSQL_CONFIG}" < $TEMPDIR/demented-gaming-zones/All/All_maptier.sql
			mysql --defaults-file="${MYSQL_CONFIG}" < $TEMPDIR/demented-gaming-zones/All/All_zones.sql

			# Install updated Stripper files from Demented Gaming
			# Surftimer-Official Stripper Config by Demented Gaming https://github.com/Kyli3Boi/Surftimer-Official-Stripper-Config
			dl_extract "zip" "demented-gaming-stripper" https://github.com/Kyli3Boi/Surftimer-Official-Stripper-Config/archive/29584f9a1b9bfcf35fd808a042d23fc96377785f.zip

			cp -R "$TEMPDIR/demented-gaming-stripper/addons/stripper/" "${STEAMAPPDIR}/${STEAMAPP}/addons/"

			;;
		*)
			echo ">>> SurfTimer is up-to-date"
			;;
	esac
	echo ''
}


