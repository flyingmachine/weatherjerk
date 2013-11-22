#!/bin/bash

cd html-app
grunt build
rm -Rf ../server/resources/html-app
cp -R targets/public ../server/resources/html-app
cd ..
cp -R server/ ../weatherjerk-heroku
