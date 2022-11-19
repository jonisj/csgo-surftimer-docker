# Download and extract function
function dl_extract {
	local -r type="$1"
	local -r name="$2"
	local -r url="$3"
	local -r dest="$TEMPDIR/$name"

	mkdir -p "$dest"

	case "${type}" in
	'zip')
		wget -qO- "$url" > "$dest/$name.zip"
		unzip -oq "$dest/$name.zip" -d "$dest/"
		rm -rf "$dest/$name.zip"
		;;
	'tar')
		wget -qO- "$url" > "$dest/$name.tar.gz"
		tar xzf "$dest/$name.tar.gz" -C "$dest/"
		rm -rf "$dest/$name.tar.gz"
		;;
	*)
		error "Unexpected file type'${type}'"
		;;
	esac
}

# Handle updating extra plugins
function update_extra {
	local -r name="$1"
	local -r dependecy="$2"
	local -r current_ver="$3"
	local -r update_function="$4"

	# Check if the dependency needs an update
	case "$(check_version "$dependecy" "$current_ver")" in
		"install" | "update")
			echo ">>> Installing $name $current_ver"

			"$update_function" "$dependecy"

			update_version "$dependecy" "$current_ver"
			;;

		*)
			echo ">>> $name is up-to-date"
			;;
	esac
}
