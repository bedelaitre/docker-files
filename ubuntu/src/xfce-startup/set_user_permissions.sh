#!/bin/sh
#set -e     # ne pas utiliser
#set -u     # ne pas utiliser

### Corriger les permissions des fichiers
changePermissions() {
    ### définir les permissions des répertoires
    ### de manière récursive, mais en ignorant les répertoires point dans $HOME
    find "$1" -type d -not -path "${HOME}/.*" -exec chmod $verbose 755 {} +

    ### définir les permissions des fichiers
    ### de manière récursive, mais en ignorant les fichiers point et les répertoires point dans $HOME
    find "$1" -type f -not -path "${HOME}/.*" -exec chmod $verbose 644 {} +

    ### permissions spécifiques des fichiers
    ### de manière récursive, mais en ignorant les répertoires point dans $HOME
    find "$1" -type f -not -path "${HOME}/.*" -name '*.sh' -exec chmod $verbose 744 {} +
    find "$1" -type f -not -path "${HOME}/.*" -name '*.desktop' -exec chmod $verbose 744 {} +
}

changePermissions "${HOME}"
changePermissions "${STARTUPDIR}"

### le script de démarrage est spécial
chmod 755 "${STARTUPDIR}/startup.sh"

