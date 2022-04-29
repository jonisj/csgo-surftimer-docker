function installDHooks2 {
	getZippedDependency "$TEMPDIR" "dhooks" "https://github.com/peace-maker/DHooks2/releases/download/v${DHOOKS_VERSION}/dhooks-${DHOOKS_VERSION}-sm110.zip"
	cp -R "$TEMPDIR/dhooks/addons/sourcemod/gamedata/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/gamedata/"
	cp -R "$TEMPDIR/dhooks/addons/sourcemod/extensions/"*".so" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/extensions/"
}

function installSteamWorks {
	getTarredDependency "$TEMPDIR" "steamworks" "https://github.com/KyleSanderson/SteamWorks/releases/download/${STEAMWORKS_VERSION}/package-lin.tgz"
	cp -R "$TEMPDIR/steamworks/package/addons/sourcemod/extensions/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/extensions/"
}

function installSMLib {
	getTarredDependency "$TEMPDIR" "smlib" "https://github.com/bcserv/smlib/archive/${SMLIB_VERSION}.tar.gz"
	cp -R "$TEMPDIR/smlib/smlib-${SMLIB_VERSION}/gamedata/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/gamedata/"
}

function installStripperSource {
	getTarredDependency "$TEMPDIR" "stripper" "http://www.bailopan.net/stripper/snapshots/1.2/stripper-${STRIPPER_VERSION}-linux.tar.gz"
	cp -R "$TEMPDIR/stripper/addons/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/"
}

function installSMJansson {
	getTarredDependency "$TEMPDIR" "smjansson" "https://github.com/thraaawn/SMJansson/archive/${SMJANSSON_VERSION}.tar.gz" 
	cp -R "$TEMPDIR/smjansson/SMJansson-${SMJANSSON_VERSION}/bin/"*".so" "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/extensions/"
}

function installMovementUnlocker {
	wget -q "http://www.sourcemod.net/vbcompiler.php?file_id=141520" -O "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/csgo_movement_unlocker.smx"
	wget -q "https://forums.alliedmods.net/attachment.php?attachmentid=141521&d=1495261818" -O "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/gamedata/csgo_movement_unlocker.games.txt"
}

function updateDependency {
	
	local -r name="$1"
	local -r dependecy="$2"
	local -r current_ver="$3"
	local -r update_function="$4"

	# Check if the dependency needs an update
	case "$(checkVersion "$dependecy" "$current_ver")" in
		"install" | "update")
			echo ">> Installing $name $current_ver"

			update_function

			updateVersion "$dependecy" "$current_ver"
			;;

		*)
			echo ">> $name is up-to-date"
			;;
	esac

}

## Downloads & Installs SurfTimer's dependencies
function downloadDependencies {
	echo ">>>> Installing SurfTimer's dependencies"

	updateDependency "DHooks2" "dhooks" "${DHOOKS_VERSION}" installDHooks2
	updateDependency "SteamWorks" "steamworks" "${STEAMWORKS_VERSION}" installSteamWorks
	updateDependency "SMLib" "smlib" "${SMLIB_VERSION}" installSMLib
	updateDependency "Stripper: Source" "stripper" "${STRIPPER_VERSION}" installStripperSource
	updateDependency "SMJansson" "smjansson" "${SMJANSSON_VERSION}" installSMJansson
	
	#updateDependency "Movement Unlocker" "movementunlocker" "${DHOOKS_VERSION}" installMovementUnlocker
	installMovementUnlocker
}
