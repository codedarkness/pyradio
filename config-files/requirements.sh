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
#        FILE: requiremtnes.sh
#       USAGE: ./requirements.sh | sub menu of pyradio_install.sh
#
# DESCRIPTION: install the requirements for pyradio to work
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 05-19-2020 08:30
#
# -----------------------------------------------------------------

python_tools_arch() {
	echo ""
	echo " Installing python-setuptools"
	sleep 2;
	pacman -Qs python-setuptools &&
		echo " python-setuptools is installed in your system" ||
		sudo pacman -S --noconfirm --needed python-setuptools
}

mplayer_arch() {
	echo ""
	echo " Installing MPlayer"
	sleep 2;
	pacman -Qs mplayer &&
		echo " MPlayer is installed in your system" ||
		sudo pacman -S --noconfim --needed mplayer
}

python3_tools_debian() {
	echo ""
	echo " Instaling python3-setuptools"
	sleep 2;
	dpkg -l | grep python3-setuptools &&
		echo " puthon3-setuptools is installed in your system" ||
		sudo apt install -y python-setuptools
}

mplayer_debian() {
	echo ""
	echo " Installing MPlayer"
	sleep 2;
	dpkg -l | grep mplayer &&
		echo " MPlayer is installed in your system" ||
		sudo apt install -y mplayer
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
	echo " ----------------------------------------------"
	echo " ### Title here                             ###"
	echo " ----------------------------------------------"
	echo ""
	echo " Arch Based Systems"
	echo " ----------------------------------------------"
	echo " 1 - python-setuptools"
	echo " 2 - MPlayer"
	echo ""
	echo " Debian Based Systems"
	echo " ----------------------------------------------"
	echo " 3 - python3-setuptolls"
	echo " 4 - MPlayer"
	echo ""
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; python_tools_arch    ; press_enter ;;
		2) clear; mplayer_arch        ; press_enter ;;
		3) clear; python3_tools_debian ; press_enter ;;
		4) clear; mplayer_debian      ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
