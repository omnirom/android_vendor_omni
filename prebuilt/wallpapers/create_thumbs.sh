#!/bin/sh

if [ ! -d "thumbs" ]; then
    mkdir "thumbs"
    cp json.php "thumbs"
fi

for file in `ls *.png`
do
    convert $file -resize 300 "thumbs/$file"
done

for file in `ls *.jpg`
do
    convert $file -resize 300 "thumbs/$file"
done
