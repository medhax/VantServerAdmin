#!/bin/bash
# Script administratiu Carles Brunet

PS3='Què vols fer?: '
options=("Crear els usuaris" "Eliminar un usuari" "Actualitzar aquest programa" "Obtenir informació interessant" "Comprovar permisos" "Sortir")
select opt in "${options[@]}"
do
    case $opt in
        "Crear els usuaris")
		for user in $(more ../user-list.txt)
do
echo "$user"

chage -d 0 "$user"

            
	 sudo useradd -c "$user" -m "$user"
sudo echo "$user:$user" | sudo chpasswd
		sudo mkdir /home/"${user,,}"/ftp
		sudo mkdir /var/www/alumnes/"${user,,}"
		sudo chown nobody:alumnes /home/"${user,,}"/ftp
		sudo chmod a-w /home/"${user,,}"/ftp 
		sudo chown nobody:alumnes /var/www/alumnes/"${user,,}"
		sudo chmod a-w /var/www/alumnes/"${user,,}"
		unlink /home/"${user,,}"/ftp/"${user,,}"
		mount --bind /var/www/alumnes/"${user,,}" /home/"${user,,}"/ftp
		sudo echo "$user" >> /etc/vsftpd.chroot_list
		done
            ;;
        "Actualitzar aquest programa")
            echo "--> Actualitzant..."
		git stash && git pull
		sudo chmod +x ./menuadmin.sh
		./menuadmin.sh
            ;;
	    "Comprovar permisos")
           	echo "--> Comprovant permisos..."
		for user in $(more ../user-list.txt)
		do
		echo "$user"
		echo "--> Establint permisos de carpetes"
		sudo chmod -R 777 /var/www
		sudo usermod -a -G alumnes "$user"
		sudo chmod -R 777 /var/www
		sudo chown nobody:alumnes /home/"${user,,}"/ftp
		sudo chmod a-w /home/"${user,,}"/ftp 
		sudo chown nobody:alumnes /var/www/alumnes/"${user,,}"
		sudo chmod a-w /var/www/alumnes/"${user,,}"
		done
            ;;
	     "Eliminar un usuari")
            echo "--> Introdueix el nom de l'usuari a eliminar: "
	    read NOMUSUARIDEL
		sudo userdel "$NOMUSUARIDEL"
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
