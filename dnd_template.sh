#!/usr/bin/env bash
set ueo pipefail

#Pull the DnD Template from github
wget https://github.com/rpgtex/DND-5e-LaTeX-Template/archive/master.zip

unzip master.zip

rm -rf master.zip

export TEXINPUTS=./DND-5e-LaTeX-Template-stable

