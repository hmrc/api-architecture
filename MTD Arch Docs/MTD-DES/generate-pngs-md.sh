#!/bin/sh

cd ~/gh/api-architecture/MTD Arch Docs/MTD-DES

MDDOC="MTD-to-DES-Mappings.md"

rm *.png
rm $MDDOC

for f in *.puml
  do
     echo converting $f to png
     java -jar plantuml.jar $f
  done;

echo generate md doc
echo "# MTD API Endpoint Mappings to DES" >> $MDDOC
echo "" >> $MDDOC

for f in *.png
  do
    echo "## "$(basename "$f" .png) >> $MDDOC
    echo "!["$(basename "$f" .png)"]("$f")" >> $MDDOC
  done;
