#!/bin/sh

TEM_CONFIG_FILE="/tmp/config_template.json"
OLD_CONFIG_FILE="/mnt/UDISK/config.json"
TEMP_NEW_CONFIG_FILE="/mnt/UDISK/new_config.json"
NEW_CONFIG_FILE="/tmp/new_config.json"

while read line; do
	case "$line" in
		*\"mac\"*)
			echo "{" > "$NEW_CONFIG_FILE"
			echo "    $line" >> "$NEW_CONFIG_FILE"
			cat "$NEW_CONFIG_FILE" "$TEM_CONFIG_FILE" > "$TEMP_NEW_CONFIG_FILE"
			break
			;;
	esac
done < /mnt/UDISK/config.json

mv "$TEMP_NEW_CONFIG_FILE" "$OLD_CONFIG_FILE"

exit 0