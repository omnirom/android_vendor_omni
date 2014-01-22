#!/bin/bash

# Tool for forking a GitHub repository to another GitHub org,
# by creating the repo on GitHub and Gerrit, and pushing
# the source repo to Gerrit.
# The name of the repository can be changed before forking,
# and if the regular branch isn't found, you can choose
# in the list of available branches.
# Usage: ./fork.sh

##
# Configuration
##
USERNAME=xplodwild
BRANCH=android-4.4
GERRIT=gerrit.omnirom.org
GITHUB_ORG=omnirom

##
# Script
##

# Read the source GitHub URL
read -p "GitHub URL (no trailing slash): " github_url

# Extract the repo name and prompt for changes
repo_name=${github_url##*/}
original_repo_name=$repo_name

read -e -i "$repo_name" -p "Final repo name: " repo_name

# Clone the repo locally
git clone $github_url

# Create the new repository on the organization
echo Creating $repo_name on GitHub

curl --user $USERNAME --data "{\"name\":\"$repo_name\"}" https://api.github.com/orgs/$GITHUB_ORG/repos

# Create the repository on Gerrit
echo Creating $repo_name on Gerrit

ssh -p 29418 $GERRIT gerrit create-project --name $repo_name

# Push the repository
cd $original_repo_name

git checkout $BRANCH
git show-ref --verify --quiet refs/heads/$BRANCH

if [ $? != 0 ]; then
	echo "Branch $BRANCH doesn't exist in the original repository"
	echo "Here are the branches:"
	git branch -a
	echo "--------------------------------------"
	read -p "Branch to clone from: " origin_branch
	git checkout $origin_branch
	git branch $BRANCH
fi

git push ssh://gerrit.omnirom.org:29418/$repo_name $BRANCH

# If pushing failed, we might want to forcepush the repository
# to overwite what was previously there.
if [ $? != 0 ]; then
	echo "Unable to push!"
	read -p "Try with -f? [y/n]: " forcepush
	if [ "$forcepush" = "y" ]; then
		git push -f ssh://gerrit.omnirom.org:29418/$repo_name $BRANCH
	fi
fi

# Cleanup our local copy
cd ..
rm -rf $original_repo_name

# Done!
echo "Fork done!"
