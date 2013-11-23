#!/bin/bash

cd html-app
grunt build
rm -Rf ../server/resources/html-app
cp -R targets/public ../server/resources/html-app
cd ..
rm -Rf ../weatherjerk-heroku/server/resources/html-app/*
cp -R server/ ../weatherjerk-heroku
