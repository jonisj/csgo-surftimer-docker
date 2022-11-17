## Prepare MySQL configs
function prepare_mysql_client_configs {
	# Setup config for mysql client
	MYSQL_CONFIG="$TEMPDIR/mysql.conf"

	cat > "$MYSQL_CONFIG" <<-EOF
		[client]
		host="${DB_HOST}"
		database="${DB_DATABASE}"
		user="${DB_USER}"
		password="${DB_PASS}"
		port="${DB_PORT}"
		EOF

	# Setup Sourcemod's databases.cfg
	cat > "${STEAMAPPDIR}/${STEAMAPP}/addons/sourcemod/configs/databases.cfg" <<-EOF
		"Databases"
		{
			"storage-local"
			{
				"driver"			"sqlite"
				"database"			"sourcemod-local"
			}

			"clientprefs"
			{
				"driver"			"sqlite"
				"host"				"localhost"
				"database"			"clientprefs-sqlite"
				"user"				"root"
				"pass"				""
				//"timeout"			"0"
				//"port"			"0"
			}

			"surftimer"
			{
				"driver"			"mysql"
				"host"				"${DB_HOST}"
				"database"			"${DB_DATABASE}"
				"user"				"${DB_USER}"
				"pass"				"${DB_PASS}"
				"port"				"${DB_PORT}"
			}
		}
		EOF
}
