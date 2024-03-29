#!/bin/sh
#
# Post-update script
#
# This script will be executed after completing all the file renaming
# corresponding to the last update
#

ROOTFS_IMG_FILE="/tmp/rootfs.fex"
USR_IMG_FILE="/tmp/usr.fex"
BOOT_IMG_FILE="/tmp/boot.fex"

printf "Post-update script started.\n"

if [ -f "/mnt/UDISK/wpa_supplicant.conf" ]; then
	mv "/mnt/UDISK/wpa_supplicant.conf" "/mnt/UDISK/main_wpa_supplicant.conf"
fi

# Real work here
printf "Checking that all files are present...\n"

if ! [[ -f "$BOOT_IMG_FILE" ]]; then
	printf "File corresponding to usr image not present at: $BOOT_IMG_FILE\n"
	exit 1
fi

if ! [[ -f "$ROOTFS_IMG_FILE" ]]; then
	printf "File corresponding to rootfs image not present at: $ROOTFS_IMG_FILE\n"
	exit 1
fi

if ! [[ -f "$USR_IMG_FILE" ]]; then
	printf "File corresponding to usr image not present at: $USR_IMG_FILE\n"
	exit 1
fi

printf "Reflashing boot partition\n"
dd if=$BOOT_IMG_FILE of=/dev/mmcblk0p1 bs=512

if [[ $? -ne 0 ]]; then
	printf "Reflash of usr partition failed with exit code: $?\n"
	exit 1
fi

printf "Reflashing rootfs partition\n"
dd if=$ROOTFS_IMG_FILE of=/dev/mmcblk0p2 bs=512

if [[ $? -ne 0 ]]; then
	printf "Reflash of rootfs partition failed with exit code: $?\n"
	exit 1
fi

printf "Reflashing usr partition\n"
dd if=$USR_IMG_FILE of=/dev/mmcblk0p3 bs=512

if [[ $? -ne 0 ]]; then
	printf "Reflash of usr partition failed with exit code: $?\n"
	exit 1
fi

printf "Post-update script finished.\n"

exit 0