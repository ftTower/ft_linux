#!/bin/bash

#*========================== COULEUR ===============================

ROUGE='\033[0;31m'
VERT='\033[0;32m'
RESET='\033[0m'

#*========================== CONSTANTES ===============================

MANDATORY_PACKAGES_LINKS_FILE="./list_packages.txt"

#*========================== VAR ===============================

SOURCES_DIR=$(find . -type d -name sources 2>/dev/null)
SOURCES=$(ls $SOURCES_DIR)

#?========================== MAIN ===============================

ALL_INSTALLED_PACKAGES=$(cat $MANDATORY_PACKAGES_LINKS_FILE | grep -oP "(?<=/)[^/]+?(?=\.tar\.[a-z0-9]+$|$)")

for pack in $SOURCES; do 
    INSTALLED=$(echo $ALL_INSTALLED_PACKAGES | grep $pack)
    if [[ -n $INSTALLED ]]; then
        echo -e $VERT$pack$RESET
    else
        echo -e $ROUGE$pack$RESET
    fi

done
