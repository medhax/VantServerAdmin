#!/bin/bash
# Script administratiu Carles Brunet

PS3='Què vols fer?: '
options=("Crear un nou usuari" "Actualitzar aquest programa" "Obtenir informació interessant" "Sortir")
select opt in "${options[@]}"
do
    case $opt in
        "Crear un nou usuari")
		
            echo "Introdueix el nom d'usuari a crear"
	    read NOMUSUARI
	    echo "Introdueix el nom complet de l'usuari a crear"
	    read NOMCOMPLET
	    echo "Introdueix la contrasenya de l'usuari a crear"
	    read PASSWD
	 sudo useradd -c $NOMCOMPLET -m $NOMUSUARI
sudo echo "$NOMUSUARI:$PASSWD" | sudo chpasswd
		sudo mkdir /home/${NOMUSUARI,,}/ftp
		sudo chown nobody:nogroup /home/${NOMUSUARI,,}/ftp
		sudo chmod a-w /home/${NOMUSUARI,,}/ftp 
            ;;
        "Actualitzar aquest programa")
            echo "--> Actualitzant..."
		git stash && git pull
		sudo chmod +x ./menuadmin.sh
		./menuadmin.sh
            ;;
        "Obtenir informació interessant")
            echo "--> Llistat d'usuaris"
	    awk -F: '{ print $1}' /etc/passwd
            ;;
        "Sortir")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
	

