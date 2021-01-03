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
#        FILE: install-pyradio.sh
#       USAGE: ./install-pyradio.sh | sub menu of pyradio-install.sh
#
# DESCRIPTION: install pyradio in Linux Systems
#
#      AUTHOR: DarknessCode
#       EMAIL: achim@darknesscode.xyz
#
#     CREATED: 07-30-20 07:48
#
# -----------------------------------------------------------------

install-dependencies() {
	echo ""
	echo " Install Dependencies for PyRadio"
	echo " Arch Linux | Debian | Void Linux"
	echo ""
	sleep 2

	while true; do
		read -p " Install Dependencies [y - n] : " yn
		case $yn in
			[Yy]* )
				if ! location="$(type -p "python3-setuptools")" || [ -z "python3-setuptools" ]; then

					# check if pacman is installed
					if which pacman > /dev/null 2>&1; then

						sudo pacman -S --noconfirm python-setuptools

					# check if apt is installed
					elif which apt > /dev/null 2>&1; then

						sudo apt install -y python3-setuptools

					# check if xbps is installed
					elif which xbps-install > /dev/null 2>&1; then

						sudo xbps-install -Sy python3-setuptools

					else

						echo " Your system is not suported!!!"
					fi

					else
						echo " Nothing to do! python3-setuptools is installed in your System"
				fi ; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
	echo ""
}

install-audio-player() {
	echo ""
	echo " Install Audio Media Player"
	echo " Arch Linux | Debian | Void Linux"
	echo ""
	echo " - MPV"
	echo " - MPlayer"
	echo " - VLC"
	echo ""
	sleep 2

	while true; do
		read -p " Install MPV [y - n] : " yn
		case $yn in
			[Yy]* )
				if ! location="$(type -p "mpv")" || [ -z "mpv" ]; then

					# check if pacman is installed
					if which pacman > /dev/null 2>&1; then

						sudo pacman -S --noconfirm mpv

					# check if apt is installed
					elif which apt > /dev/null 2>&1; then

						sudo apt install -y mpv

					# check if xbps is installed
					elif which xbps-install > /dev/null 2>&1; then

						sudo xbps-install -Sy mpv

					else

						echo " Your system is not suported!!!"
					fi

					else
						echo " Nothing to do! MPV is installed in your System"
				fi ; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
	echo ""

	while true; do
		read -p " Install MPlayer [y - n] : " yn
		case $yn in
			[Yy]* )
				if ! location="$(type -p "mplayer")" || [ -z "mplayer" ]; then

					# check if pacman is installed
					if which pacman > /dev/null 2>&1; then

						sudo pacman -S --noconfirm mplayer

					# check if apt is installed
					elif which apt > /dev/null 2>&1; then

						sudo apt install -y mplayer

					# check if xbps is installed
					elif which xbps-install > /dev/null 2>&1; then

						sudo xbps-install -Sy mplayer

					else

						echo " Your system is not suported!!!"
					fi

					else
						echo " Nothing to do! MPlayer is installed in your System"
				fi ; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
	echo ""

	while true; do
		read -p " Install VLC Media Player [y - n] : " yn
		case $yn in
			[Yy]* )
				if ! location="$(type -p "vlc")" || [ -z "vlc" ]; then

					# check if pacman is installed
					if which pacman > /dev/null 2>&1; then

						sudo pacman -S --noconfirm vlc

					# check if apt is installed
					elif which apt > /dev/null 2>&1; then

						sudo apt install -y vlc

					# check if xbps is installed
					elif which xbps-install > /dev/null 2>&1; then

						sudo xbps-install -Sy vlc

					else

						echo " Your system is not suported!!!"
					fi

					else
						echo " Nothing to do! VLC Media Player is installed in your System"
				fi ; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
	echo ""
}

install-from-source() {
	echo ""
	echo " Installing pyradio from source"
	sleep 2;

	cd config-files/master;
	devel/build_install_pyradio 3
	echo ""
}

install-aur() {
	echo ""
	echo " Install PyRadio AUR Arch-Based Systems"
	echo ""
	sleep 2

	yay -S pyradio-git &&
	echo " PyRadio was installed" || echo " We have a real problem"
	echo ""
}

install-aur() {
	echo ""
	echo " Install PyRadio From Void Linux Repositories"
	echo ""
	sleep 2

	sudo xbps-install -Sy pyradio &&
	echo " PyRadio was installed" || echo " We have a real problem"
	echo ""
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
	echo "  _____       _____           _ _      _____           _        _ _            "
	echo " |  __ \     |  __ \         | (_)    |_   _|         | |      | | |           "
	echo " | |__) |   _| |__) |__ _  __| |_  ___  | |  _ __  ___| |_ __ _| | | ___ _ __  "
	echo " |  ___/ | | |  _  // _' |/ _' | |/ _ \ | | | '_ \/ __| __/ _' | | |/ _ \ '__| "
	echo " | |   | |_| | | \ \ (_| | (_| | | (_) || |_| | | \__ \ || (_| | | |  __/ |    "
	echo " |_|    \__, |_|  \_\__,_|\__,_|_|\___/_____|_| |_|___/\__\__,_|_|_|\___|_|    "
	echo "         __/ |                                                                 "
	echo "        |___/								     								 "
	echo ""
	echo " Install PyRadio, for -Arch Linux -Debian and -Void Linux systems"
	echo ""
	echo " 1 - Dependencies"
	echo " 2 - Audio Player"
	echo ""
	echo " 3 - Pyradio From Source"
	echo ""
	echo " 4 - Pyradio AUR (Arch)"
	echo " 5 - Pyradio Void Linux (repos)"
	echo ""
	echo " 0 - Back"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install-dependencies ; press_enter ;;
		2) clear; install-audio-player ; press_enter ;;
		3) clear; install-from-source  ; press_enter ;;
		4) clear; install-aur          ; press_enter ;;
		5) clear; install-void         ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection  ; press_enter ;;
	esac
done
