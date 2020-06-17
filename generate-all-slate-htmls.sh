#!/bin/sh

THEME=raml2html-slate-theme

#sed -i "/version:/c\version: $(date '+%Y-%m-%d %H:%M')" ${MODULE}/${MODULE}.raml

MODULE=business
raml2html --theme ${THEME} --logo MTD-logo.png --input api-${MODULE}/${MODULE}.raml --output  api-${MODULE}/${MODULE}.html
cp api-${MODULE}/${MODULE}.html docs/${MODULE}.html

MODULE=business-details
raml2html --theme ${THEME} --logo MTD-logo.png --input api-${MODULE}/${MODULE}.raml --output  api-${MODULE}/${MODULE}.html
cp api-${MODULE}/${MODULE}.html docs/${MODULE}.html

MODULE=charges
raml2html --theme ${THEME} --logo MTD-logo.png --input api-${MODULE}/${MODULE}.raml --output  api-${MODULE}/${MODULE}.html
cp api-${MODULE}/${MODULE}.html docs/${MODULE}.html

MODULE=deductions
raml2html --theme ${THEME} --logo MTD-logo.png --input api-${MODULE}/${MODULE}.raml --output  api-${MODULE}/${MODULE}.html
cp api-${MODULE}/${MODULE}.html docs/${MODULE}.html

MODULE=disclosures
raml2html --theme ${THEME} --logo MTD-logo.png --input api-${MODULE}/${MODULE}.raml --output  api-${MODULE}/${MODULE}.html
cp api-${MODULE}/${MODULE}.html docs/${MODULE}.html

MODULE=expenses
raml2html --theme ${THEME} --logo MTD-logo.png --input api-${MODULE}/${MODULE}.raml --output  api-${MODULE}/${MODULE}.html
cp api-${MODULE}/${MODULE}.html docs/${MODULE}.html

MODULE=income-received
raml2html --theme ${THEME} --logo MTD-logo.png --input api-${MODULE}/${MODULE}.raml --output  api-${MODULE}/${MODULE}.html
cp api-${MODULE}/${MODULE}.html docs/${MODULE}.html

MODULE=obligations
raml2html --theme ${THEME} --logo MTD-logo.png --input api-${MODULE}/${MODULE}.raml --output  api-${MODULE}/${MODULE}.html
cp api-${MODULE}/${MODULE}.html docs/${MODULE}.html

MODULE=reliefs
raml2html --theme ${THEME} --logo MTD-logo.png --input api-${MODULE}/${MODULE}.raml --output  api-${MODULE}/${MODULE}.html
cp api-${MODULE}/${MODULE}.html docs/${MODULE}.html