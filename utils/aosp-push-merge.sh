#!/bin/bash
#
# Copyright (C) 2016 OmniROM Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
echo -e "Enter the username"
read username

url="gerrit.omnirom.org"
port="29418"
branch="android-8.1"

cd ../../../

while read path;
    do

    project=`echo android_${path} | sed -e 's/\//\_/g'`
    if [ "${project}" == "android_build_make" ] ; then
        project="android_build"
    fi

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

done < vendor/omni/utils/aosp-forked-list
