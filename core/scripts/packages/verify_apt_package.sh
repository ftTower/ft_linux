#!/bin/bash

if [[ -z $(./get_package.sh "apt") ]]; then
    echo "apt not installed."
else
    echo "apt installed."
    # echo "found $(apt list --installed 2>/dev/null | wc -l) packages."
    ./get_package.sh "$1"
fi


