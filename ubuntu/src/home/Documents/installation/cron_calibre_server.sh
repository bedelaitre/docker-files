#!/bin/bash

# Vérifier si le processus calibre est en cours d'exécution
if ! ps aux | grep -v grep | grep -q "calibre-server"
then
    # Lancer calibre
    calibre-server --port 8282 &
fi

