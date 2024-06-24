#!/usr/bin/env bash

set -ex

path=/var/www/maleldil.com/
rm -rf $path/html/*
cp -r html $path

sudo cp nginx/maleldil.com /etc/nginx/sites-available/
