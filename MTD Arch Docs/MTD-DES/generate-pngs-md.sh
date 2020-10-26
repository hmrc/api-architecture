#!/bin/sh

cd "~/gh/api-architecture/MTD Arch Docs/MTD-DES"

MDDOC="MTD-to-DES-Mappings.md"

rm *.png
rm $MDDOC

for f in *.puml
  do
     echo converting $f to png
     java -jar plantuml.jar $f
  done;

# Title
echo generate md doc
echo "# MTD API Endpoint Mappings to DES" >> $MDDOC
echo "" >> $MDDOC

#TOC
echo "## Contents " >> $MDDOC
for f in *.png
  do
    #echo "1. ["$(basename "$f" .png)"]("$(basename "$f" .png)")" >> $MDDOC
    echo "1. "$(basename "$f" .png) >> $MDDOC
  done;
echo "" >> $MDDOC

# Details
for f in *.png
  do
    echo "## "$(basename "$f" .png) >> $MDDOC
    echo "!["$(basename "$f" .png)"]("$f")" >> $MDDOC
    echo "" >> $MDDOC
  done;

pandoc -o MTD-to-DES-Mappings.pdf -f markdown -t latex MTD-to-DES-Mappings.md
pandoc -o MTD-to-DES-Mappings.html -f markdown -t html MTD-to-DES-Mappings.md
pandoc -o MTD-to-DES-Mappings.docx -f markdown -t docx MTD-to-DES-Mappings.md
pandoc -o MTD-to-DES-Mappings.odt -f markdown -t odt MTD-to-DES-Mappings.md
