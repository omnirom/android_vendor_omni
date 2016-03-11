#!/bin/bash

# Originally by Humberto Borba (humberos)
# Modified by Jake Whatley (jakew02)

echo -e "Enter the AOSP ref to merge"
read ref

cd ../../../

while read path;
    do

    project=`echo android_${path} | sed -e 's/\//\_/g'`

    echo ""
    echo "====================================================================="
    echo " PROJECT PATH: {$path}"
    echo " PROJECT NAME: {$project}"
    echo "====================================================================="
    echo ""

    cd $path;

    git merge --abort;

    repo sync -d .

    if git branch | grep "android-6.0-merge" > /dev/null; then
        git branch -D android-6.0-merge > /dev/null
    fi

    repo start android-6.0-merge .

    if ! git remote | grep "aosp" > /dev/null; then
        git remote add aosp https://android.googlesource.com/platform/$path > /dev/null
    fi

    git fetch aosp

    #echo "====================================================================="
    #echo " Merging {$ref}"
    #echo "====================================================================="
    git merge $ref;

    cd - > /dev/null

done < vendor/omni/utils/omni-list
