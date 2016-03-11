#!/bin/bash

# Originally by Humberto Borba (humberos)
# Modified by Jake Whatley (jakew02)

if [ -z $1 ]; then
  echo ""
  echo "*****************************************************************************"
  echo "*                                                                           *"
  echo "*          Usage: ./aosp-merge.sh <list>                                    *"
  echo "*          Example: ./aosp-merge.sh omni-list                               *"
  echo "*                                                                           *"
  echo "*****************************************************************************"
  echo ""

  exit 0
fi

echo -e "Type AOSP branch to merge and press [ENTER]"
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
    if [ `git branch | grep android-6.0` ]; then
        git branch -D android-6.0
    fi

    repo start android-6.0 .

    # Attention: if remote is already present then just comment out next line
    if [ ! `git remote | grep aosp` ]; then
        git remote add aosp https://android.googlesource.com/platform/$path > /dev/null
    fi

    git fetch aosp

    #echo "====================================================================="
    #echo " Merging {$branch}"
    #echo "====================================================================="
    git merge $branch;

    cd -
    rm -fr .tmp

done < omni-list
