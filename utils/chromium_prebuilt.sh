#!/bin/sh

# Copyright (C) 2014 The OmniROM Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This works, but there has to be a better way of reliably getting the root build directory...
if [ $# -eq 1 ]; then
    TOP=$1
    DEVICE=$TARGET_DEVICE
    TARGET_DIR=$OUT
elif [ -n "$(gettop)" ]; then
    TOP=$(gettop)
    DEVICE=$(get_build_var TARGET_DEVICE)
    TARGET_DIR=$(get_build_var OUT_DIR)/target/product/$DEVICE
else
    echo "Please run envsetup.sh and lunch before running this script,"
    echo "or provide the build root directory as the first parameter."
    return 1
fi

PREBUILT_DIR=$TOP/prebuilts/chromium/$DEVICE

if [ -d $PREBUILT_DIR ]; then
    rm -rf $PREBUILT_DIR
fi

mkdir -p $PREBUILT_DIR
mkdir -p $PREBUILT_DIR/app
mkdir -p $PREBUILT_DIR/lib

if [ -d $TARGET_DIR ]; then
    echo "Copying files..."
    cp $TARGET_DIR/system/app/webview/webview.apk $PREBUILT_DIR/app/webview.apk
    cp $TARGET_DIR/system/lib/libwebviewchromium.so $PREBUILT_DIR/lib/libwebviewchromium.so
else
    echo "Please ensure that you have ran a full build prior to running this script!"
    return 1;
fi

echo "Generating Makefiles..."

HASH=$(git --git-dir=$TOP/external/chromium_org/.git --work-tree=$TOP/external/chromium_org rev-parse --verify HEAD)
echo $HASH > $PREBUILT_DIR/hash.txt

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g > $PREBUILT_DIR/Android.mk
# Copyright (C) 2014 The OmniROM Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := prebuilts/chromium/__DEVICE__/

ifeq (\$(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)

include \$(CLEAR_VARS)

LOCAL_MODULE := libwebviewchromium
LOCAL_SRC_FILES := lib/libwebviewchromium.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES

include \$(BUILD_PREBUILT)

endif


EOF

echo "Done!"
