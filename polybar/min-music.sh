main() {
		player="google-play-music-desktop-player"
	if pgrep Google > /dev/null; then 
		player="google-play-music-desktop-player"
	elif pgrep spotify > /dev/null; then 
		player="spotify"
	else 
		echo "Music"; exit
	fi


	cmd="org.freedesktop.DBus.Properties.Get"
	domain="org.mpris.MediaPlayer2"
	path="/org/mpris/MediaPlayer2"

	meta=$(dbus-send --print-reply --dest=${domain}.${player} \
		/org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:${domain}.Player string:Metadata)

	artist=$(echo "$meta" | sed -nr '/xesam:artist"/,+2s/^ +string "(.*)"$/\1/p' | tail -1  | sed "s/\&/+/g")
	album=$(echo "$meta" | sed -nr '/xesam:album"/,+2s/^ +variant +string "(.*)"$/\1/p' | tail -1)
	title=$(echo "$meta" | sed -nr '/xesam:title"/,+2s/^ +variant +string "(.*)"$/\1/p' | tail -1 | sed "s/\&/+/g")
	title=${title:0:18}
	final=$(echo "${*:-%artist% - %title%}" | sed "s/%artist%/$artist/g;s/%title%/$title/g;s/%album%/$album/g"i | sed 's/&/\\&/g')
	admsg="Subscribe for all of the music with none of the ads - Your music will resume shortly"

	if [ "$final" == " - " ]; then
		echo Play Music; exit
	elif [ "$final" == "$admsg" ]; then
		echo "Ugh Ads"; exit
	fi
	echo $final
}

main "$@"
