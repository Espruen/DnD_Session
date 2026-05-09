#!/usr/bin/env bash
set -euo pipefail
umask 0002
SESSION_NUMBER=$1

banner () {
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ">> $1"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::"
}

THIS_SCRIPT=$(readlink -f "$0")
THIS_SCRIPT_DIR=$(basename "$0")
DATE=$(date --rfc-3339=seconds)

banner "Creating Session ${SESSION_NUMBER}"

GIT_LOCATION=$PWD
cd $GIT_LOCATION

LAST_ADV_LOG=$(ls -t adv_log/S* | head -1)

#Copy template to new session folder 
cp main.tex sessions/Session${SESSION_NUMBER}.tex

cat > summary/S${SESSION_NUMBER}_recap.tex << EOF
\part*{Summary}
\section{Story}
\DndDropCapLine{T}{he Sensational Seven} 
EOF

#Copy previous adventure log and rename as new 
cp ${LAST_ADV_LOG} adv_log/S${SESSION_NUMBER}_Adventure_Log.tex

#Summary of last adventure included 
sed -i "s|\input{Last_Adventure}|\input{summary/S${SESSION_NUMBER}_recap}|g" sessions/Session${SESSION_NUMBER}.tex

#Use latest adventure log 
sed -i "s|\input{Adventure_Log}|\input{adv_log/S${SESSION_NUMBER}_Adventure_Log}|g" sessions/Session${SESSION_NUMBER}.tex

#Update session log for part 
sed -i "s|\part\*{Latest_Session}|\part\*{Session ${SESSION_NUMBER}}|g" sessions/Session${SESSION_NUMBER}.tex

