#!/bin/sh

THEME=raml2html-mtd-theme
MODULE=$1

#https://www.npmjs.com/package/raml2html-slate-theme

sed -i "/version:/c\version: $(date '+%Y-%m-%d %H:%M')" api-${MODULE}/${MODULE}.raml
#raml2html --theme raml2html-printable-theme --input ${MODULE}/${MODULE}.raml --output  ${MODULE}/${MODULE}-printable.html
#cp html_docs_printable/${MODULE}-printable.html ../html_docs_printable

#npx
#raml2html --theme raml2html-default-theme --input ${MODULE}/${MODULE}.raml --output  ${MODULE}/${MODULE}-compact.html
#cp html_docs_compact/${MODULE}-compact.html ../html_docs_compact
#
#raml2html --theme raml2html-werk-theme --input ${MODULE}/${MODULE}.raml --output  ${MODULE}/${MODULE}-werk.html
#npx
#raml2html --theme raml2html-slate-theme --logo MTD-logo.png --input ${MODULE}/${MODULE}.raml --output  ${MODULE}/${MODULE}-slate.html
#raml2html --theme raml2html-slate-modified-theme --logo MTD-logo.png --input ${MODULE}/${MODULE}.raml --output  ${MODULE}/${MODULE}-slate-modified.html
#raml2html --theme raml2html-modern-theme --logo MTD-logo.png --input ${MODULE}/${MODULE}.raml --output  ${MODULE}/${MODULE}-modern.html
#raml2html --theme raml2html-kaa-theme --logo MTD-logo.png --input ${MODULE}/${MODULE}.raml --output  ${MODULE}/${MODULE}-kaa.html
#raml2html --theme raml2html-confluencewiki-theme --logo MTD-logo.png --input ${MODULE}/${MODULE}.raml --output  ${MODULE}/${MODULE}-confluencewiki.html
#npx
#raml2html --theme raml2html-material-theme --input ${MODULE}/${MODULE}.raml --output  ${MODULE}/${MODULE}-material.html


#rm html_docs.zip
#zip html_docs.zip html_docs_compact/*

#api-${MODULE}/${MODULE}.raml

echo "raml2html --theme ${THEME} --logo MTD-logo.png --input ${MODULE}.raml --output  ${MODULE}.html"
raml2html --theme ${THEME} --logo MTD-logo.png --input ${MODULE}.raml  --output  ${MODULE}.html
#cp api-${MODULE}/${MODULE}.html docs/${MODULE}.html
