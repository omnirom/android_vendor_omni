#! /bin/bash
#
# Copyright (C) 2025 Claymore1297 / Julian Veit
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

# Why do we need this hax?:
# In Android 15 (qpr1), google sadly introduced files over 130M (gradle.zip fils WTF!).
# On github/gitlab this requirees lfs, which is PITA.
# So lets just wipe this shit out, to use an merge  in a normal way.
# you need to merge with -s ours option to make it work, and never try
# to merge agains orginal google sources, the large files will be back then :-(.

# Usage
if [ $# -ne 1 ]; then
        echo -e "Usage: $0 <AOSP-tag>"
        echo -e "Example: $0 android-15.0.0_r12"
        exit 2
fi

# some defines
rootDir="/home/claymore1297"
# path to bfg jar file
bfgPath="${rootDir}/bfg-1.14.0.jar"
baseDir="${rootDir}/fwb_cleanup"
sourceDir="${baseDir}/source"
rawDir="${baseDir}/raw"
doneDir="${baseDir}/done"
getTag=$1
shift
maxFilesize="100M"
sourceRepo="https://android.googlesource.com/platform/frameworks/base"
# change this to whatever you need
newFwbURL="github.com:Claymore1297/frameworks_base"

# do some checks
# TODO: remove spaghetti code ;-)
if [ ! -f $bfgPath ];then
    echo "ERR: bfg jar NOT found"
    echo "please download and install form here: https://rtyley.github.io/bfg-repo-cleaner"
    exit 1
fi

if [ ! -d $baseDir ];then
    mkdir $baseDir
fi
if [ ! -d $sourceDir ];then
    mkdir $sourceDir
fi
if [ ! -d $rawDir ];then
    mkdir $rawDir
fi
if [ ! -d $doneDir ];then
    mkdir $doneDir
fi

# cloning goolge repo
echo "cloning source: ${sourceRepo} with tag: $getTag"
cd ${sourceDir}
git clone ${sourceRepo} -b $getTag
# wipe out shitty last large file. This is needed, because bfg can't wipe out
# history of existing files.
cd base
git rm -f packages/SettingsLib/Spa/gradle/wrapper/gradle-*-bin.zip
git add packages/SettingsLib/Spa/gradle/wrapper
git commit -m "[TEMP]: wipe out gradle*-bin.zip"
# clone as bare repo for bfg cleanup
cd $rawDir
echo "cloning as bare repo into: $rawDir"
git clone ${sourceDir}/base --mirror
# run bfg, to do the trick
echo "cleaning up files bigger that ${maxFilesize}"
java -jar $bfgPath --strip-blobs-bigger-than ${maxFilesize} ${rawDir}/base.git
# run git reflog & gc after
echo "running git reflog & gc"
cd ${rawDir}/base.git
git reflog expire --expire=now --all && git gc --prune=now --aggressive

# clone repo to push
cd ${doneDir}
echo "cloning proper state to: $doneDir"
git clone ${rawDir}/base.git
cd base
# due maximum of 2G repack size we need to push in parts grrrrr....
echo "write partial-push alias in git config"
cat << 'EOF' >> .git/config
[alias]
    partial-push = "!sh -c 'REMOTE=$0;BRANCH=$1;BATCH_SIZE=66100; if git show-ref --quiet --verify refs/remotes/$REMOTE/$BRANCH; then range=$REMOTE/$BRANCH..HEAD; else range=HEAD; fi; n=$(git log --first-parent --format=format:x $range | wc -l); echo "Have to push $n packages in range of $range"; for i in $(seq $n -$BATCH_SIZE 1); do h=$(git log --first-parent --reverse --format=format:%H --skip $i -n1);  echo "Pushing $h..."; git push $REMOTE ${h}:refs/heads/$BRANCH; done; git push $REMOTE HEAD:refs/heads/$BRANCH'"
EOF

# adding new remote
echo "adding new remote ${newFwbURL}"
git remote add newhome git@${newFwbURL}
# pushi-pushi
echo "pushing in new home"
git partial-push newhome $getTag
cleanup
echo "cleanup"
rm -rf ${baseDir}

exit 0
