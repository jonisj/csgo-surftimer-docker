## Install SurfTimer
# https://github.com/surftimer/Surftimer-Official
function install_surftimer {
	echo ">>>> Installing SurfTimer"
	case "$(check_version "surftimer" "${SURFTIMER_VERSION}")" in
		"install" | "update")
			echo ">> Installing SurfTimer ${SURFTIMER_VERSION}"
			# Folder structure and files in releases changes every time,
			# don't bother trying to make anything fancy here
			dl_extract "zip" "surftimer" "https://github.com/surftimer/SurfTimer/releases/download/1.1.3.1/SurfTimer.1.1.3.1.912.01b3153.SM1.11.zip"

			cp -R "$TEMPDIR/surftimer/addons/sourcemod/plugins/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
			cp -Rn "$TEMPDIR/surftimer/addons/sourcemod/configs/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/configs/"
			cp -R "$TEMPDIR/surftimer/addons/sourcemod/translations/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/translations/"
			cp -R "$TEMPDIR/surftimer/addons/sourcemod/gamedata/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/gamedata/"
			cp -R "$TEMPDIR/surftimer/addons/stripper/" "${STEAMAPPDIR}/${STEAMAPP}/addons/"

			cp -Rn "$TEMPDIR/surftimer/cfg/"* "${STEAMAPPDIR}/${STEAMAPP}/cfg/"
			cp -R "$TEMPDIR/surftimer/maps/"* "${STEAMAPPDIR}/${STEAMAPP}/maps/"
			cp -R "$TEMPDIR/surftimer/sound/"* "${STEAMAPPDIR}/${STEAMAPP}/sound/"

			echo "$SURFTIMER_VERSION" > "${DEPVERSIONDIR}/surftimer.version"
			;;&

		"install")
			#  Run MySQL scripts on first install
			mysql --defaults-file="${MYSQL_CONFIG}" < "$TEMPDIR/surftimer/scripts/mysql-files/fresh_install.sql"
			mysql --defaults-file="${MYSQL_CONFIG}" < "$TEMPDIR/surftimer/scripts/mysql-files/ck_maptier.sql"
			mysql --defaults-file="${MYSQL_CONFIG}" < "$TEMPDIR/surftimer/scripts/mysql-files/ck_zones.sql"
			;;
		*)
			echo ">> SurfTimer is up-to-date"
			;;
	esac
	echo ''
}
