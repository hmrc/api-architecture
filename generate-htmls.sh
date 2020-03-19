#!/bin/sh

for f in `ls -d */ | cut -d"/" -f1 | grep -Ev "node_modules|generic"`
do
    cd ${f}
    echo ${f}
    `raml2html ${f}.raml > ${f}.html`
    cd ../
done