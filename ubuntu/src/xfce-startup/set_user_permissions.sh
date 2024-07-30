#!/bin/sh
#set -e     # ne pas utiliser
#set -u     # ne pas utiliser

### Corriger les permissions des fichiers
for i in "$@"; do


    ### définir les permissions des répertoires
    ### de manière récursive, mais en ignorant les répertoires point dans $HOME
    find "$i" -type d -not -path "${HOME}/.*" -exec chmod $verbose 755 {} +

    ### définir les permissions des fichiers
    ### de manière récursive, mais en ignorant les fichiers point et les répertoires point dans $HOME
    find "$i" -type f -not -path "${HOME}/.*" -exec chmod $verbose 644 {} +

    ### permissions spécifiques des fichiers
    ### de manière récursive, mais en ignorant les répertoires point dans $HOME
    find "$i" -type f -not -path "${HOME}/.*" -name '*.sh' -exec chmod $verbose 744 {} +
    find "$i" -type f -not -path "${HOME}/.*" -name '*.desktop' -exec chmod $verbose 744 {} +
done

### le script de démarrage est spécial
chmod 755 "${STARTUPDIR}/startup.sh"

