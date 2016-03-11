#!/bin/bash

echo -e "Enter the username"
read username

url="gerrit.omnirom.org"
port="29418"
branch="android-6.0"

cd ../../../

while read path;
    do

    project=`echo android_${path} | sed -e 's/\//\_/g'`

    echo ""
    echo "====================================================================="
    echo " PROJECT: ${project} -> [ ${path}/ ]"
    echo ""

    cd $path;

    echo " Pushing..."
    echo " git push --no-thin ssh://${username}@${url}:${port}/${project} HEAD:refs/heads/${branch}"
    git push --no-thin ssh://${username}@${url}:${port}/${project} HEAD:refs/heads/${branch}
    echo ""

    cd - > /dev/null

done < vendor/omni/utils/omni-list
