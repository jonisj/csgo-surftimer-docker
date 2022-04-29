## Download maps
function downloadMaps {
	# If fastDL URL and a maplist URL is set, download maps
	if [ ! -z "$SV_DOWNLOADURL" ] && [ ! -z "$MAPLIST_URL" ]; then
		echo ">>>> Downloading Maps & Setting mapcycle.txt"

		local -r maplist_dir="$TEMPDIR/maplist"
		local -r maps_download_dir="$maplist_dir/maps"
		local -r remote_maplist="$maplist_dir/maps.txt"
		local -r mapcycle="$maplist_dir/mapcycle.txt"

		mkdir -p "$maps_download_dir"
		touch "$mapcycle"

		# Download maplist
		wget -qO- "$MAPLIST_URL" > "$remote_maplist"
		
		if [ ! -z "$(grep ".bsp" "$remote_maplist")" ]; then

			if [ ! -z "$ZONED_MAPS_ONLY" ]; then
				# Get all zoned maps from the databse
				zoned_maps=($(mysql --defaults-file="$MYSQL_CONFIG" -se "SELECT mapname FROM ck_zones GROUP BY mapname ORDER BY mapname ASC;"))
			fi

			# Loop through the maplist 
			while IFS="" read -r map || [ -n "$map" ]
			do
				# Get map name without extension
				map_name=$(echo "${map%%.*}")

				if [ ! -z "$ZONED_MAPS_ONLY" ]; then
					# Check if the map is not found from the list of zoned maps
					if [[ ! " ${zoned_maps[@]} " =~ " ${map_name} " ]]; then
						echo "> $map_name not zoned. Skipping."
						continue;
					fi
				fi

				# Check if the map is found on the volume
				if [ ! -f "${STEAMAPPDIR}/${STEAMAPP}/maps/$map_name.bsp" ]; then

					# Download the map
					echo "> Downloading $map"
					wget -q "$SV_DOWNLOADURL/maps/$map" -P "${maps_download_dir}"

					if [[ $map == *.bz2 ]]; then
						echo "> Decompressing"
						bunzip2 -q "${maps_download_dir}/$map"
					fi

					mv "${maps_download_dir}/$map_name.bsp" "${STEAMAPPDIR}/${STEAMAPP}/maps/"
				fi

				# Add map to the mapcycle
				echo $map_name >> "$mapcycle"
			done < "$remote_maplist"

			# Copy mapcycle
			cp "$mapcycle" "${STEAMAPPDIR}/${STEAMAPP}/"
		fi
		echo ''
	fi
}
