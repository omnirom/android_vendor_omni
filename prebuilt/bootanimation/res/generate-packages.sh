#!/bin/sh
#
# Copyright (C) 2015 OmniROM Project
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
# original is 1080x608
#
# cleanup screen
clear;

# resolutions
RESOLUTIONS="\
    640x362 \
    720x407 \
    1440x814 \
    ";

# resize image and set quality
convert_image() {
    convert "${1}" -resize "${2}" -quality ${3} tmp.png;
    mv tmp.png "${1}";
}

# rewrite desc.txt
rewrite_desc() {
res=$(echo "${1}" | sed s/x/\ /)
cat > desc.txt << EOF
${res} 60
c 0 0 Part0
c 1 60 Part1
c 1 0 Part2
EOF
}

# image quality
quality=95;

# reading images
for i in ${RESOLUTIONS}; do

#   cleanup environment
    rm -rf "${i}";
    rm -rf "${i}.zip";

#   create a temporary folder
    mkdir -p "${i}";
    cd ${i};

    echo "============================================================";
    echo "Resolution: ${i}"
    echo "============================================================";
    echo "Uncompressing bootanimation...";
    unzip ../../bootanimation.zip > /dev/zero;

    echo "Rewriting desc.txt...";
    rewrite_desc "${i}"

    echo "Resizing images...";
    for j in Part*/*.png; do
        convert_image "${j}" "${i}" $quality;
        echo -ne " ==> please wait...\r";
    done

    echo "";
    echo "Compressing bootanimation...";
    echo "";
    zip -r0 ../${i}.zip . > /dev/zero;

    sleep 1;
    echo "Done";

#   remove temporary folder
    cd ..
    rm -rf ${i}
done
