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

# cleanup workspace
clear;

# resolutions
# based on stock 600x400px Omni bootanimation (30fps)
HALF_RES_RESOLUTIONS="\
    360x240 \
    420x280 \
    480x320 \
    ";
#    750x500 \
#    900x600 \

# resize image and quality
convert_image() {
    convert "${1}" -resize "${2}" -quality ${3} tmp.jpg;
    mv tmp.jpg "${1}";
}

# rewrite desc.txt
rewrite_desc() {
res=$(echo "${1}" | sed s/x/\ /)
cat > desc.txt << EOF
${res} 30
p 1 0 Part0
p 0 0 Part1
EOF
}

# reading images
for i in ${HALF_RES_RESOLUTIONS}; do
    rm -rf "${i}";
    rm -rf "${i}.zip";
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
    for j in Part*/*.jpg; do
        case "${i}" in
            "360x240")
                convert_image "${j}" "60%" 80;
            ;;
            "420x280")
                convert_image "${j}" "70%" 85;
            ;;
            "480x320")
                convert_image "${j}" "80%" 90;
            ;;
#            "750x500")
#                convert_image "${j}" "125%" 99;
#            ;;
#            "900x600")
#                convert_image "${j}" "150%" 99;
#            ;;
        esac
        echo -ne " ==> please wait...\r";
    done
    
    echo "";
    echo "Compressing bootanimation...";
    echo "Done";
    sleep 1;
    echo "";
    zip -r0 ../${i}.zip . > /dev/zero;
    cd ..
    rm -rf ${i}
done
