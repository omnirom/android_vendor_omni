#!/bin/bash

# Originally by Humberto Borba (humberos)
# Modified by Jake Whatley (jakew02)

echo -e "Type the AOSP branch to merge and press [ENTER]"
read branch

cd ../../../

while read file;
    do

    rm -fr .tmp
    echo "$file" > .tmp

    path=`cat .tmp | awk '{print $1}'`
    project=`cat .tmp | awk '{print $2}'`
    echo ""
    echo "====================================================================="
    echo " PROJECT PATH: {$path}"
    echo " PROJECT NAME: {$project}"
    echo "====================================================================="
    echo ""

    cd $path;

    git merge --abort;

    repo sync -d .

    if git branch | grep "android-6.0" > /dev/null; then
        git branch -D android-6.0 > /dev/null
    fi

    repo start android-6.0 .

    if ! git remote | grep "aosp" > /dev/null; then
        git remote add aosp https://android.googlesource.com/platform/$path > /dev/null
    fi

    git fetch aosp

    #echo "====================================================================="
    #echo " Merging {$branch}"
    #echo "====================================================================="
    git merge $branch;

    cd -
    rm -fr .tmp

done < vendor/omni/utils/omni-list
