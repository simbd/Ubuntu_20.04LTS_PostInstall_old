# README 

## Objectif ##

Ce script sert à installer des logiciels sur une base Ubuntu 20.04LTS avec un très large choix de paquets.
Il y a plusieurs avantages :
- Ce large choix de logiciel est accessible directement au sein d'une interface graphique unifié (via Zenity)
- Il y a une description de chaque logiciel directement dans l'interface ce qui vous permet de voir au premier coup d'oeil ce qui peux vous intéresser ou non.
- Simple à utiliser : pour installer les logiciels, il suffit juste de cocher les cases correspondantes
- Intègre différentes méthodes d'installations (installation via apt install, installation le paquet deb récupéré sur le site de l'éditeur, installation via un PPA ou le dépot de l'éditeur, installation via un Snap, installation avec Flatpak et le dépot Flathub, Récupération au format AppImage, Installation via un script etc...
(A noté que pour ceux qui n'aiment pas les paquets universels, sachez qu'aucun n'est coché par défaut et que quand un logiciel est proposé en paquet universel, c'est explicitement indiqué dans le nom lors du choix).

## Compatibilité ##

Le script est destiné principalement à la version de base d'Ubuntu (Gnome) pour la version 20.04LTS qui sort en Avril.
Cela ne veux pas dire qu'il ne peux pas être utilisé sur une autre configuration mais qu'il a été testé/validé surtout pour celle-ci.

- Si vous souhaitez utiliser le script sur une variante d'Ubuntu plutôt que la version de base (par exemple Xubuntu, Kubuntu, Ubuntu Mate, Linux Mint, ElementaryOS...), je vous recommande fortement au lancement de bien choisir l'option "Tous les choix décochés" par défaut afin de ne pas avoir des paquets utiles pour Gnome uniquement cochés par défaut (ce qui n'aura aucun intérêt pour vous vu que vous n'utilisez pas Gnome avec votre variante). Si vous utilisez KDE (notamment avec Kubuntu ou KDENeon), attention à bien cocher des logiciels cohérents avec cet environnement.

- Si vous souhaitez utiliser le script pour une ancienne version d'Ubuntu, par exemple la 18.04LTS, cela peux fonctionner mais pas pour tous les logiciels, en effet certains s'installent avec une méthode spécifique pour la 20.04 qui ne marchera pas pour la 18.04. A noté que les Snaps/Flatpak/AppImage ne devraient poser à priori aucun problème quelque soit la version (et même sur les autres distributions).

- Et Debian ? Il y a environ 70% des logiciels proposés dans le script qui fonctionneront sur Debian 10 avec ce script et 30% ou ça ne fonctionnera pas. Je ne recommande pas de l'utiliser sous Debian sauf si vous savez ce que vous faites.

## Récupération / Lancement du script

Il y a plusieurs solutions :

- Télécharger le contenu du script (répertoire Ubuntu_20.04LTS_PostInstall) sur ce github (soit par l'interface web soit via la commande wget), décompresser le contenu et lancer le script "Postinstall" à l'intérieur SANS sudo (les sudo se trouvent à l'intérieur du script). En cli cela donne donc :

> wget https://github.com/simbd/Ubuntu_20.04LTS_PostInstall/archive/master.zip &&
> unzip master.zip && 
> cd Ubuntu_20.04LTS_PostInstall-master/ &&
> ./Postinstall_Ubuntu-20.04LTS_FocalFossa.sh

- 2ème solution : faire avec git clone (avec l'avantage de pouvoir faire la maj du script sans le retélécharger manuellement). Il vous faudra en pré-requis avoir installé git (sudo apt install git).

> git clone https://github.com/simbd/Ubuntu_20.04LTS_PostInstall.git && cd https://github.com/simbd/Ubuntu_20.04LTS_PostInstall.git
> ./https://github.com/simbd/Ubuntu_20.04LTS_PostInstall.git

Si vous voulez réutiliser le script plus tard et vérifier si il y a eu une nouvelle maj du script, dans le dossier il suffira de faire :
> git pull



## D'ou vient le script

C'est un fork d'un fork, la base vient de Devil505 (https://github.com/Devil505), celui-ci a été forké ensuite pour être un peu amélioré par "FroggyComputing" (http://computing.travellingfroggy.info/).
Enfin je l'ai reforké car il était très incomplet en terme de choix logiciel et il manquait des fonctions.
J'ai notamment ajouté des fonctions pour pouvoir gérer les paquets Snap et Flatpak et j'ai ajouté un gros paquet de logiciel provenant de mon ancien script qui était entièrement en CLI (cf partie Archives)
(Plus de 80% des logiciels ont été ajoutés par moi-même).
J'ai aussi ajouté des optimisations venant de mon ancien script et des packs de thème graphique. 

## Pré-requis

Pour fonctionner correctement, le script à besoin des programmes suivants d'installés en pré-requis :

- Zenity (permet l'affichage de la fenêtre graphique)
- Notify-send (permet l'affichage de notification)
- Curl (Utilisé par plusieurs logiciels proposés)

Cependant, vous n'avez pas besoin de vous embéter à les installer manuellement vous même : si il manque un de ses logiciels, le script les installera automatiquement dès le début
(sur une Ubuntu de base, normalement il ne manquera que Curl par défaut)

## Comment l'installer/exécuter ? ##

- Téléchargez la dernière version
- Dézippez les fichiers dans le répertoire de votre choix 
- Ajouter le droit d'execution sur le script nommé "Postinstall_Ubuntu2004_FocalFossa.sh" (soit graphiquement soit en CLI avec la commande "chmod +x")
- Lancer le script sans sudo : ./Postinstall_Ubuntu2004_FocalFossa.sh (Attention, les autres fichiers doivent être présent même si vous n'avez pas à les lancer !)

(IMPORTANT : Contrairement à l'ancienne version de mon script, maintenant vous ne devez pas utiliser "sudo" pour le lancer car il y a des déjà ce qu'il faut dans le script et donc le mot de passe vous sera demandé dès que ça sera nécessaire),
de plus certaines actions ne doivent pas se lancer avec les droits admins pour fonctionner correctement, voilà pourquoi il ne faut pas le lancer directement en root.

(NB: si vous avez un soucis de certificat pour télécharger le script (ce qui peux arriver si vous êtes derrière un proxy par ex dans une entreprise ou dans un établissement scolaire), vous pouvez ajouter le paramètre --no-check-certificate à la fin de la commande wget)

# Précisions

- Par défaut, toutes les applications que je pense être utiles (voir nécessaires) sont déjà cochées, à vous de cocher les autres si vous désirez les installer.
- Il est possible que le mot de passe (pour sudo) soit demandé à plusieurs reprises si vous avez sélectionné une grande liste de logiciel, en effet cette commande ne retiens le mot de passe que pendant une certaine durée (pour des raisons de sécurité).


## Précisions concernant les paquets universels et les PPA

Certains parmi-vous peuvent ne pas aimer avoir des logiciels installés via PPA ou des paquets universels (Snap, Flatpak, AppImages), malheureusement pour pas mal de logiciel, il n'y a pas le choix car de nombreuses applications demandés ne sont installables proprement que de cette manière
(ou pour obtenir la dernière version d'un logiciel).
Cependant pour être totalement transparent, chaque logiciel qui s'installerai via un PPA ou un paquet universel est clairement indiqué à coté du nom du logiciel dans une balise {  }.

_Légende_
- {PPA} => Signifie que le logiciel s'installe depuis un dépot PPA
- {SNAP} => Signifie que le logiciel n'est pas un .deb mais un paquet Snap (installé depuis le SnapStore via la commande : snap install)
- {FLATPAK} => Un peu comme les Snap sauf que ça utilise Flatpak à la place (un peu équivalent), utilise le dépot "Flathub (flatpak install...)".
- {APPIMAGE} => Il n'y en a vraiment pas beaucoup dans le script mais si vous en choisissez un, dans ce cas le logiciel ne sera pas installé, vous aurez simplement un fichier en extension ".AppImage" dans le dossier depuis lequel vous avez lancé le script

Cas particulier :

- {Nécessite intervention !} => Indique que pour certains logiciels, l'installation ne peux pas être 100% non-interractive, dans ce cas vous êtes obligé d'intervenir pour que le script puisse continuer (en générale pour valider un contrat de licence)
(c'est le cas par exemple pour Vmware), dans ce cas ça sera indiqué au niveau du nom du logiciel par cette balise.
Par conséquent, si vous cochez un logiciel ou il est indiqué "{Nécessite intervention !}", pensez à contrôler l'avancé du script puisqu'il sera interrompu à un moment donné par l'installation de ce logiciel.


***Bonne installation ! ;-)***
