## Downloads & Installs extra surf plugins
function download_extras {
	echo ">>>> Installing additional surf plugins"

	update_extra "Stripper: Source" "stripper" "${STRIPPER_VERSION}" install_stripper_source
	update_extra "Movement Unlocker" "movementunlocker" "${MOVEMEMNTUNLOCK_VERSION}" install_movement_unlocker
	update_extra "SurfTimer Map Chooser" "surftimermc" "${SURFTIMERMC_VERSION}" install_surftimer_mc
	update_extra "MomSurfFix" "momsurffix" "${MOMENTUMFIX_VERSION}" install_mom_surf_fix
	update_extra "RNGFix" "rngfix" "${RNGFIX_VERSION}" install_rng_fix
	update_extra "HeadBugFix" "headbugfix" "${HEADBUGFIX_VERSION}" install_headbug_fix
	update_extra "PushFixDE" "pushfixde" "${PUSHFIX_VERSION}" install_push_fix
	update_extra "crouchboostfix" "crouchboostfix" "${CROUCHBOOSTFIX_VERSION}" install_crouchboostfix
	update_extra "Normalized Run Speed" "normalizedspeed" "${NORMALIZEDSPEED_VERSION}" install_normalized_run_speed
}

# http://www.bailopan.net/stripper/
function install_stripper_source {
	dl_extract "tar"  "$1" "http://www.bailopan.net/stripper/files/stripper-1.2.2-linux.tar.gz"
	cp -R "$TEMPDIR/"$1"/addons/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/"
}

# https://forums.alliedmods.net/showthread.php?t=255298
function install_movement_unlocker {
	wget -q "http://www.sourcemod.net/vbcompiler.php?file_id=141520" -O "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/csgo_movement_unlocker.smx"
	wget -q "https://forums.alliedmods.net/attachment.php?attachmentid=141521&d=1495261818" -O "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/gamedata/csgo_movement_unlocker.games.txt"
}

# https://github.com/surftimer/SurfTimer-Mapchooser
function install_surftimer_mc {
	dl_extract "zip" "$1" "https://github.com/surftimer/SurfTimer-Mapchooser/releases/download/2.0.2/SurfTimer-MC-v2.0.2.zip"
	cp -R "$TEMPDIR/"$1"/plugins/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
	cp -R "$TEMPDIR/"$1"/translations/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/translations/"
}

# https://github.com/GAMMACASE/MomSurfFix
function install_mom_surf_fix {
	dl_extract "zip" "$1" "https://github.com/GAMMACASE/MomSurfFix/releases/download/1.1.5/MomSurfFix2v1.1.5.zip"
	cp -R "$TEMPDIR/"$1"/addons/sourcemod/gamedata/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/gamedata/"
	cp -R "$TEMPDIR/"$1"/addons/sourcemod/plugins/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
}

# https://github.com/jason-e/rngfix
function install_rng_fix {
	dl_extract "zip" "$1" "https://github.com/jason-e/rngfix/releases/download/v1.1.2d/rngfix_1.1.2d.zip"
	cp -R "$TEMPDIR/"$1"/gamedata/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/gamedata/"
	cp -R "$TEMPDIR/"$1"/plugins/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
}

# https://github.com/GAMMACASE/HeadBugFix
function install_headbug_fix {
	dl_extract "zip" "$1" "https://github.com/GAMMACASE/HeadBugFix/releases/download/1.0.0/headbugfix_1.0.0.zip"
	cp -R "$TEMPDIR/"$1"/addons/sourcemod/plugins/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
	cp -R "$TEMPDIR/"$1"/addons/sourcemod/gamedata/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/gamedata/"
}

# https://github.com/GAMMACASE/PushFixDE
function install_push_fix {
	dl_extract "zip" "$1" "https://github.com/GAMMACASE/PushFixDE/releases/download/1.0.0/pushfix_de_1.0.0.zip"
	cp -R "$TEMPDIR/"$1"/addons/sourcemod/plugins/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
	cp -R "$TEMPDIR/"$1"/addons/sourcemod/gamedata/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/gamedata/"
}

# https://github.com/t5mat/crouchboostfix
function install_crouchboostfix {
	wget -q "https://github.com/t5mat/crouchboostfix/releases/download/2.0.2/crouchboostfix.smx" -O "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/crouchboostfix.smx"
}

# https://github.com/sneak-it/Normalized-Run-Speed
function install_normalized_run_speed {
	dl_extract "zip" "$1" "https://github.com/sneak-it/Normalized-Run-Speed/archive/513fafcbe0f32930d9921fe5dd5f6b54586ae404.zip"
	cp -R "$TEMPDIR/"$1"/Normalized-Run-Speed-513fafcbe0f32930d9921fe5dd5f6b54586ae404/gamedata/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/gamedata/"
	cp -R "$TEMPDIR/"$1"/Normalized-Run-Speed-513fafcbe0f32930d9921fe5dd5f6b54586ae404/plugins/"* "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/plugins/"
}
