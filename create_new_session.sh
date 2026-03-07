#!/usr/bin/env bash
set -euo pipefail
umask 0002
SESSION_NUMBER=$1

THIS_SCRIPT=$(readlink -f "$0")
THIS_SCRIPT_DIR=$(basename "$0")
DATE=$(date --rfc-3339=seconds)

GIT_LOCATION=$HOME/GitHub/DnD_Session
cd $GIT_LOCATION

LAST_ADV_LOG=$(ls -t adv_log/S* | head -1)

#Create new Session folder 
mkdir -p sessions/S${SESSION_NUMBER}

#Copy template to new session folder 
cp template/Template.tex sessions/S${SESSION_NUMBER}/Session${SESSION_NUMBER}.tex

#Copy previous adventure log and rename as new 
cp ${LAST_ADV_LOG} adv_log/S${SESSION_NUMBER}_Adventure_Log.tex

#Use latest adventure log 
sed -i "s|\input{Adventure_Log}|\input{../../adv_log/S${SESSION_NUMBER}_Adventure_Log}|g" sessions/S${SESSION_NUMBER}/Session${SESSION_NUMBER}.tex

