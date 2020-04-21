#!/bin/sh

for f in `ls -d */ | cut -d"/" -f1 | grep -Ev "node_modules|generic|html_docs"`
do
    cd ${f}
    echo ${f}
        for g in `ls *.raml | cut -d"." -f1`
        do
            npx raml2html --theme raml2html-printable-theme --input ${g}.raml --output ${g}-printable.html
            cp *printable.html ../html_docs_printable
            npx raml2html --theme raml2html-default-theme --input ${g}.raml --output ${g}-compact.html
            cp *compact.html ../html_docs_compact

        done
    cd ../
done
rm html_docs.zip
zip html_docs.zip html_docs_compact/*