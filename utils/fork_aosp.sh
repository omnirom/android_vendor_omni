#!/bin/sh
# Copyright OmniROM Project
# Licensed under GPLv3

# Configuration
ANDROID_ROOT=~/omni
PREFIX=android_
BRANCH=android-4.4
SOURCE=android-4.4.3_r1.1
MANIFEST=android/default.xml
GITHUB_ORG=omnirom
USERNAME=xplodwild
GERRIT_REMOTE=ssh://gerrit.omnirom.org:29418
REMOTE_MANIFEST=omnirom

# Script
if [ $# -lt 1 ]; then
        echo Usage: ./fork_aosp.sh path
        echo Example: ./fork_aosp.sh frameworks/base
        exit 1
fi

REPO_NAME=$PREFIX$(echo ${1%/} | sed -e "s/\//_/g")

# Check that folder is a git repo
pushd $1
if [ ! -d .git ]; then
        echo "$1 doesn't appear to be a git repository"
        popd
        exit 1
fi
popd

# Create the repo at github
echo "Creating $REPO_NAME on GitHub..."
curl --user $USERNAME --data "{\"name\":\"$REPO_NAME\"}" https://api.github.com/orgs/$GITHUB_ORG/repos

# Only works if you are a gerrit admin, will create the named project before pushing (gerrit then replicates to git)
ssh -p 29418 gerrit.omnirom.org gerrit create-project --name $REPO_NAME

echo "Creating branch $BRANCH..."
pushd $1
git remote rm gerrit
git remote add gerrit $GERRIT_REMOTE/$REPO_NAME
git checkout $SOURCE
git branch $BRANCH
git push gerrit $BRANCH

echo "Updating manifest..."
popd
SRC_LINE=$(cat $MANIFEST | grep ${1%/} | head -n1)
if [[ "$SRC_LINE" == *group="pdk"* ]]; then
        NEW_LINE="  <project path=\"${1%/}\" name=\"$REPO_NAME\" remote=\"$REMOTE_MANIFEST\" revision=\"$BRANCH\" group=\"pdk\" />"
else
        NEW_LINE="  <project path=\"${1%/}\" name=\"$REPO_NAME\" remote=\"$REMOTE_MANIFEST\" revision=\"$BRANCH\" />"
fi

# Update the repo in manifest listing

sed -i "s%$SRC_LINE%$NEW_LINE%g" $MANIFEST

echo "Pushing manifest"
pushd android
git checkout $BRANCH
git commit -a -m "Replace $1 path to new repository $REPO_NAME"
git push $GERRIT_REMOTE/android HEAD:refs/for/$BRANCH
popd

echo "Now remember to approve the change on gerrit before going further!"
read -p "Press [Enter] key once you've approved the change on gerrit"

echo "Remember to repo sync before use!"
