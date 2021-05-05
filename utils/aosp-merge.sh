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
echo -e "Enter the AOSP ref to merge";
read ref;

echo -e "Enter the name of the new branch";
read branch_name;

branch_current="android-11"

cd ../../../

while read path;
    do

    project=`echo android_${path} | sed -e 's/\//\_/g'`;
    aosp_project=${path};
    if [ "${path}" == "build" ] ; then
        path="build/make";
    fi

    echo "";
    echo "=====================================================================";
    echo " PROJECT: ${project} -> [ ${path}/ ]";
    echo "";

    rm -fr $path;
    echo " -> repo sync ${path}";
    ret=$(repo sync -d -f --force-sync ${path} 2>&1);
    cd $path;

    if git branch | grep ${branch_name} > /dev/null; then
        git branch -D ${branch_name} > /dev/null
    fi

    echo " -> creating branch ${branch_name}";
    ret=$(git checkout -b ${branch_name} 2>&1);
    ret=$(repo start ${branch_name});
    # make sure that environment is clean
    ret=$(git merge --abort 2>&1);

    echo " -> Merging remote: https://android.googlesource.com/platform/$aosp_project ${ref}";
    ret=$(git pull https://android.googlesource.com/platform/$aosp_project ${ref} 2>&1);

    if echo $ret | grep "CONFLICT (content)" > /dev/null ; then
        echo -e " -> \e[33mWARNING!: \e[31mMERGE CONFLICT\e[0m";
        echo -e " -> please fix the merge conflict before push it.";
    else
        echo " -> merging squashed commits into ${branch_current} branch";
        ret=$(git checkout ${branch_current} 2>&1);
        ret=$(git merge --squash ${branch_name} 2>&1);
        ret=$(git add . 2>&1);
        ret=$(git commit --no-edit 2>&1);
        echo -e " -> \e[32mDONE!\e[0m";
    fi

    cd - > /dev/null;

done < vendor/omni/utils/aosp-forked-list;
