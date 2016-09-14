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
echo -e "Enter the AOSP ref to merge"
read ref

cd ../../../

while read path;
    do

    project=`echo android_${path} | sed -e 's/\//\_/g'`

    echo ""
    echo "====================================================================="
    echo " PROJECT: ${project} -> [ ${path}/ ]"
    echo ""

    cd $path;

    git merge --abort;

    repo sync -d .

    if git branch | grep "android-7.0-merge" > /dev/null; then
        git branch -D android-7.0-merge > /dev/null
    fi

    repo start android-7.0-merge .

    if ! git remote | grep "aosp" > /dev/null; then
        git remote add aosp https://android.googlesource.com/platform/$path > /dev/null
    fi

    git fetch --tags aosp

    #echo "====================================================================="
    #echo " Merging {$ref}"
    #echo "====================================================================="
    git merge $ref;

    cd - > /dev/null

done < vendor/omni/utils/aosp-forked-list
