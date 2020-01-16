# README 

##### edit : plus valable, ce readme sera largement modifié plus tard


## A quoi sert le script ? ##

Ceci est un script pour installer un très gros paquet d'applications (et des optimisations) après une installation d'Ubuntu 18.04 ou une variante.
Cela peux donc concerner par exemple :

- Ubuntu 20.04 avec Gnome Shell
- Xubuntu 20.04 avec XFCE
- Ubuntu Mate 20.04 avec Mate
- Plus tard Linux Mint 20 avec Cinnamon (pas avant Juin 2020)
- etc...

Ce script sera maj de temps en temps et systématiquement pour chaque nouvelle LTS (18.04LTS => 20.04LTS etc...). En revanche il ne sera pas modifié/testé pour les versions intérmédiaires avec support à court terme comme la 18.10, 19.04, 19.10.
(cela ne veux pas dire que ça ne fonctionnera pas mais je n'adapterai pas le script pour les versions intérmédiaires, je vous recommande donc de n'utiliser que les LTS avec ce script. Sachez que  si vous utilisez Mint, vous êtes forcément sur une base LTS).

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