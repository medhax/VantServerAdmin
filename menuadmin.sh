#!/bin/bash
# Bash Menu Script Example

PS3='Please enter your choice: '
options=("Crear un nou usuari" "Actualitzar aquest programa" "Obtenir informació interessant" "Sortir")
select opt in "${options[@]}"
do
    case $opt in
        "Crear un nou usuari")
		
            echo "Introdueix el nom de l'usuari"
	    read NOMUSUARI
	    sudo adduser $NOMUSUARI
		sudo mkdir /home/${NOMUSUARI,,}
		sudo mkdir /home/${NOMUSUARI,,}/ftp
		sudo chown nobody:nogroup /home/${NOMUSUARI,,}/ftp
		sudo chmod a-w /home/${NOMUSUARI,,}/ftp 
            ;;
        "Actualitzar aquest programa")
            echo "--> Actualitzant..."
		git pull
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
	

