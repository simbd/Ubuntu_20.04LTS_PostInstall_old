# README 

## Objectif ##

Ce script sert à installer des logiciels sur une base Ubuntu 20.04LTS avec un très large choix de paquets.
Il y a plusieurs avantages :
- Ce large choix de logiciel est accessible directement au sein d'une interface graphique unifié (via Zenity)
- Il y a une description de chaque logiciel directement dans l'interface ce qui vous permet de voir au premier coup d'oeil ce qui peux vous intéresser ou non.
- Simple à utiliser : pour installer les logiciels, il suffit juste de cocher les cases correspondantes
- Intègre différentes méthodes d'installations (installation depuis les dépots officiels, installation via le dépot communautaire AUR, installation via Snap, installation avec Flatpak et le dépot Flathub, Récupération au format AppImage, Installation via un script etc...
(Les méthodes d'installations sont explicitement indiqués dans le nom lors du choix).

![alt text](https://nsa40.casimages.com/img/2020/03/03//200303032518617444.png)

## Compatibilité ##

- Le script est destiné principalement à la version de base d'ArchLinux mais l'immense majorité des logiciels fonctionneront aussi sous Manjaro.

## Récupération / Lancement du script

Il y a plusieurs solutions :

- Télécharger le contenu du script (répertoire Archlinux_PostInstall) sur ce github (soit par l'interface web soit via la commande wget), décompresser le contenu, penser à mettre le droit d'execution sur le script et lancer le "Postinstall" à l'intérieur SANS sudo (les sudo se trouvent à l'intérieur du script). En cli cela donne donc :

> wget https://github.com/simbd/Archlinux_PostInstall/archive/master.zip &&
> unzip master.zip && 
> cd Archlinux_PostInstall-master/ && chmod +x Postinstall*sh &&
> ./Postinstall_Archlinux.sh

- 2ème solution : faire avec git clone (avec l'avantage de pouvoir faire la maj du script sans le retélécharger manuellement). Il vous faudra en pré-requis avoir installé git (sudo apt install git).

> git clone https://github.com/simbd/Archlinux_PostInstall.git && cd Archlinux_PostInstall/ &&
> ./Postinstall_Archlinux.sh

Avec cette 2ème solution, si vous voulez réutiliser le script plus tard et vérifier si il y a pas eu une nouvelle maj du script entre temps, dans le dossier du script, il suffira de faire :
> git pull

## Origine

Ce script d'origine est fait pour Ubuntu (cf partie "post install ubuntu"), je l'ai adapté pour Archlinux (certains logiciels sont en communs mais il y a des différences notables).

## Pré-requis (automatique)

Pour fonctionner correctement, le script à besoin des programmes suivants ci-dessous d'installés en pré-requis, cependant, de votre coté vous n'avez rien à faire car si un de ces programmes manquent, ils seront automatiquement installés dès le début au lancement :

- Zenity (permet l'affichage de la fenêtre graphique)
- Notify-send (permet l'affichage de notification)
- Curl (Utilisé par plusieurs logiciels proposés)

## Précisions concernant les balises du type {AUR}, {SNAP}, {FLATPAK} etc...

_Légende_
- {AUR} => Signifie que le logiciel sera installé depuis le dépot communautaire AUR via l'outil YaY (YaY -S nomdusoft...).
- {SNAP} => Signifie que le logiciel est un paquet universel Snap cad installé depuis le SnapStore (snap install....)
- {FLATPAK} => Un peu comme les Snap sauf que ça utilisera Flatpak à la place via le dépot Flathub (flatpak install flathub nomdulogiciel...)
- {APPIMAGE} => Signifie que le logiciel sera récupéré au format AppImage (donc pas installé), le droit d'execution sera déjà correctement positionné. Vos logiciels au format AppImage seront stockés dans un dossier "AppImages" dans votre home.
- {Script LinInstall} => Signifie que le logiciel sera installé avec un script bash qui sera automatiquement récupéré et lancé

(Si il n'y a rien de préciser, cela signifie qu'il s'installe de façon classique avec "pacman -S" depuis les dépots officiels d'Archlinux (ou Manjaro si vous utilisez cette distribution). A noté que pour les paquets universels, vous n'avez pas besoin d'installer de pré-requis, si par exemple vous cochez un logiciel Flatpak et que vous n'avez jamais installé/configuré Flatpak, le script s'en chargera à votre place au 1er logiciel nécessitant Flatpak lors de son installation).

Cas particulier :

- (cli) => C'est juste une précision sur le logiciel pour vous indiquer qu'il ne s'utilise qu'en CLI (Command Line Inteface) c'est à dire en ligne de commande (pas d'interface graphique et souvent pas de raccourci dans le menu/dash des applications). A noté que ce n'est pas précisé pour ceux classé dans la catégorie "outil en cli" puisqu'ils sont tous concernés de toute façon dans cette catégorie donc inutile de le remettre à chaque fois).


***Bonne installation ! ;-)***
