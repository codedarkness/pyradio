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
#        FILE: install-pyradio.sh
#       USAGE: ./install-pyradio.sh | sub menu of pyradio-install.sh
#
# DESCRIPTION: install pyradio in arch, debian based systems
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 07-30-20 07:48
#
# -----------------------------------------------------------------

install-dependencies() {
	echo ""
	echo " Installing dependencies for PyRadio"
	echo ""
	sleep 2

	PS3='Select your based system: '
	options=("Arch Based" "Debian Based" "Exit")
	select opt in "${options[@]}"
	do
    		case $opt in
        		"Arch Based")
				pacman -Qs python-setuptools &&
				echo " python-setuptools is installed in your system" ||
				sudo pacman -S --noconfirm --needed python-setuptools; break ;;

        		"Debian Based")
				dpkg -l | grep python3-setuptools &&
				echo " puthon3-setuptools is installed in your system" ||
				sudo apt install -y python-setuptools; break ;;

        		"Exit")
            			break ;;
        		*) echo "invalid option $REPLY";;
    		esac
	done

}

install-mplayer() {
	echo ""
	echo " Installing mplayer in Arch, Debian Based systems"
	echo ""
	sleep 2

	while true; do
		read -p " Install MPlayer [y - n] : " yn
		case $yn in
			[Yy]* )
				if ! location="$(type -p "mplayer")" || [ -z "mplayer" ]; then

					# check if pacman is installed
					if which pacman > /dev/null; then

						sudo pacman -S --noconfirm mplayer

					# check if apt is installed
					elif which apt > /dev/null; then

						sudo apt install -y mplayer

					else

						echo " Your system is not Arch or Debian Based System"
					fi

					else
						echo " Nothing to do! MPlayer is installed in your System"
				fi ; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

install-from-source() {
	echo ""
	echo " Installing pyradio"
	sleep 2;

	cd config-files/master;
	devel/build_install_pyradio 3
}

install-aur() {
	echo ""
	echo " Install PyRadio AUR Arch-Based Systems"
	echo ""
	sleep 2

	yay -S pyradio-git && echo " PyRadio was installed" || echo " We have a real problem"
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
	echo "        |___/								     "
	echo ""
	echo " Install PyRadio, for Arch and Debian based systems"
	echo ""
	echo " 1 - Install Dependencies"
	echo " 2 - MPlanyer"
	echo ""
	echo " 3 - Install Pyradio"
	echo ""
	echo " 4 - Install Pyradio AUR (Arch)"
	echo ""
	echo " 0 - Back"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install-dependencies ; press_enter ;;
		2) clear; install-mplayer ; press_enter ;;
		3) clear; install-from-source ; press_enter ;;
		4) clear; install-aur ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
