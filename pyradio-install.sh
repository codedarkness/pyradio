#!/bin/bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _' | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _' |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.xyz
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: pyradio-install.sh
#       USAGE: ./pyradio-install.sh
#
# DESCRIPTION: install pyradio and copy stations list
#
#      AUTHOR: DarknessCode
#       EMAIL: achim@darknesscode.xyz
#
#     CREATED: 05-18-2020 08:53
#
# -----------------------------------------------------------------

install-pyradio() {
	config-files/systems/install-pyradio.sh
}

copy_files() {
	echo ""
	echo " Getting ready to copy new config files"
	sleep 2

	### Check for dir, if not found create it using the mkdir ###
	dldir="$HOME/.config/pyradio"
	[ ! -d "$dldir" ] && mkdir -p "$dldir" &&
	echo " PyRadio directory was created in .config/pyradio" || echo " PyRadio dir found!"
	echo ""

	cp -af config-files/configs/config ~/.config/pyradio/ &&
	echo " pyradio config files copied" || echo " It's me, not you!"
	echo ""

	cp -af config-files/configs/stations.csv ~/.config/pyradio/ &&
	echo " PyRadio stations was copied" || echo " Uppssss!"
	echo ""
}

edit_stations() {
	echo ""
	echo " Edit PyRadio Stations File"
	echo " After your edited this file you need to copy to your"
	echo " local machine, Pyradio must be close"
	echo ""
	sleep 2

	while true; do
		read -p " Edit PyRadio Stations [y - n ] : " yn
		case $yn in
			[Yy]* )
				vim config-files/configs/stations.csv; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

copy_stations() {
	echo ""
	echo " Getting ready to copy stations file"
	echo ""
	sleep 2

	while true; do
		read -p " Copy PyRadio Stations File [y - n] : " yn
		case $yn in
			[Yy]* )
				cp -af config-files/configs/stations.csv ~/.config/pyradio/ &&
				echo " stations file was copied" || echo " Sorry, you have a big problem!"
				echo ""; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

press_enter() {
	echo ""
	echo -n " Press Enter To Continue"
	read
	clear
}

incorrect_selection() {
	echo " Incorrect selection! try again"
}

until [ "$selection" = "0" ]; do
	clear
	echo ""
	echo " DarknessCode"
	echo "  _____       _____           _ _        "
	echo " |  __ \     |  __ \         | (_)       "
	echo " | |__) |   _| |__) |__ _  __| |_  ___   "
	echo " |  ___/ | | |  _  // _' |/ _' | |/ _ \  "
	echo " | |   | |_| | | \ \ (_| | (_| | | (_) | "
	echo " |_|    \__, |_|  \_\__,_|\__,_|_|\___/  "
	echo "         __/ |                           "
	echo "        |___/			       "
	echo ""
	echo " A console based Internet radio player"
	echo ""
	echo " 1 - Install pyradio"
	echo " 2 - Copy config files (new install)"
	echo ""
	echo " 3 - Edit stations List"
	echo " 4 - Copy stations file"
	echo ""
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install-pyradio ;;
		2) clear; copy_files       ; press_enter ;;
		3) clear; edit_stations    ; press_enter ;;
		4) clear; copy_stations    ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
