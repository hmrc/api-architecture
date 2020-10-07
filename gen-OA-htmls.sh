#!/bin/sh

cd ~/OneDrive/HMRC/Tech\ Architecture/Integration/DES

for f in *.yaml
  do
     echo converting $f
     swagger-yaml-to-html.py < $f > "$(basename "$f" .yaml).html"
  done;
