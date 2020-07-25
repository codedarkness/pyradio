#!/bin/bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _' | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _' |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.com
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: pyradio-install.sh
#       USAGE: ./pyradio-install.sh
#
# DESCRIPTION: install pyradio and copy stations list
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 05-18-2020 08:53
#
# -----------------------------------------------------------------

pyradio_source() {
	echo ""
	echo " Installing pyradio"
	sleep 2;
	cd config-files/master;
	devel/build_install_pyradio 3
}

requirements() {
	config-files/requirements.sh
}

copy_files() {
	echo ""
	echo " Getting ready to copy new config files"
	sleep 2;
	cp -rv config-files/pyradio ~/.config/ &&
		echo " pyradio config files copied"
}

copy_stations() {
	echo ""
	echo " Getting ready to copy stations files"
	sleep 2;
	cp -rv config-files/pyradio/stations.csv ~/.config/pyradio/ &&
		echo " stations file was copied"
}
edit_stations() {
	vim config-files/pyradio/stations.csv
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
	echo "                            _ _        "
	echo "                           | (_)       "
	echo "  _ __  _   _ _ __ __ _  __| |_  ___   "
	echo " | '_ \| | | | '__/ _' |/ _' | |/ _ \  "
	echo " | |_) | |_| | | | (_| | (_| | | (_) | "
	echo " | .__/ \__, |_|  \__,_|\__,_|_|\___/  "
	echo " | |     __/ |                         "
	echo " |_|    |___/                          "
	echo " ----------------------------------------------"
	echo " ### a console based Internet radio player  ###"
	echo " ----------------------------------------------"
	echo ""
	echo " 1 - Install pyradio from source"
	echo " 2 - Install Requirements"
	echo " 3 - Copy config files (new install)"
	echo " 4 - Edit stations List"
	echo " 5 - Copy stations file"
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; pyradio_source  ; press_enter ;;
		2) clear; requirements   ;;
		3) clear; copy_files      ; press_enter ;;
		4) clear; edit_stations  ;;
		5) clear; copy_stations   ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
