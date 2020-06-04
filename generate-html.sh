#!/bin/sh

MODULE=$1

sed -i "/version:/c\version: $(date '+%Y-%m-%d %H:%M')" ${MODULE}/${MODULE}.raml
npx raml2html --theme raml2html-printable-theme --input ${MODULE}/${MODULE}.raml --output html_docs_printable/${MODULE}-printable.html
cp html_docs_printable/${MODULE}-printable.html ../html_docs_printable
npx raml2html --theme raml2html-default-theme --input ${MODULE}/${MODULE}.raml --output html_docs_compact/${MODULE}-compact.html
cp html_docs_compact/${MODULE}-compact.html ../html_docs_compact

rm html_docs.zip
zip html_docs.zip html_docs_compact/*