#!/bin/bash
## IMPORTANT > Ne pas lancer ce script directement, la post-installation se lance avec le script nommé "PostInstall_Ubuntu-20.04LTS_FocalFossa.sh"

# Configuration suivant la méthode d'installation (apt install, via un ppa, via un snap, via flatpak, etc...)
DOWNLOAD_DIR="/tmp"
#MY_PROG=$(basename $0 .sh)
MY_PROG=Description_logiciel
GUI=""
ALL_PPA_INSTALL=""
ALL_PPA_NS=""

# Set language with given parameter
if [ "X$1" != "X" ]
then
	LANG=$1
fi

# Langue ## Uniquement en FR pour l'instant.
f_get_msg(){
	no_msg_file="Erreur : fichier non trouvé ou problème de permission d'accès !"
	lang=${LANG:=english}
	case ${lang} in
		[Ee][Nn][Gg]*	)	all_msg=${MY_DIR}/${MY_PROG}.fr 
							DOWNLOAD_DIR=~/Downloads/;;
		[Ff][Rr]*	)	all_msg=${MY_DIR}/${MY_PROG}.fr 
						DOWNLOAD_DIR=~/Téléchargements/;;
		*			)	all_msg=${MY_DIR}/${MY_PROG}.fr
						DOWNLOAD_DIR=~/Downloads/;;
	esac
	if [ -f ${all_msg} -a -r ${all_msg} ]
	then
		. ${all_msg}
	else
		echo ${no_msg_file}
		exit 3
	fi
}

# Installation flexible avec différentes manips possibles en paramètre (wget, tar xzf etc...)
f_action_exec() {
	if [[ "$GUI" = *"$1"* ]]
	then
		if [ "X$3" = "X" ]
		then
			ns_exec="$NS_INSTALL $1"
		else
			ns_exec="$3"
		fi
		echo $ns_exec " ..."
		echo ""
		notify-send -i system-software-update "$MY_PROG" "$ns_exec" -t 2000
		dash -c "$2"
	fi
}

# Installation classique depuis les dépots officiels
f_action_install() {
	if [[ "$GUI" == *"$1"* ]]
	then
		echo "$NS_INSTALL $1 ..."
		echo ""
		notify-send -i system-software-update "$MY_PROG" "$NS_INSTALL $1" -t 2000
		sudo apt install -y $2
	fi
}


# Installation via un PPA
f_action_ppa_install() {
	if [[ "$GUI" == *"$1"* ]]
	then
		echo "$NS_INSTALL $1 ..."
		echo ""
		notify-send -i system-software-update "$MY_PROG" "$NS_INSTALL $1" -t 2000
		sudo add-apt-repository -y $2
		sudo apt update ; sudo apt install -y $3
	fi
}


# Installation d'un paquet deb manuellement (non présent dans les dépots d'Ubuntu)
f_action_get() {
	if [[ "$GUI" == *"$1"* ]]
	then
		echo "$NS_INSTALL $1 ..."
		echo ""
		notify-send -i system-software-update "$MY_PROG" "$NS_INSTALL $1" -t 2000
		cd $DOWNLOAD_DIR
		wget "$2" --no-check-certificate
		sudo apt install -y ./"${2##*/}"
		rm *.deb
	fi
}

# Récupération de paquet universel portable au format AppImage (+ ajout du droit d'execution)
f_action_get_appimage() {
	if [[ "$GUI" == *"$1"* ]]
	then
		echo "$NS_INSTALL $1 ..."
		echo ""
		notify-send -i system-software-update "$MY_PROG" "$NS_INSTALL $1" -t 2000
		cd $DOWNLOAD_DIR
	    if [ ! -d $HOME/AppImage ]
	    then
	        mkdir $HOME/AppImage  
	    fi
		wget "$2" --no-check-certificate
		chmod +x *.?pp?mage && mv *.?pp?mage $HOME/AppImage/
	fi
}

# Installation de paquet Snap
f_action_snap_install() {
	if [[ "$GUI" == *"$1"* ]]
	then
	    # Vérification que Snap est bien installé et l'installer si ce n'est pas le cas (uniquement si un paquet Snap est demandé !)
	    if [ ! -f /usr/bin/snap ]
	    then
	        sudo apt install snapd gnome-software-plugin-snap -y  
	    fi
		echo  "$NS_DEFERED $1 ..."
		echo ""
		ALL_SNAP_NS="${ALL_SNAP_NS} $1"
		sudo snap install $2
		ALL_SNAP_INSTALL="${ALL_SNAP_INSTALL} $3"
	fi
}

# Installation de paquet Flatpak
f_action_flatpak_install() {
	if [[ "$GUI" == *"$1"* ]]
	then
	    # Vérification que Flatpak est bien installé et l'installer si ce n'est pas le cas (uniquement si un paquet Flatpak est demandé !)
	    if [ ! -f /usr/bin/flatpak ]
	    then
	        sudo apt install flatpak gnome-software-plugin-flatpak -y
	        sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo # Ajout du dépot Flathub
	    fi
		echo  "$NS_DEFERED $1 ..."
		echo ""
		ALL_FLATPAK_NS="${ALL_FLATPAK_NS} $1"
		flatpak install flathub $2 -y
		ALL_FLATPAK_INSTALL="${ALL_FLATPAK_INSTALL} $3"
	fi
}

# Installation via un de mes scripts LinInstall de mon gitlab 
##cf: https://gitlab.com/simbd/LinInstall_Software
f_action_LinInstall() {
	if [[ "$GUI" == *"$1"* ]]
	then
		wget https://gitlab.com/simbd/LinInstall_Software/raw/master/LinInstall_"$2" --no-check-certificate
		chmod +x LinInstall_"$2" ; sudo ./LinInstall_"$2" ; rm LinInstall_"$2"
	fi
}

# Installation automatisé à partir de dépot externe de l'éditeur avec clé ajouté
f_RepositoryExt_Install() {
	if [[ "$GUI" == *"$1"* ]]
	then
		wget -O - "$3" | sudo apt-key add -   ## $3 => lien de la clé à ajouter
		echo "deb $4" | sudo tee /etc/apt/sources.list.d/"$2".list ## $4 => lien du dépot à ajouter (sans le deb au début) et $2 => nom du fichier.list
		sudo apt update # rafraichissement dépot
		sudo apt install -y "$5" ## $5 => nom du/des paquet(s) à installer depuis le dépot précédemment ajouté
	fi
}

# Case coché ou non suivant valeur 'vrai' ou 'faux'
chkDef() {
	case "$CHK_REP" in
		"$BGN_DEF") echo -n "$1" ;;
		"$BGN_CHECKED") echo -n "TRUE";;
		"$BGN_UNCHECKED") echo -n "FALSE";;
	esac
}

### Fonctions particulières pour certains choix dans le script
# Configurer l'usage des DNS de FDN/LDN (partie Optimisation)
choice_dnsfdn() {
	profiles=$(sudo -iu "#$PKEXEC_UID" nmcli -t -f UUID c show)
	for profile in ${profiles[@]}
	do
		sudo -iu "#$PKEXEC_UID" nmcli c modify "$profile" \
		ipv4.dns "80.67.169.12,80.67.169.40,80.67.188.188" \
		ipv4.ignore-auto-dns "yes" \
		ipv6.dns "2001:910:800::12,2001:910:800::40,2001:913::8" \
		ipv6.ignore-auto-dns "yes"
	done
}



# Installation des paquets obligatoires pour le fonctionnement du script si non-installé
which zenity > /dev/null
if [ $? = 1 ]
then
	sudo apt install -y zenity
fi

which notify-send > /dev/null
if [ $? = 1 ]
then
	sudo apt install -y libnotify-bin
fi

which add-apt-repository > /dev/null
if [ $? = 1 ]
then
	sudo apt install -y software-properties-common
fi

#Message dans fenêtre de dialogue
f_get_msg

notify-send  --icon=dialog-error "$NS_WATCH_OUT" "$NS_PWD_ASKED" -t 2000
