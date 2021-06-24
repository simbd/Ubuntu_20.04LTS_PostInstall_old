#!/bin/bash
#v1.1

# Script de post-installation pour "Ubuntu 20.04LTS Focal Fossa"

# Code couleur
rouge='\e[1;31m'
jaune='\e[1;33m' 
bleu='\e[1;34m' 
violet='\e[1;35m' 
vert='\e[1;32m'
neutre='\e[0;m'

# Vérification que le script n'est pas lancé directement avec sudo (le script contient déjà les sudos pour les actions lorsque c'est nécessaire)
if [ "$UID" -eq "0" ]
then
    echo -e "${rouge}Merci de ne pas lancer directement ce script avec les droits root : lancez le sans sudo (./Postinstall_Ubuntu-20.04LTS_FF.sh), le mot de passe sera demandé dans le terminal lors de la 1ère action nécessitant le droit administrateur.${neutre}"
    exit
fi

MY_DIR=$(dirname $0)
. $MY_DIR/Config_Function.sh
. $MY_DIR/Zenity_default_choice.sh

# Placement dans /tmp
cd /tmp

if [ $? = 0 ]
then
    	# Debut
	f_action_exec "$CA_PARTNER" "sudo sed -i.bak '/^# deb .*partner/ s/^# //' /etc/apt/sources.list"
	f_action_exec "$CA_UPGRADE" "sudo apt update ; sudo apt full-upgrade -y"
	f_action_install "$CA_FRENCH" "$(check-language-support -l fr)"
	f_action_install "$CA_PACKUTILE" "net-tools build-essential gettext curl vim neofetch ncdu ffmpegthumbs ffmpegthumbnailer xterm inxi hdparm cpu-x rsync ppa-purge speedtest-cli"
	f_action_install "$CA_PACKCODEC" "x264 x265 flac opus-tools vorbis-tools lame mkvtoolnix mkvtoolnix-gui oggvideotools"
	f_action_install "$CA_GNOMESUPPLEMENT" "chrome-gnome-shell gnome-firmware gnome-tweak-tool gconf-editor gnome-shell-extension-prefs"
    
    	# Sessions
    	f_action_install "$CA_GNOMEVANILLA" gnome-session
    	f_action_install "$CA_GNOMECLASSIC" gnome-shell-extensions
    	f_action_install "$CA_GNOMEFLASHBACKM" gnome-session-flashback
    	f_action_install "$CA_GNOMEFLASHBACKC" "gnome-session-flashback compiz compizconfig-settings-manager compiz-plugins compiz-plugins-extra"
   	
	# Navigateurs
    	f_action_snap_install "$CA_BEAKER" beaker-browser
    	f_RepositoryExt_Install "$CA_BRAVE" "brave-browser-release" "https://brave-browser-apt-release.s3.brave.com/brave-core.asc" "[arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" "brave-browser"
    	f_action_flatpak_install "$CA_CHROMIUM" org.chromium.Chromium
	f_action_exec "$CA_CHROMIUMBETA" "wget https://raw.githubusercontent.com/simbd/ConfigFiles/master/chromium-beta.pref && sudo mv chro*.pref /etc/apt/preferences.d/ && sudo apt update" #(Pour ne pas que le snap prenne le dessus)
	f_action_ppa_install "$CA_CHROMIUMBETA" ppa:saiarcot895/chromium-beta "chromium-browser"
    	f_action_snap_install "$CA_CLIQZ" "cliqz --beta"
    	f_action_install "$CA_DILLO" dillo
    	f_action_flatpak_install "$CA_EOLIE" org.gnome.Eolie
    	f_action_install "$CA_FALKON" falkon
   	f_action_ppa_install "$CA_FIREFOXBETA" ppa:mozillateam/firefox-next "firefox firefox-locale-fr"
   	f_action_LinInstall "$CA_FIREFOXDEVELOPER" FirefoxDeveloperEdition
   	f_action_ppa_install "$CA_FIREFOXESR" ppa:mozillateam/ppa "firefox-esr firefox-esr-locale-fr"
   	f_action_ppa_install "$CA_FIREFOXNIGHTLY" ppa:ubuntu-mozilla-daily/ppa "firefox-trunk firefox-trunk-locale-fr"
    	f_action_install "$CA_EPIPHANY" epiphany-browser	
    	f_RepositoryExt_Install "$CA_CHROME" "google-chrome" "https://dl-ssl.google.com/linux/linux_signing_key.pub" "[arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" "google-chrome-stable"
    	f_action_install "$CA_LYNX" lynx
	f_action_get "$CA_EDGE" "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-dev/microsoft-edge-dev_93.0.916.1-1_amd64.deb"
	f_action_install "$CA_MIDORI" midori
    	f_action_snap_install "$CA_OPERA" opera
	f_RepositoryExt_Install "$CA_PALEMOON" "home:stevenpusser" "https://download.opensuse.org/repositories/home:stevenpusser/xUbuntu_19.10/Release.key" "http://download.opensuse.org/repositories/home:/stevenpusser/xUbuntu_19.10/ /" "palemoon"
    	f_action_get "$CA_SRWAREIRON" "http://www.srware.net/downloads/iron64.deb"
    	f_action_install "$CA_TORBROWSER" torbrowser-launcher  
    	f_action_get "$CA_VIVALDI" "https://downloads.vivaldi.com/stable/vivaldi-stable_4.0.2312.33-1_amd64.deb" #(Dépot vivaldi auto-ajouté donc soft toujours à jour)
	f_action_exec "$CA_VIVALDI" "sudo apt update && sudo apt upgrade vivaldi-stable -y" #Pour que  vivaldi soit à jour dès le départ
	
    	# Internet / Tchat / Messagerie / Téléchargement / Contrôle à distance
    	# (Section re-divisé en 3 parties cf Zenity_default_choice.sh)
    	f_RepositoryExt_Install "$CA_ANYDESK" "anydesk-stable" "https://keys.anydesk.com/repos/DEB-GPG-KEY" "http://deb.anydesk.com/ all main" "anydesk"
    	f_action_install "$CA_CLUSTERSSH" clusterssh
    	f_action_get_appimage "$CA_COZYDRIVE" "https://github.com/cozy-labs/cozy-desktop/releases/download/v3.20.0/Cozy-Drive-3.20.0-x86_64.AppImage"
    	f_action_install "$CA_DELUGE" deluge
	f_action_get "$CA_DISCORD" "https://dl.discordapp.net/apps/linux/0.0.15/discord-0.0.15.deb"
    	f_action_install "$CA_DROPBOX" nautilus-dropbox
	f_action_get "$CA_DUKTO" "https://download.opensuse.org/repositories/home:/colomboem/xUbuntu_16.04/amd64/dukto_6.0-1_amd64.deb" #{a reverifier}
    	f_action_exec "$CA_DWSERVICE" "wget https://www.dwservice.net/download/dwagent_x86.sh && chmod +x dwagent* ; mv dwagent* ~/"
    	f_action_install "$CA_EISKALTDC" "eiskaltdcpp eiskaltdcpp-gtk3"
    	f_action_install "$CA_EMPATHY" empathy    
	f_action_install "$CA_EVOLUTION" evolution
	f_action_install "$CA_FILEZILLA" filezilla    
	f_action_get "$CA_FROSTWIRE" "https://prime.frostwire.com/frostwire/6.8.4/frostwire-6.8.4.amd64.deb"
   	f_action_install "$CA_GEARY" geary
	f_action_install "$CA_GFTP" gftp
   	f_action_snap_install "$CA_GYDL" gydl
	f_action_install "$CA_HEXCHAT" hexchat  
	f_action_get "$CA_HUBIC" "http://mir7.ovh.net/ovh-applications/hubic/hubiC-Linux/2.1.0/hubiC-Linux-2.1.0.53-linux.deb"
	f_action_install "$CA_JAMI" jami
	f_RepositoryExt_Install "$CA_JITSI" "jitsi-stable" "https://download.jitsi.org/jitsi-key.gpg.key" "https://download.jitsi.org stable/" "jitsi"
	f_action_install "$CA_KVIRC" kvirc
	f_action_install "$CA_LINPHONE" linphone 
	f_action_snap_install "$CA_MAILSPRING" mailspring
	f_action_snap_install "$CA_MATTERMOST" mattermost-desktop
	f_action_get "$CA_MEGASYNC" "https://mega.nz/linux/MEGAsync/xUbuntu_20.04/amd64/megasync-xUbuntu_20.04_amd64.deb"
	f_action_get "$CA_MEGASYNC" "https://mega.nz/linux/MEGAsync/xUbuntu_20.04/amd64/nautilus-megasync-xUbuntu_20.04_amd64.deb"
	f_action_install "$CA_MUMBLE" mumble
	f_action_install "$CA_NEXTCLOUD" "nextcloud-desktop nextcloud-desktop-cmd nextcloud-desktop-l10n"
	f_action_ppa_install "$CA_NICOTINE" ppa:nicotine-team/stable nicotine
	f_action_install "$CA_OPENSSHSERVER" openssh-server
	f_action_install "$CA_PIDGIN" "pidgin pidgin-plugin-pack"
	f_action_install "$CA_POLARI" polari
	f_action_install "$CA_PSI" psi
	f_action_install "$CA_PUTTY" putty
	f_action_install "$CA_QBITTORRENT" qbittorrent	
	f_action_install "$CA_RDESKTOP" rdesktop	
	f_action_install "$CA_REMMINA" "remmina remmina-plugin-nx remmina-plugin-rdp remmina-plugin-spice remmina-plugin-vnc"
	f_action_flatpak_install "$CA_RIOT" im.riot.Riot #alias Element-Desktop
	f_RepositoryExt_Install "$CA_SIGNAL" "signal-desktop" "https://updates.signal.org/desktop/apt/keys.asc" "[arch=amd64] https://updates.signal.org/desktop/apt xenial main" "signal-desktop"
    	f_action_get "$CA_SKYPE" "https://go.skype.com/skypeforlinux-64.deb" #Maj auto via dépot ajouté
	f_action_snap_install "$CA_SLACK" "slack --classic"
	f_action_get_appimage "$CA_SOULSEEK" "http://nux87.free.fr/script-postinstall-ubuntu/appimage/SoulseekQt-2018-1-30-64bit.AppImage"
    	f_action_install "$CA_SUBDOWNLOADER" subdownloader
	f_action_install "$CA_SYNCTHING" syncthing
	f_action_get "$CA_TEAMS" "https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.4.00.13653_amd64.deb"
	f_action_flatpak_install "$CA_TEAMSPEAK" com.teamspeak.TeamSpeak
	f_action_get "$CA_TEAMVIEWER" "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"
	f_action_install "$CA_TELEGRAM" telegram-desktop
	f_action_install "$CA_THUNDERBIRD" "thunderbird thunderbird-locale-fr thunderbird-gnome-support fonts-symbola"
	f_action_install "$CA_TRANSMISSION" transmission-gtk
	f_action_install "$CA_UGET" uget	
	f_action_snap_install "$CA_VUZE" "vuze-vs"
	f_action_install "$CA_WEECHAT" weechat
	f_action_get "$CA_WHALEBIRD" "https://github.com/h3poteto/whalebird-desktop/releases/download/4.4.1/Whalebird-4.4.1-linux-x64.deb"
	f_action_snap_install "$CA_WHATSDESK" whatsdesk
	f_RepositoryExt_Install "$CA_WIREDESK" "wire-desktop" "http://wire-app.wire.com/linux/releases.key" "[arch=amd64] https://wire-app.wire.com/linux/debian stable main" "wire-desktop" ##PB : dépot bien ajouté mais n'installe pas les paquets
	f_action_install "$CA_WIREDESK" apt-transport-https #dépendance
	f_action_install "$CA_WORMHOLE" magic-wormhole
	f_action_install "$CA_X2GO" x2goclient
	f_action_install "$CA_X11VNC" x11vnc
	f_action_install "$CA_XCHAT" xchat
	f_action_install "$CA_YTDLND" youtube-dl
	f_action_get "$CA_ZOOM" "https://zoom.us/client/latest/zoom_amd64.deb"
	
	# Bureautique/Mail
	f_action_get "$CA_BOOSTNOTE" "https://github.com/BoostIO/boost-releases/releases/download/v0.15.3/boostnote_0.15.3_amd64.deb"
	f_action_install "$CA_CALIBRE" calibre
	f_action_install "$CA_CALLIGRA" calligra
	f_action_snap_install "$CA_CHERRYTREE" cherrytree
	f_action_snap_install "$CA_DRAWIO" drawio
	f_action_install "$CA_FRDIC" "myspell-fr-gut wfrench aspell-fr hyphen-fr mythes-fr"
	f_action_install "$CA_FBREADER" fbreader
	f_action_install "$CA_FEEDREADER" feedreader
	f_action_install "$CA_FONTFORGE" "fontforge fontforge-extras"
	f_action_snap_install "$CA_FREEMIND" freemind
	f_action_get "$CA_FREEOFFICE" "https://www.softmaker.net/down/softmaker-freeoffice-2018_980-01_amd64.deb"
	f_action_install "$CA_FREEPLANE" freeplane
	f_action_install "$CA_GNOMEOFFICE" "abiword gnumeric dia planner glabels glom gnucash"
	f_action_install "$CA_GNOTE" gnote
	f_action_install "$CA_GRAMPS" gramps
	f_action_get_appimage "$CA_JOPLIN" "https://github.com/laurent22/joplin/releases/download/v2.0.11/Joplin-2.0.11.AppImage"
    	f_action_install "$CA_LIBREOFFICEDEPOT" "libreoffice libreoffice-l10n-fr libreoffice-style-breeze"
	f_action_ppa_install "$CA_LIBREOFFICEFRESH" ppa:libreoffice/ppa "libreoffice libreoffice-l10n-fr libreoffice-style-breeze"
	f_action_install "$CA_LIBREOFFICESUP" "libreoffice-style-elementary libreoffice-style-oxygen libreoffice-style-human libreoffice-style-sifr libreoffice-style-tango libreoffice-templates openclipart-libreoffice"
	f_action_exec "$CA_LIBREOFFICESUP" "wget https://grammalecte.net/grammalecte/oxt/Grammalecte-fr-v2.1.2.oxt --no-check-certificate ; chmod +x Grammalecte*.oxt ; sudo unopkg add --shared Grammalecte*.oxt ; rm Grammalecte*.oxt"
	f_action_get "$CA_MASTERPDFEDITOR" "https://code-industry.net/public/master-pdf-editor-5.7.60-qt5.x86_64.deb"
	f_action_install "$CA_MCOMIX" mcomix
	f_action_snap_install "$CA_OFFICEWEBAPPS" "unofficial-webapp-office"
	f_action_flatpak_install "$CA_NOTESUP" com.github.philip_scott.notes-up  
	f_action_flatpak_install "$CA_ONLYOFFICE" org.onlyoffice.desktopeditors
    	f_action_LinInstall "$CA_OPENOFFICE" OpenOffice
    	f_action_install "$CA_PANDOC" pandoc
    	f_action_install "$CA_PDFMOD" pdfmod
	f_action_get "$CA_PDFSAM" "https://github.com/torakiki/pdfsam/releases/download/v4.2.1/pdfsam_4.2.1-1_amd64.deb"
    	f_action_install "$CA_PDFSHUFFLER" pdfshuffler
    	#f_action_exec "$CA_POLICEMST" "echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo /usr/bin/debconf-set-selections ; sudo apt install ttf-mscorefonts-installer -y"
	f_action_get "$CA_POLICEMST" "http://ftp.fr.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.8_all.deb"
	f_action_snap_install "$CA_PROJECTLIBRE" "projectlibre" 
    	f_action_LinInstall "$CA_SCENARI" Scenari
    	f_action_install "$CA_SCRIBUS" "scribus scribus-template"	
	f_action_flatpak_install "$CA_SPICEUP" "com.github.philip_scott.spice-up"
	f_action_install "$CA_UMBRELLO" "umbrello --no-install-recommends"
	f_action_get "$CA_WPSOFFICE" "http://fr.archive.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb" 
	f_action_get "$CA_WPSOFFICE" "https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/9719/wps-office_11.1.0.9719.XA_amd64.deb"
	f_action_get "$CA_XMIND" "https://dl3.xmind.net/XMind-2020-for-Linux-amd-64bit-10.3.1-202101132117.deb"
	f_action_install "$CA_XOURNAL" xournal
	f_action_install "$CA_XPAD" xpad
	f_action_install "$CA_ZEAL" zeal
	f_action_get "$CA_ZETTLR" "https://github.com/Zettlr/Zettlr/releases/download/v1.8.9/Zettlr-1.8.9-amd64.deb"
	f_action_install "$CA_ZIM" zim	
	
	# Lecture Multimedia
	f_action_install "$CA_AUDACIOUS" audacious
	f_action_install "$CA_CANTATA" "cantata mpd"
	f_action_install "$CA_CLEMENTINE" clementine
	f_action_get_appimage "$CA_DEEZLOADER" "https://srv-file5.gofile.io/download/r4sZke/Deezloader_Remix_4.3.0-x86_64.AppImage"
	f_action_install "$CA_FLASH" "adobe-flashplugin pepperflashplugin-nonfree"
	f_action_flatpak_install "$CA_FONDO" com.github.calo001.fondo
    	f_action_install "$CA_CELLULOID" celluloid
    	f_action_install "$CA_GNOMEMUSIC" gnome-music
    	f_action_install "$CA_GNOMETWITCH" gnome-twitch
	f_action_install "$CA_LOLLYPOP" lollypop
	f_action_get_appimage "$CA_MEDIAELCH" "https://github.com/Komet/MediaElch/releases/download/v2.6.4/MediaElch_2.6.4_linux.AppImage"
	f_action_LinInstall "$CA_MOLOTOVTV" Molotov ##(AppImage récupéré auto par le script)
	f_action_snap_install "$CA_ODIO" odio
	f_action_install "$CA_PAROLE" parole
    	f_action_install "$CA_PAVUCONTROL" pavucontrol	
    	f_action_ppa_install "$CA_QARTE" ppa:vincent-vandevyvre/vvv qarte
    	f_action_install "$CA_QMMP" qmmp	
    	f_action_install "$CA_QUODLIBET" quodlibet	
    	f_action_install "$CA_RHYTHMBOX" rhythmbox
	f_action_flatpak_install "$CA_SHORTWAVE" de.haeckerfelix.Shortwave
    	f_action_install "$CA_SHOTWELL" shotwell	
    	f_action_install "$CA_SMPLAYER" "smplayer smplayer-l10n smplayer-themes"	    
    	f_RepositoryExt_Install "$CA_SPOTIFY" "spotify" "https://download.spotify.com/debian/pubkey.gpg" "http://repository.spotify.com stable non-free" "spotify-client-gnome-support"
	f_action_flatpak_install "$CA_TAUON" com.github.taiko2k.tauonmb
	f_action_install "$CA_VLCSTABLE" "vlc vlc-l10n"
    	f_action_install "$CA_RESTRICT_EXTRA" ubuntu-restricted-extras
		
	# Montage Multimédia
	# (Section re-divisé en 3 parties cf Zenity_default_choice.sh)
	f_action_exec "$CA_ARDOUR" "echo 'ardour jackd/tweak_rt_limits boolean false' | sudo debconf-set-selections"
	f_action_install "$CA_ARDOUR" ardour
	f_action_install "$CA_AUDACITY" audacity
	f_action_flatpak_install "$CA_AVIDEMUX" org.avidemux.Avidemux
	f_action_install "$CA_BLENDER" blender	
	#f_action_exec "$CA_CINELERRA" "echo 'deb [trusted=yes] https://cinelerra-gg.org/download/pkgs/ub18 bionic main' | sudo tee -a /etc/apt/sources.list.d/cinelerra.list" ##=> pour cinelerra gg erreur libIlmThread-2_2.so.12
	f_action_ppa_install "$CA_CINELERRA" ppa:cinelerra-ppa/ppa cinelerra-cv #(version de 2018...)
	f_action_install "$CA_CURA" cura
	f_action_install "$CA_DARKTABLE" darktable
	f_action_get_appimage "$CA_DIGIKAM" "https://download.kde.org/stable/digikam/6.4.0/digikam-6.4.0-x86-64.appimage"
	f_action_install "$CA_EASYTAG" easytag
	f_action_install "$CA_FFMPEG" ffmpeg
	f_action_snap_install "$CA_FLACON" flacon-tabetai
	f_action_install "$CA_FLAMESHOT" flameshot
	f_action_flatpak_install "$CA_FLOWBLADE" flowblade
	f_action_install "$CA_FREECAD" freecad
	f_action_install "$CA_GIADA" giada
	f_action_install "$CA_GIMP" "gimp gimp-help-fr gimp-data-extras"
	f_action_flatpak_install "$CA_GIMPDEV" "" #champ vide volontaire pr install de flatpak si ce n'est pas le cas
	f_action_exec "$CA_GIMPDEV" "flatpak install --user https://flathub.org/beta-repo/appstream/org.gimp.GIMP.flatpakref -y"
	f_action_install "$CA_GNOMESOUNDRECORDER" gnome-sound-recorder
	f_action_install "$CA_GTHUMB" gthumb
	f_action_install "$CA_HANDBRAKE" handbrake
	f_action_install "$CA_HYDROGEN" hydrogen
	f_action_flatpak_install "$CA_IMCOMPRESSOR" com.github.huluti.ImCompressor
	f_action_install "$CA_INKSCAPE" inkscape
	# f_action_install "$CA_K3D" k3d
	f_action_install "$CA_KAZAM" kazam	
	f_action_install "$CA_KDENLIVE" kdenlive		
	f_action_install "$CA_KOLOURPAINT" kolourpaint	
	f_action_install "$CA_KRITA" "krita krita-l10n"
	f_action_install "$CA_LEOCAD" leocad
	f_action_get "$CA_LIGHTWORKS" "https://cdn.lwks.com/releases/2021.2.1/lightworks_2021.2_r128456.deb"
	f_action_install "$CA_LIBRECAD" librecad
	f_action_install "$CA_LILYPOND" lilypond
	f_action_install "$CA_LIVES" lives	
	f_action_install "$CA_LUMINANCE" luminance-hdr
	f_action_install "$CA_LMMS" lmms	
	f_action_install "$CA_MHWAVEEDIT" mhwaveedit
	f_action_install "$CA_MILKYTRACKER" milkytracker
	f_action_install "$CA_MINUET" minuet
	f_action_install "$CA_MIXXX" mixxx
	f_action_install "$CA_MUSESCORE" musescore3	
	f_action_ppa_install "$CA_MUSICBRAINZ" ppa:musicbrainz-developers/stable "picard" 
	f_action_flatpak_install "$CA_MYPAINT" "org.mypaint.MyPaint"	 
	f_action_snap_install "$CA_NATRON" natron
	f_action_install "$CA_OBS" "ffmpeg obs-studio"
	f_action_install "$CA_OLIVE" olive-editor
	f_action_install "$CA_OPENSCAD" openscad
	f_action_install "$CA_OPENSHOT" openshot-qt
	f_action_snap_install "$CA_OPENTOONZ" opentoonz
	f_action_install "$CA_PEEK" peek
	f_action_install "$CA_PINTA" pinta	
	f_action_install "$CA_PITIVI" pitivi	
	f_action_get "$CA_PIXELUVO" "http://www.pixeluvo.com/downloads/pixeluvo_1.6.0-2_amd64.deb"
	f_action_install "$CA_RAWTHERAPEE" rawtherapee
	f_action_install "$CA_ROSEGARDEN" rosegarden
	f_action_snap_install "$CA_SHOTCUT" "shotcut --classic"
	f_action_ppa_install "$CA_SHUTTER" ppa:linuxuprising/shutter "shutter"
	f_action_install "$CA_SIMPLESCREENRECORDER" simplescreenrecorder 
	f_action_install "$CA_SOLVESPACE" solvespace
	f_action_install "$CA_SOUNDJUICER" sound-juicer
	f_action_install "$CA_SOUNDKONVERTER" soundkonverter
	f_action_install "$CA_SWEETHOME" "sweethome3d sweethome3d-furniture sweethome3d-furniture-nonfree sweethome3d-textures-editor sweethome3d-furniture-editor" 
	f_action_install "$CA_SYNFIG" "synfig synfigstudio"
	f_action_get_appimage "$CA_UNITY3DEDITOR" "https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage"
	f_action_flatpak_install "$CA_VIDCUTTER" "com.ozmartians.VidCutter"
	f_action_install "$CA_VOKOSCREEN" vokoscreen
	f_action_install "$CA_WINFF" "winff winff-qt"
	f_action_install "$CA_XNVIEW" libopenal1  # dépendance nécessaire
	f_action_get "$CA_XNVIEW" "https://download.xnview.com/XnViewMP-linux-x64.deb"
	f_action_install "$CA_ZYNADDSUBFX" zynaddsubfx
	
	# Science/Education
	f_action_install "$CA_ALGOBOX" algobox
	f_action_install "$CA_AMC" auto-multiple-choice
	f_action_install "$CA_ASTROEDU" astro-education
	f_action_install "$CA_AVOGADRO" avogadro
	f_action_LinInstall "$CA_CELESTIA" Celestia ##(AppImage récupéré par le script)
	f_action_install "$CA_CONVERTALL" convertall
	f_action_get "$CA_FILIUS" "https://www.lernsoftware-filius.de/downloads/Setup/filius_1.9.0_all.deb"
	f_action_install "$CA_FRITZING" fritzing
	f_action_get "$CA_GANTTPROJECT" "https://dl.ganttproject.biz/ganttproject-3.1.3102/ganttproject_3.1.3102-1_all.deb"
	f_action_install "$CA_GCOMPRIS" "gcompris gcompris-qt gcompris-qt-data gnucap"
	f_action_install "$CA_GELEMENTAL" gelemental
	f_RepositoryExt_Install "$CA_GEOGEBRA" "geogebra" "https://static.geogebra.org/linux/office@geogebra.org.gpg.key" "http://www.geogebra.net/linux/ stable main" "geogebra-classic"
	f_action_install "$CA_GNOMEMAPS" gnome-maps
	f_action_get "$CA_GOOGLEEARTH" "https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb"
	f_action_exec "$CA_GOOGLEEARTH" "sudo rm -f /etc/apt/sources.list.d/google-earth-pro*" #dépot supprimé car pose soucis systématiquement
	f_action_flatpak_install "$CA_JASP" org.jaspstats.JASP
	f_action_install "$CA_JOSM" josm
	f_action_install "$CA_KICAD" "kicad kicad-libraries kicad-templates kicad-packages3d kicad-symbols kicad-doc-fr"
	f_action_install "$CA_LABPLOT" labplot
	f_action_install "$CA_MARBLE" "--no-install-recommends marble"
	f_action_install "$CA_OCTAVE" octave
	f_action_flatpak_install "$CA_OPENBOARD" ch.openboard.OpenBoard
	f_action_install "$CA_OPTGEO" optgeo
	f_action_install "$CA_PLANNER" planner
	f_action_flatpak_install "$CA_QGIS" org.qgis.qgis
	f_action_install "$CA_SAGEMATH" sagemath
	f_action_install "$CA_SCILAB" scilab
	f_action_exec "$CA_SCRATCH" "wget http://nux87.free.fr/script-postinstall-ubuntu/theme/scratch.png ; wget https://gitlab.com/simbd/Fichier_de_config/raw/master/scratch.desktop ; wget http://www.ac-grenoble.fr/maths/scratch/scratch.zip ; sudo unzip scratch.zip -d /opt/scratch3 ; rm scratch.zip ; sudo mv scratch.png /usr/share/icons/ ; sudo mv scratch.desktop /usr/share/applications/"
	f_action_install "$CA_SKYCHART" "libgtk2.0-0 libglib2.0-0 libpango1.0-0 libjpeg62 libsqlite3-0" #dépendance pour skychart
	f_action_exec "$CA_SKYCHART" "echo 'deb [trusted=yes] http://www.ap-i.net/apt stable main' | sudo tee -a /etc/apt/sources.list.d/skychart.list ; sudo apt update ; sudo apt install -y skychart ; sudo rm /etc/apt/sources.list.d/skychart.list"
	f_action_install "$CA_STELLARIUM" stellarium
	f_action_install "$CA_TOUTENCLIC" python3-pyqt5
	f_action_exec "$CA_TOUTENCLIC" "wget http://www.bipede.fr/downloads/logiciels/ToutEnClic.zip ; unzip ToutEnClic.zip ; rm ToutEnClic.zip ; sudo mv ToutEnClic /opt/ ; wget https://gitlab.com/simbd/Fichier_de_config/raw/master/toutenclic.desktop --no-check-certificate ; sudo mv toutenclic.desktop /usr/share/applications/ ; wget http://nux87.free.fr/script-postinstall-ubuntu/theme/toutenclic.png --no-check-certificate ; sudo mv toutenclic.png /usr/share/icons/"
	f_action_install "$CA_TUXMATH" tuxmath
	f_action_install "$CA_XCAS" xcas
	f_action_get "$CA_XEPHEM" "http://e2rd.piekielko.pl/debian/binary-amd64/xephem_3.7.7-4_amd64.deb"

	# Virtualisation, Conteneurisation, Emulation & Déploiement
	f_action_install "$CA_ANBOX" anbox
	f_action_snap_install "$CA_CITRA" "--edge citra-mts"
	f_action_install "$CA_DESMUME" desmume
	f_action_install "$CA_DOCKER" "docker.io"
	f_action_install "$CA_DOLPHIN" dolphin-emu
	f_action_install "$CA_DOSBOX" dosbox
	f_action_get "$CA_GENS" "https://retrocdn.net/images/e/e9/Gens_2.16.8-r7orig_amd64.deb"
	f_action_install "$CA_GNOMEBOXES" gnome-boxes
	f_action_exec "$CA_GNS" "echo 'ubridge ubridge/install-setuid boolean true' | sudo debconf-set-selections"
	f_action_ppa_install "$CA_GNS" "ppa:gns3/ppa" "dynamips ubridge vpcs gns3-gui gns3-server"
	f_action_install "$CA_QEMUKVM" "qemu qemu-kvm qemu-system-gui qemu-system-arm qemu-utils virt-manager virt-viewer"
	f_action_install "$CA_LXC" lxc
	f_action_install "$CA_MEDNAFEN" mednafen
	f_action_install "$CA_MGBA" mgba-qt
	f_action_install "$CA_MUPEN64" mupen64plus-qt
	f_action_install "$CA_POL" playonlinux
	f_action_flatpak_install "$CA_PPSSPP" "org.ppsspp.PPSSPP"
	f_action_install "$CA_RETROARCH" retroarch
	f_action_install "$CA_VBOXDEPOT" "virtualbox virtualbox-qt virtualbox-ext-pack"
	f_RepositoryExt_Install "$CA_VBOXLAST" "virtualbox" "http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc" "[arch=amd64] http://download.virtualbox.org/virtualbox/debian focal contrib" "virtualbox-6.1"
    	f_action_exec "$CA_VBOXLAST" "sudo usermod -G vboxusers -a $USER"
	f_action_exec "$CA_VMWAREHORIZON" "wget https://download3.vmware.com/software/view/viewclients/CART21FQ2/VMware-Horizon-Client-2006-8.0.0-16522670.x64.bundle && chmod +x VMware*Horizon* && sudo ./VMware-Horizon-Client*.bundle --console ; rm VMware*bundle"
	f_action_exec "$CA_VMWARE" "sudo apt install gcc -y ; wget https://download3.vmware.com/software/player/file/VMware-Player-16.1.0-17198959.x86_64.bundle && sudo chmod +x VMware-Player*.bundle ; sudo ./VMware-Player-16.1.0-17198959.x86_64.bundle --eulas-agreed --console --required ; sudo rm VMware-Player*"
	f_action_exec "$CA_VMWAREPRO" "sudo apt install gcc -y ; wget https://download3.vmware.com/software/wkst/file/VMware-Workstation-Full-16.1.0-17198959.x86_64.bundle && sudo chmod +x VMware-Workstation*.bundle ; sudo ./VMware-Workstation-Full-16.1.0-17198959.x86_64.bundle --eulas-agreed --console --required ; sudo rm VMware-Workstation*"
	f_action_install "$CA_WINE" "wine-development wine64-development wine64-development-tools winetricks"
	
	# Utilitaires graphiques
	f_action_install "$CA_ACTIONA" "actiona actionaz"
	f_action_exec "$CA_APPOUTLET" "wget https://appoutlet.herokuapp.com/download/deb -O appoutlet.deb ; sudo apt install -y ./appoutlet.deb ; rm appoutlet.deb"
	f_action_LinInstall "$CA_BITCOINCORE" BitcoinCore
	f_action_install "$CA_BRASERO" brasero
	f_action_install "$CA_CHEESE" cheese
	f_action_install "$CA_DEJADUP" deja-dup
	f_action_install "$CA_DIODON" diodon
	f_action_get_appimage "$CA_ELECTRUM" "https://download.electrum.org/4.1.4/electrum-4.1.4-x86_64.AppImage"
	f_action_get_appimage "$CA_ETCHER" "https://github.com/balena-io/etcher/releases/download/v1.5.79/balenaEtcher-1.5.79-ia32.AppImage"
	f_action_get "$CA_ETHEREUMWALLET" "https://github.com/ethereum/mist/releases/download/v0.11.1/Ethereum-Wallet-linux64-0-11-1.deb"
	f_action_install "$CA_GITCOLA" git-cola
	f_action_install "$CA_GLABELS" glabels
	f_action_install "$CA_GNOME_DISK" gnome-disk-utility
	f_action_install "$CA_GNOMERECIPES" gnome-recipes
	f_action_install "$CA_GSHUTDOWN" gshutdown
	f_action_install "$CA_GSYSLOG" gnome-system-log
	f_action_install "$CA_GSYSMON" gnome-system-monitor
	f_action_install "$CA_HOMEBANK" homebank
	f_action_install "$CA_GPARTED" gparted
	f_action_install "$CA_MELD" meld
	f_action_LinInstall "$CA_MULTISYSTEM" Multisystem
	f_action_LinInstall "$CA_MYTOURBOOK" Mytourbook
	f_action_install "$CA_ARCHIVAGE" "zip unzip unace rar unrar p7zip-rar p7zip-full sharutils uudeview mpack arj cabextract lzip lunzip zstd lbzip2 pigz"
	f_action_install "$CA_RECHERCHE" "recoll catfish searchmonkey"
	f_action_install "$CA_REDSHIFT" redshift-gtk
	f_action_install "$CA_SPEEDCRUNCH" speedcrunch
	f_action_exec "$CA_SUBLIM_NAUT" "wget https://raw.githubusercontent.com/Diaoul/nautilus-subliminal/master/install.sh -O - | sudo bash"
	f_action_install "$CA_SUB_EDIT" subtitleeditor
	f_action_install "$CA_SYNAPTIC" synaptic
	f_action_install "$CA_TERMINATOR" terminator
	f_action_install "$CA_TILIX" tilix
	f_action_install "$CA_TIMESHIFT" timeshift
	f_action_install "$CA_VARIETY" variety
	
	# Utilitaires en CLI
	f_action_install "$CA_ASCIINEMA" asciinema
	f_action_install "$CA_DDRESCUE" gddrescue
	f_action_install "$CA_FD" fd-find	
	f_action_install "$CA_GIT" git
	f_action_install "$CA_HTOP" htop
	f_action_LinInstall "$CA_GEEKBENCH" Geekbench
	f_action_install "$CA_GLANCES" glances
	f_action_install "$CA_HG" mercurial
	f_action_install "$CA_IMAGEMAGICK" imagemagick
	f_action_install "$CA_NIX" curl
	f_action_exec "$CA_NIX" "curl https://nixos.org/nix/install | sh"
	f_action_install "$CA_PACKRECUP" "testdisk scalpel foremost"
	f_action_snap_install "$CA_POWERSHELL" "powershell --classic"	
	f_action_install "$CA_RIPGREP" ripgrep
	f_action_install "$CA_RTORRENT" rtorrent
	f_action_install "$CA_SCREEN" screen
	f_action_install "$CA_SMARTMONTOOLS" "--no-install-recommends smartmontools"
	f_action_install "$CA_TLDR" tldr
	f_action_install "$CA_WORDGRINDER" "wordgrinder wordgrinder-x11"

	# Réseaux et sécurité
	f_action_install "$CA_ADBFASTBOOT" "adb fastboot"
	f_action_install "$CA_ANSIBLE" ansible
	f_action_install "$CA_APPARMOR" "apparmor apparmor-profiles apparmor-utils"
	f_action_snap_install "$CA_BITWARDEN" bitwarden
	f_action_get "$CA_BUTTERCUP" "https://github.com/buttercup/buttercup-desktop/releases/download/v1.19.0/buttercup-desktop_1.19.0_amd64.deb"
	f_action_install "$CA_CISCOVPN" "openconnect network-manager-openconnect-gnome"
	f_action_get_appimage "$CA_CRYPTER" "https://github.com/HR/Crypter/releases/download/v4.0.0/Crypter-4.0.0.AppImage"
	f_action_get_appimage "$CA_CRYPTOMATOR" "https://dl.bintray.com/cryptomator/cryptomator/1.4.15/cryptomator-1.4.15-x86_64.AppImage"
	f_RepositoryExt_Install "$CA_ENPASS" "enpass" "https://dl.sinew.in/keys/enpass-linux.key" "http://repo.sinew.in/ stable main" "enpass"
	f_action_install "$CA_FUSIONINVENTORY" fusioninventory-agent
	f_action_install "$CA_GUFW" gufw
	f_action_install "$CA_HACKINGPACK" "tcpdump nmap netdiscover aircrack-ng ophcrack ophcrack-cli crunch john hashcat"
	f_action_install "$CA_KEEPASS2" keepass2
    	f_action_install "$CA_KEEPASSXC" keepassxc
	f_action_get "$CA_KEEWEB" "https://github.com/keeweb/keeweb/releases/download/v1.12.3/KeeWeb-1.12.3.linux.x64.deb"
	f_action_install "$CA_MALTEGO" openjdk-14-jre #dépendance java nécessaire pour Maltego
	f_action_get "$CA_MALTEGO" "https://maltego-downloads.s3.us-east-2.amazonaws.com/linux/Maltego.v4.2.9.12898.deb"
	f_action_get "$CA_MYSQLWB" "https://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb"
	f_action_install "$CA_OCSINVENTORY" ocsinventory-agent
	f_action_install "$CA_OPENVAS" "openvas openvas-cli openvas-manager openvas-scanner"
	f_action_install "$CA_PGADMIN" pgadmin3
	f_action_install "$CA_PUPPET" puppet
	f_action_install "$CA_SERVERLAMP" "apache2 php libapache2-mod-php mysql-server php-mysql php-curl php-gd php-intl php-json php-mbstring php-xml php-zip phpmyadmin"
	f_action_install "$CA_SIRIKALI" sirikali
	f_action_ppa_install "$CA_UPM" ppa:adriansmith/upm upm
	f_action_ppa_install "$CA_VERACRYPT" ppa:unit193/encryption veracrypt
	f_action_install "$CA_WAKEONLAN" wakeonlan
	f_action_install "$CA_WIFITE" "wifite hashcat hcxdumptool macchanger"
	f_action_exec "$CA_WIRESHARK" "echo 'wireshark-common wireshark-common/install-setuid boolean true' | sudo debconf-set-selections"
	f_action_install "$CA_WIRESHARK" wireshark
	
	# Gaming
	f_action_install "$CA_0AD" 0ad
	f_action_flatpak_install "$CA_ALBION" com.albiononline.AlbionOnline
	f_action_install "$CA_ALIENARENA" alien-arena
	f_action_install "$CA_ASSAULTCUBE" assaultcube
	f_action_install "$CA_WESNOTH" wesnoth
	f_action_get "$CA_BZTAROT" "http://vbeuselinck.free.fr/linux/bztarot_1.02-12_i386.deb"
	f_action_get_appimage "$CA_DOFUS" "https://ankama.akamaized.net/zaap/installers/production/Ankama%20Launcher-Setup-x86_64.AppImage"
	f_action_install "$CA_EXTREMETUXRACER" extremetuxracer
	f_action_install "$CA_FLIGHTGEAR" flightgear
	f_action_install "$CA_FROZENBUBBLE" frozen-bubble
	f_action_install "$CA_GNOMEGAMES" "gnome-games gnome-games-app"
	f_action_install "$CA_KAPMAN" kapman
	f_action_snap_install "$CA_LOL" "leagueoflegends --edge --devmode"
	f_action_ppa_install "$CA_LUTRIS" ppa:lutris-team/lutris lutris
	f_action_install "$CA_MEGAGLEST" megaglest
	f_action_snap_install "$CA_MINDUSTRY" mindustry
	f_action_get "$CA_MINECRAFT" "https://launcher.mojang.com/download/Minecraft.deb"
	f_action_install "$CA_MINETEST" "minetest minetest-mod-nether"
	f_action_install "$CA_OPENARENA" openarena
	f_action_install "$CA_OPENTTD" "openttd openttd-opensfx"
	f_action_install "$CA_PINGUS" pingus
	f_action_install "$CA_POKERTH" pokerth
	f_action_snap_install "$CA_QUAKE" quake-shareware
	f_action_install "$CA_REDECLIPSE" redeclipse
	f_action_install "$CA_RUNESCAPE" runescape
	f_action_install "$CA_SAUERBRATEN" sauerbraten
	f_action_install "$CA_STEAM" steam
	f_action_install "$CA_SUPERTUX" supertux
	f_action_install "$CA_SUPERTUXKART" supertuxkart	
	f_action_install "$CA_TEEWORLDS" teeworlds		
	f_action_snap_install "$CA_TMNF" tmnationsforever
	f_action_exec "$CA_UT4" "wget https://gitlab.com/simbd/LinInstall_Software/raw/master/LinInstall_UnrealTournament4 && chmod +x LinI*Unreal*"
	f_action_install "$CA_XBOARD" "xboard gnuchess"
	f_action_exec "$CA_XPLANE" "wget https://www.x-plane.com/update/installers11/X-Plane11InstallerLinux.zip && unzip X-Plane11* ; rm X-Plane11*.zip"
	f_action_install "$CA_XQF" xqf
	
	# Programmation / Dev  
	f_action_ppa_install "$CA_ANDROIDSTUDIO" ppa:maarten-fonville/android-studio android-studio
	f_action_install "$CA_ANJUTA" "anjuta anjuta-extras"
	f_action_install "$CA_ARDUINOIDE" arduino 
	f_action_snap_install "$CA_ATOM" "atom --classic"
	f_action_install "$CA_BLUEFISH" "bluefish bluefish-plugins"
	f_action_get "$CA_BLUEGRIFFON" "http://bluegriffon.org/freshmeat/3.1/bluegriffon-3.1.Ubuntu18.04-x86_64.deb"
	f_action_snap_install "$CA_BRACKETS" "brackets --classic"
	f_action_install "$CA_CODEBLOCKS" "codeblocks codeblocks-contrib"
	f_action_snap_install "$CA_ECLIPSE" "eclipse --classic"
	f_action_install "$CA_EMACS" emacs
	f_action_install "$CA_ERIC" eric
	f_action_LinInstall "$CA_GDEVELOP" Gdevelop
	f_action_install "$CA_GEANY" "geany geany-plugins"
	f_action_install "$CA_IDLE" "idle3 idle3-tools"
	f_action_snap_install "$CA_INTELLIJIDEA" "intellij-idea-community --classic"
	f_action_install "$CA_IPYTHON" ipython
	f_action_exec "$CA_JAVA" "sudo add-apt-repository -y ppa:linuxuprising/java"
	f_action_exec "$CA_JAVA" "echo oracle-java16-installer shared/accepted-oracle-license-v1-2 select true | sudo /usr/bin/debconf-set-selections"
	f_action_install "$CA_JAVA" oracle-java16-installer
	f_action_install "$CA_JAVAOPENJDK8" "openjdk-8-jdk openjdk-8-jre"
	f_action_install "$CA_JAVAOPENJDK" "openjdk-16-jdk openjdk-16-jre"
	f_action_install "$CA_JUPYTER" "jupyter-notebook jupyter-client jupyter-console"
	f_action_install "$CA_LATEXFULL" "texlive-full fonts-freefont-ttf texlive-extra-utils texlive-fonts-extra texlive-lang-french texlive-latex-extra libreoffice-texmaths"
	f_action_install "$CA_LATEXILA" latexila
	f_action_install "$CA_NEOVIM" neovim
	f_action_install "$CA_NOTEPADQQ" notepadqq
	f_action_flatpak_install "$CA_PYCHARM" com.jetbrains.PyCharm-Community
	f_action_install "$CA_RSTUDIO" "r-base r-base-dev" #paquet R de base
	f_action_get "$CA_RSTUDIO" "https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.4.1717-amd64.deb" #Pour l'appli graphique Rstudio
	f_action_install "$CA_SCITE" scite
	f_action_install "$CA_SPYDER" spyder3	
	f_action_snap_install "$CA_SUBLIMETEXT" "sublime-text --classic"
	f_action_install "$CA_TEXMAKER" texmaker
	f_action_install "$CA_TEXSTUDIO" texstudio
	f_action_install "$CA_TEXWORKS" "texlive texlive-lang-french texworks"
	f_action_install "$CA_VIM" "vim vim-addon-manager vim-airline vim-asciidoc vim-athena vim-autopep8 vim-bitbake vim-ctrlp vim-editorconfig vim-fugitive vim-gocomplete vim-gtk3 vim-julia vim-khuno vim-lastplace" 
	f_action_install "$CA_VIM" "vim-latexsuite vim-ledger vim-migemo vim-nox vim-pathogen vim-puppet vim-python-jedi vim-rails vim-scripts vim-snipmate vim-snippets vim-syntastic vim-tabular vim-textobj-user vim-tiny vim-tlib vim-vimerl vim-voom"
	f_RepositoryExt_Install "$CA_VSCODE" "vscode" "https://packages.microsoft.com/keys/microsoft.asc" "[arch=amd64] https://packages.microsoft.com/repos/vscode stable main" "code" ##PB : ne s'installe pas
	f_action_install "$CA_VSCODE" apt-transport-https #dépendance
	f_action_get "$CA_VSCODIUM" "https://github.com/VSCodium/vscodium/releases/download/1.52.1/codium_1.52.1-1608165473_amd64.deb"

	# Divers, Customisation et Optimisation
	f_action_install "$CA_SAMBANFS" "samba-common nfs-common"
	f_action_install "$CA_IMPRIMANTE" "hplip hplip-doc hplip-gui sane sane-utils"
	f_action_exec "$CA_SECURITECPTE" "sudo chmod -R o=- /home/$USER"
	f_action_install "$CA_BLEACHBIT" bleachbit
	f_action_exec "$CA_DNSFDN" choice_dnsfdn
	f_action_exec "$CA_CONKY" "wget https://raw.githubusercontent.com/simbd/ConfigFiles/master/.conkyrc && mv .conkyrc ~/ ; sudo apt install conky -y"
    	f_action_exec "$CA_APPORTOFF" "sudo sed -i 's/^enabled=1$/enabled=0/' /etc/default/apport"
	f_action_exec "$CA_ATTENTERESEAUOFF" "sudo systemctl disable systemd-networkd-wait-online.service"
	f_action_exec "$CA_EXTINCTIONAUTO" "echo '0 4 * * * root /sbin/shutdown -h now' | sudo tee -a /etc/cron.d/extinction-auto"
	f_action_flatpak_install "$CA_GWE" com.leinardi.gwe
	f_action_ppa_install "$CA_FOLDERCOLOR" ppa:costales/yaru-colors-folder-color "folder-color yaru-colors-folder-color"
	f_action_install "$CA_FPRINTD" fprintd
	f_action_exec "$CA_GS_AUGMENTATIONCAPTURE" "gsettings set org.gnome.settings-daemon.plugins.media-keys max-screencast-length 600"
	f_action_exec "$CA_GS_MINIMISATIONFENETRE" "gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'"
	f_action_install "$CA_GRUBCUSTOMIZER" grub-customizer
	f_action_exec "$CA_GRUBDEFAULT" "sudo sed -ri 's/GRUB_DEFAULT=0/GRUB_DEFAULT="saved"/g' /etc/default/grub ; echo 'GRUB_SAVEDEFAULT="true"' | sudo tee -a /etc/default/grub ; sudo update-grub"
	f_action_exec "$CA_GRUBATTENTE" "sudo sed -ri 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=2/g' /etc/default/grub ; sudo mkdir /boot/old ; sudo mv /boot/memtest86* /boot/old/ ; sudo update-grub"
	f_action_exec "$CA_DVDREAD" "sudo apt install libdvdcss2 libdvd-pkg libbluray2 -y ; sudo dpkg-reconfigure libdvd-pkg"
	f_action_get "$CA_LIVEWALLPAPER" "http://fr.archive.ubuntu.com/ubuntu/pool/universe/g/glew/libglew2.0_2.0.0-5_amd64.deb" # Dépendance nécessaire pour livewallpaper
	f_action_ppa_install "$CA_LIVEWALLPAPER" ppa:fyrmir/livewallpaper-daily "livewallpaper livewallpaper-config livewallpaper-indicator"
	f_action_install "$CA_PACKEXTENSION" "chrome-gnome-shell gnome-shell-extension-caffeine gnome-shell-extension-dash-to-panel gnome-shell-extension-impatience gnome-shell-extension-weather" #gnome-shell-extension-dashtodock
	f_action_install "$CA_PACKEXTENSION" "gnome-shell-extension-system-monitor gnome-shell-extension-arc-menu gnome-shell-extension-gamemode gnome-shell-extension-gsconnect gnome-shell-extension-xrdesktop"
	f_action_exec "$CA_DASHTODOCK" "wget https://raw.githubusercontent.com/simbd/Scripts_divers/master/DashToDock_Git.sh && chmod +x DashToDock_Git.sh ; ./DashToDock_Git.sh ; rm DashTo*.sh" 
	f_action_install "$CA_PACKICON" "papirus-icon-theme numix-icon-theme numix-icon-theme-circle breeze-icon-theme gnome-brave-icon-theme elementary-icon-theme oxygen-icon-theme"
	f_action_install "$CA_PACKTHEME" "arc-theme numix-blue-gtk-theme numix-gtk-theme materia-gtk-theme yuyo-gtk-theme human-theme"
	f_action_install "$CA_INTEL" intel-microcode
	f_action_ppa_install "$CA_NVIDIA_BP" ppa:graphics-drivers/ppa "nvidia-graphics-drivers-440 nvidia-settings nvidia-prime"
	f_action_install "$CA_NVIDIA_BP" "libvdpau vulkan-loader vulkan-tools mesa-utils glmark2" # Autres paquets utiles
	f_action_get "$CA_PHORONIXTESTSUITE" "http://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_10.0.1_all.deb"
	f_action_exec "$CA_OPTIMIS_SWAP" "echo vm.swappiness=5 | sudo tee /etc/sysctl.d/99-swappiness.conf ; echo vm.vfs_cache_pressure=50 | sudo tee -a /etc/sysctl.d/99-sysctl.conf ; sudo sysctl -p /etc/sysctl.d/99-sysctl.conf"
	f_action_install "$CA_SCANNER" "sane sane-utils xsane"
	f_action_exec "$CA_SNAPREMPLACEMENT" "sudo snap remove snap-store"
	f_action_install "$CA_SNAPREMPLACEMENT" gnome-software
	f_action_install "$CA_NAUTILUS_EXTRA" "nautilus-nextcloud nautilus-admin nautilus-extension-gnome-terminal nautilus-filename-repairer nautilus-gtkhash nautilus-script-audio-convert nautilus-sendto nautilus-share nautilus-wipe"
	f_action_install "$CA_SYSFIC" "btrfs-progs exfat-utils exfat-fuse hfsprogs hfsutils hfsplus xfsprogs xfsdump zfsutils-linux"
	f_action_install "$CA_TLP" "tlp tlp-rdw"
	f_action_ppa_install "$CA_TLP_THINKPAD" "ppa:linrunner/tlp" "tlp tlp-rdw tp-smapi-dkms acpi-call-tools"	
	f_action_install "$CA_ZRAM" zram-config
	
	# Pour finir
	f_action_exec "$CA_AUTOREMOVE" "sudo apt update ; sudo apt full-upgrade -y ; sudo apt autoremove --purge -y && sudo apt clean -y ; clear ; sudo snap refresh ; sudo flatpak update -y ; clear"
	f_action_exec "$CA_RES_DEP" "sudo apt install -fy"
    
	# Notification End 
	notify-send -i dialog-ok "$NS_END_TITLE" "$NS_END_TEXT" -t 2000

	zenity --warning --no-wrap --height 500 --width 950 --title "$MSG_END_TITLE" --text "$MSG_END_TEXT"
else
	zenity --question --title "$MSG_END_CANCEL_TITLE" --text "$MSG_END_CANCEL_TEXT"
	
	if [ $? == 0 ] 
	then
		gxmessage -center -geometry 500x950 -name "$MSG_END_TITLE" "$MSG_END_TEXT"
	fi
fi
