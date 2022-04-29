## Install SurfTimer
function installSurftimer {
	echo ">>>> Installing SurfTimer"
	case "$(checkVersion "surftimer" "${SURFTIMER_VERSION}")" in
		"install" | "update")
			echo ">> Installing SurfTimer ${SURFTIMER_VERSION}"
			getTarredDependency "$TEMPDIR" "surftimer" "https://github.com/surftimer/Surftimer-Official/archive/${SURFTIMER_VERSION}.tar.gz"
			
			# Download compiled .smx
			wget -q "https://github.com/surftimer/Surftimer-Official/releases/download/${SURFTIMER_VERSION}/discord_api.smx" -O "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/discord_api.smx"
			wget -q "https://github.com/surftimer/Surftimer-Official/releases/download/${SURFTIMER_VERSION}/SurfTimer.smx" -O "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/SurfTimer.smx"
			
			# Copy extra files
			cp -Rn "$TEMPDIR/surftimer/Surftimer-Official-${SURFTIMER_VERSION}/addons/stripper/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/stripper/"
			cp -Rn "$TEMPDIR/surftimer/Surftimer-Official-${SURFTIMER_VERSION}/addons/sourcemod/configs/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/configs/"
			cp -Rn "$TEMPDIR/surftimer/Surftimer-Official-${SURFTIMER_VERSION}/cfg/"* "${STEAMAPPDIR}/${STEAMAPP}/cfg/"
			
			cp -R "$TEMPDIR/surftimer/Surftimer-Official-${SURFTIMER_VERSION}/addons/sourcemod/translations/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/translations/"
			cp -R "$TEMPDIR/surftimer/Surftimer-Official-${SURFTIMER_VERSION}/maps/"* "${STEAMAPPDIR}/${STEAMAPP}/maps/"
			cp -R "$TEMPDIR/surftimer/Surftimer-Official-${SURFTIMER_VERSION}/sound/"* "${STEAMAPPDIR}/${STEAMAPP}/sound/"

			echo "$SURFTIMER_VERSION" > "${DEPVERSIONDIR}/surftimer.version"
			;;&

		"install")
			##  Run MySQL scripts on first install
			mysql --defaults-file="$MYSQL_CONFIG" < "$TEMPDIR/surftimer/Surftimer-Official-${SURFTIMER_VERSION}/scripts/mysql-files/ck_maptier.sql"
			mysql --defaults-file="$MYSQL_CONFIG" < "$TEMPDIR/surftimer/Surftimer-Official-${SURFTIMER_VERSION}/scripts/mysql-files/ck_zones.sql"

			# Overwrite default Stripper: Source global_config.cfg
			cp "$TEMPDIR/surftimer/Surftimer-Official-${SURFTIMER_VERSION}/addons/stripper/global_filters.cfg" "${STEAMAPPDIR}/${STEAMAPP}/addons/stripper/global_filters.cfg"
			;;
		*)
			echo ">> SurfTimer is up-to-date"
			;;
	esac
	echo ''
}