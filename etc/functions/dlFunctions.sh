## Functions for downloading dependencies

function getZippedDependency {
	local -r dest="$1"
	local -r name="$2"
	local -r url="$3"
	
	mkdir -p "$dest/$name"

	wget -qO- "$url" > "$dest/$name.zip"
	unzip -oq "$dest/$name.zip" -d "$dest/$name/"

	rm -rf "$dest/$name.zip"
}

function getTarredDependency {
	local -r dest="$1"
	local -r name="$2"
	local -r url="$3"
	
	mkdir -p "$dest/$name"

	wget -qO- "$url" > "$dest/$name.tar.gz"
	tar xzf "$dest/$name.tar.gz" -C "$dest/$name/"

	rm -rf "$dest/$name.tar.gz"
}
