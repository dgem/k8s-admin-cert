SHELL := /bin/bash

# flash --userdata pz-master-1-user-data --ssid "${SSID}" --password "${PSK}" hypriotos-rpi-v1.9.0.img

default: verify
	# ❌
	@echo "✓ done"

checkid:
	test -z "$NODE_ID" && echo "NODE_ID is required (2..)" && exit 1

checkwifi:
	test -z "${SSID}" && echo "❌ SSID is required (home/office network name)" || echo "✓ wifi ssid ${SSID}"
	test -z "${PSK}" && echo "❌ PSK is required (home/office network password)" || echo "✓ wifi password set"

pz-master-1: #checkwifi
	flash --userdata pz-master-1-user-data hypriotos-rpi-v1.9.0.img

pz-master:
	# test -z "${ID}" && echo "ID required (2..)" && exit 1
	flash --userdata pz-master-user-data --hostname pz-master-${ID} hypriotos-rpi-v1.9.0.img

node1:
	flash --userdata node1-user-data hypriotos-rpi-v1.9.0.img

node2:
	flash --userdata node2-user-data hypriotos-rpi-v1.9.0.img

nodego:
	flash --userdata nodego-user-data hypriotos-rpi-v1.9.0.img

copy-node1: mount
	cp node1-user-data /Volumes/HypriotOS/user-data

verify: mount
	cat /Volumes/HypriotOS/user-data

mount:
	diskutil mount disk1s1

eject:
	sudo diskutil eject disk1

flash:
	flash hypriotos-rpi-v1.9.0.img
