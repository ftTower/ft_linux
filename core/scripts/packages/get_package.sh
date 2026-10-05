#!/bin/bash

if [[ -n $(command -v $1) ]]; then
    echo "$1 installed"
else
    echo "$1 not found"
fi