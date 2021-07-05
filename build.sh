#!/usr/bin/env bash
# @Author: GeorgeRaven <archer>
# @Date:   2021-04-22T15:48:50+01:00
# @Last modified by:   archer
# @Last modified time: 2021-05-04T15:01:38+01:00
# @License: please see LICENSE file in project root


echo "** building files:"
latexmk -synctex=1 -interaction=nonstopmode -shell-escape -file-line-error -pdf *.tex
echo "** cleaning up:"
latexmk -c
echo "** organising builds dir:"
mkdir -p build
rm -f build/*.pdf
echo "** copying from ${PWD} to ${PWD}/build:"
ls -al *.pdf
cp *.pdf build/.
echo "** ending-state:"
ls -al
