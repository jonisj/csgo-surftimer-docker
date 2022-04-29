
function installUMC {
	if [ ! -z "$UMC_VERSION" ]; then
		echo ">>>> Installing Ultimate Map Chooser"
		
		case "$(checkVersion "umc" "${UMC_VERSION}")" in
			"install" | "update")
				echo ">> Installing UMC ${UMC_VERSION}"
				getTarredDependency "$TEMPDIR" "umc" "https://github.com/Silenci0/UMC/archive/${UMC_VERSION}.tar.gz"

				# Copy compiled plugins
				# https://github.com/Silenci0/UMC/wiki#umc-modules
				cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-core.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-adminmenu.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-rockthevote.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-timelimits.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-votecommand.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-endvote-warnings.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-endvote.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-mapcommands.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-nominate.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				#cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-playercountmonitor.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				#cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-playerlimits.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				#cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-postexclude.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				#cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-prefixexclude.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				#cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-randomcycle.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				#cp -R "$TEMPDIR/umc/UMC-master/addons/sourcemod/plugins/nativevotes.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				#cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-weight.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				#cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-maprate-reweight.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				#cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-nativevotes.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
				#cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/plugins/umc-echonextmap.smx" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"

				# Translations
				cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/translations/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/translations/"

				echo "$SURFTIMER_VERSION" > "${DEPVERSIONDIR}/umc.version"
				;;&

			"install")
				# Copy configs only during install
				cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/addons/sourcemod/configs/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/configs/"
				cp -R "$TEMPDIR/umc/UMC-${UMC_VERSION}/cfg/"* "${STEAMAPPDIR}/${STEAMAPP}/cfg/"
				;;
			*)
				echo ">> UMC is up-to-date"
				;;
		esac

		if [ ! -z "$GENERATE_UMC_MAPCYCLE" ]; then
			echo ">> Generating umc_mapcycle.txt"

			local -r mapcycle="${STEAMAPPDIR}/${STEAMAPP}/mapcycle.txt"

			if [ ! -f "$mapcycle" ]; then
				echo "mapcycle.txt not found when trying to create umc-mapcycle!"
				exit -1
			fi

			# Start the umc_mapcycle
			local -r umc_mapcycle="$TEMPDIR/umc/umc_mapcycle.txt"
			cat > "$umc_mapcycle" <<-EOF
			"umc_mapcycle"
			{
			EOF

			# Get all zoned maps and their info from the database
			local -r query="""
			SELECT z.mapname, COUNT(CASE WHEN z.zonetype = 3 THEN 1 ELSE NULL END)+1, IFNULL(t.tier, '?'), count(DISTINCT z.zonegroup)-1
			FROM ck_zones z
			LEFT JOIN ck_maptier t
			ON z.mapname = t.mapname
			GROUP BY z.mapname
			ORDER BY t.tier, z.mapname ASC;
			"""

			# Make a temp variable for checking tiers
			local old_tier=""

			# loop through all the maps
			mysql --defaults-file="$MYSQL_CONFIG" --batch -se "$query" | while read mapname stages tier bonuses; do

				#  Make sure the map is in the mapcycle
				if [ ! -z "$(grep "$mapname" "$mapcycle")" ]; then

					# Check if the map is in a new tier
					if [ "$old_tier" != "$tier" ]; then

						# Close earlier tier, if this is a new one
						if [ ! -z "$old_tier" ]; then
							echo -e '\t}' >> "$umc_mapcycle"
						fi
						echo -e '\t"Tier '"$tier"'"' >> "$umc_mapcycle"
						echo -e '\t{' >> "$umc_mapcycle"


						old_tier=$tier
					fi

					# Label for stages & bonuses
					stage_label=" L"
					if [ "$stages" -gt 1 ]; then
						stage_label=" ${stages}S"
					fi

					bonus_label=""
					if [ "$bonuses" -gt 0 ]; then
						bonus_label=" ${bonuses}B"
					fi

					echo -e '\t\t"'$mapname'"		{ "display"		"'$mapname' (T'$tier''$stage_label''$bonus_label')" }' >> "$umc_mapcycle"

				fi
			done

			# Close file
			cat >> "$umc_mapcycle" <<-EOF
				}
			}
			EOF

			mv $umc_mapcycle "${STEAMAPPDIR}/${STEAMAPP}/"
		fi
	fi
}
