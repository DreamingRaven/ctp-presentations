#!/usr/bin/env bash
# @Author: GeorgeRaven <archer>
# @Date:   2021-04-22T15:48:50+01:00
# @Last modified by:   archer
# @Last modified time: 2021-05-04T15:01:38+01:00
# @License: please see LICENSE file in project root

mkdir -p build
docker build -t ctp/pres -f Dockerfile . && docker run -v "${PWD}/build":"/latex-src/build" -it ctp/pres 
