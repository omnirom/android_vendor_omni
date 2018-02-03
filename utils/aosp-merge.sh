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

branch_name=${ref}"-merge"
# echo $branch_name

cd ../../../

while read path;
    do

    project=`echo android_${path} | sed -e 's/\//\_/g'`
    aosp_project=${path}
    if [ "${project}" == "android_build_make" ] ; then
        project="android_build"
        aosp_project="build"
    fi

    echo ""
    echo "====================================================================="
    echo " PROJECT: ${project} -> [ ${path}/ ]"
    echo ""

    echo "Syncing local ..."
    rm -fr $path;
    ret=$(repo sync -d -f --force-sync ${path} 2>&1);
    cd $path;

    # make sure that environment is clean
    ret=$(git merge --abort 2>&1);

    if git branch | grep ${branch_name} > /dev/null; then
        ret=$(git branch -D ${branch_name} > /dev/null 2>&1)
    fi

    echo "Merge with remote: https://android.googlesource.com/platform/${aosp_project} ${ref} ..."
    repo start ${branch_name} .
    ret=$(git pull https://android.googlesource.com/platform/$aosp_project ${ref} 2>&1)

    if echo $ret | grep "CONFLICT" > /dev/null ; then
        echo "------@@@@@@@@@@@@@@@@@@@@";
        echo $ret;
        echo "------@@@@@@@@@@@@@@@@@@@@";
    else
        echo "* ${ref} merged!"
    fi

    cd - > /dev/null

done < vendor/omni/utils/aosp-forked-list
