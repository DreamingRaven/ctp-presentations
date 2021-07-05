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
mkdir -p builds
rm -f builds/*.pdf
echo "** copying:"
ls -al *.pdf
cp *.pdf builds/.
echo "** ending-state:"
ls -al
