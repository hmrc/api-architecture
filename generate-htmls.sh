#!/bin/sh

for f in `ls -d */ | cut -d"/" -f1 | grep -Ev "node_modules|generic"`
do
    cd ${f}
    echo ${f}
        for g in `ls *.raml | cut -d"." -f1`
        do
            npx raml2html --theme raml2html-printable-theme --input ${g}.raml --output ${g}.html
            npx raml2html --theme raml2html-default-theme --input ${g}.raml --output ${g}-compact.html
        done
    cd ../
done