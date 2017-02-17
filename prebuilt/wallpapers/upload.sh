#!/bin/sh

scp -P 9122 -i common *.jpg omnirom@207.244.74.108:/var/www/dl.omnirom.org/images/wallpapers/
scp -P 9122 -i common *.png omnirom@207.244.74.108:/var/www/dl.omnirom.org/images/wallpapers/
scp -P 9122 -i common thumbs/*.jpg omnirom@207.244.74.108:/var/www/dl.omnirom.org/images/wallpapers/thumbs
scp -P 9122 -i common thumbs/*.png omnirom@207.244.74.108:/var/www/dl.omnirom.org/images/wallpapers/thumbs
scp -P 9122 -i common json_wallpapers_xml.php omnirom@207.244.74.108:/var/www/dl.omnirom.org/images/wallpapers/thumbs
scp -P 9122 -i common wallpapers.xml omnirom@207.244.74.108:/var/www/dl.omnirom.org/images/wallpapers/thumbs
