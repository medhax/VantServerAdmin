#!/bin/bash
# Bash Menu Script Example

PS3='Please enter your choice: '
options=("1" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "1")
		echo "Actualitzant"
		git pull
            echo "Introdueix el nom de l'usuari"
	    read NOMUSUARI
	    sudo adduser $NOMUSUARI
		sudo mkdir /home/${NOMUSUARI,,}
		sudo mkdir /home/${NOMUSUARI,,}/ftp
		sudo chown nobody:nogroup /home/${NOMUSUARI,,}/ftp
		sudo chmod a-w /home/${NOMUSUARI,,}/ftp 
            ;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Option 3")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
	

