#!/usr/bin/env bash
set -euo pipefail
umask 0002
SESSION_NUMBER=$1

THIS_SCRIPT=$(readlink -f "$0")
THIS_SCRIPT_DIR=$(basename "$0")
DATE=$(date --rfc-3339=seconds)

cp main.tex Session${SESSION_NUMBER}.tex
#Summary of last adventure included 
sed -i "s|\input{Last_Adventure}|\input{summary/S${SESSION_NUMBER}_recap}|g" Session${SESSION_NUMBER}.tex

#Use latest adventure log 
sed -i "s|\input{Adventure_Log}|\input{adv_log/S${SESSION_NUMBER}_Adventure_Log}|g" Session${SESSION_NUMBER}.tex

#Update session log for part 
sed -i "s|\part\*{Latest_Session}|\part\*{Session ${SESSION_NUMBER}}|g" Session${SESSION_NUMBER}.tex

for i in {1..2}; do
pdflatex Session${SESSION_NUMBER}.tex
done


rm -rf *.aux *.log *.toc *.fls *.fdb_latexmk
