#! /usr/bin/bash

readonly HOME_INSTALL=/home/headless/Documents/installation

echo "######################################################"
echo "Debut du script"
echo "######################################################"

echo ""
echo "######################################################"
echo "Suppression du mot de passe sudo pour user headless"
echo "######################################################"
echo "headless ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# Changement des droits sur le repertoire $HOME_INSTALL pour pouvoir ecrire dedans
echo ""
echo "######################################################"
echo "Changement des droits de $HOME_INSTALL"
echo "######################################################"
cd $HOME_INSTALL
sudo chmod 777 $HOME_INSTALL

echo ""
echo "######################################################"
echo "Copie de vnc_startup.rc"
echo "######################################################"
cp $HOME_INSTALL/vnc_startup.rc /dockerstartup/vnc_startup.rc 
cp $HOME_INSTALL/.bashrc /home/headless/

echo ""
echo "######################################################"
echo "Recuperation du plugin JDownloader pour Firefox"
echo "######################################################"
# Recuperation du plugin JDownloader pour Firefox
rm -f firefox.xpi
wget -q https://extensions.jdownloader.org/firefox.xpi

# Mise a jour de Linux
echo ""
echo "######################################################"
echo "Mise a jour de Linux"
echo "######################################################"
sudo debconf-set-selections <<< 'tzdata tzdata/Areas select Europe'
sudo debconf-set-selections <<< 'tzdata tzdata/Zones/Etc select Paris'
sudo apt update -y -qq 
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y -qq 
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install xz-utils powerline fonts-powerline

# Installation outils pour améliorer le script d'installation
echo ""
echo "######################################################"
echo "Amélioration du script d'installation (nala)"
echo "######################################################"
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install nala

# installation de Double Commander
echo ""
echo "######################################################"
echo "Installation de Double Commander"
echo "######################################################"
sudo nala install -y doublecmd-qt 

# recopie de la configuration de Double Commander
echo ""
echo "######################################################"
echo "Recopie de la configuration de Double Commander"
echo "######################################################"
cd $HOME_INSTALL
mkdir -p settings
cd settings
tar xf ../dc_settings.tar
mkdir -p /home/headless/.config/doublecmd
cd $HOME_INSTALL
cp -Rf settings/* /home/headless/.config/doublecmd/
rm -R settings

# On place les raccourcis sur le bureau
echo ""
echo "######################################################"
echo "Copie des raccourcis sur le bureau"
echo "######################################################"
cp /usr/share/applications/firefox.desktop /home/headless/Desktop/
cp /usr/share/applications/doublecmd.desktop /home/headless/Desktop/
chmod 777 /home/headless/Desktop/*.desktop

# Recopie des profils Firefox
echo ""
echo "######################################################"
echo "Installation des profils de Firefox"
echo "######################################################"
mkdir -p /home/headless/.mozilla/firefox
cd /home/headless/.mozilla/firefox
tar xf $HOME_INSTALL/profiles_firefox.tar.xz

# Lancement de Firefox
echo ""
echo "######################################################"
echo "Lancement de Firefox pour migration des profils"
echo "     et installation du plugin JDownloader à jour"
echo "######################################################"
firefox $HOME_INSTALL/firefox.xpi
rm $HOME_INSTALL/firefox.xpi

# On refait l'archive des profils en cas de migration
echo ""
echo "######################################################"
echo "Archivage des profiles de Firefox"
echo "######################################################"
cd /home/headless/.mozilla/firefox
tar cfa $HOME_INSTALL/profiles_firefox.tar.xz *

# Installation des outils complementaires
echo ""
echo "######################################################"
echo "Installation des outils complementaires"
echo "######################################################"
read -p "Voulez-vous installer les outils complémentaires ? (o/n) : " reponse
if [[ "$reponse" == "o" ]]; then
	sudo DEBIAN_FRONTEND=noninteractive nala install -y \
		cron \
		dos2unix \
		dconf-cli \
		curl \
		zip \
		unzip \
		ffmpeg \
		tilix \
		gedit \
		galculator \
		calibre
		
echo ""
echo "######################################################"
echo "Recopie des différentes configurations"
echo "######################################################"

	sudo mkdir -p /var/spool/cron/crontabs
	sudo cp $HOME_INSTALL/crontab_headless /var/spool/cron/crontabs/headless
	
	mkdir -p /home/headless/.config/calibre
	cd /home/headless/.config/calibre
	tar xf $HOME_INSTALL/calibre_conf.tar

	mkdir -p /home/headless/.config/autostart
	cp $HOME_INSTALL/config/autostart/* /home/headless/.config/autostart

	mkdir -p /home/headless/.config/xfce4
	cp $HOME_INSTALL/config/xfce4/* /home/headless/.config/xfce4

	dconf load /com/gexperts/Tilix/ < $HOME_INSTALL/tilix-config.dconf
	
	echo ""
	echo "######################################################"
	echo "Démarrage du serveur Calibre"
	echo "######################################################"
	calibre-server --port 8282&

fi
echo ""
echo "######################################################"
echo "Fin de l'installation des differents outils"
echo "######################################################"

echo ""
echo "######################################################"
echo "Fin de la mise à jour de l'environnement"
echo "######################################################"

