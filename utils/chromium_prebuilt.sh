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
ARCH_PREBUILT_CHROMIUM=$(get_build_var TARGET_ARCH)

if [ -d $PREBUILT_DIR ]; then
    rm -rf $PREBUILT_DIR
fi

mkdir -p $PREBUILT_DIR
mkdir -p $PREBUILT_DIR/app
mkdir -p $PREBUILT_DIR/lib

if [ -d $TARGET_DIR ]; then
    echo "Copying files..."
    cp -r $TARGET_DIR/system/app/webview $PREBUILT_DIR/app/
    cp -r $TARGET_DIR/obj/APPS/webviewchromium-paks_intermediates/* $PREBUILT_DIR/framework/
    cp $TARGET_DIR/system/lib/libwebviewchromium.so $PREBUILT_DIR/lib/libwebviewchromium.so
    cp $TARGET_DIR/system/lib/libwebviewchromium_loader.so $PREBUILT_DIR/lib/libwebviewchromium_loader.so
    cp $TARGET_DIR/system/lib/libwebviewchromium_plat_support.so $PREBUILT_DIR/lib/libwebviewchromium_plat_support.so
else
    echo "Please ensure that you have ran a full build prior to running this script!"
    return 1;
fi

echo "Generating Makefiles..."

HASH=$(git --git-dir=$TOP/external/chromium_org/.git --work-tree=$TOP/external/chromium_org rev-parse --verify HEAD)
echo $HASH > $PREBUILT_DIR/hash.txt

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g > $PREBUILT_DIR/chromium_prebuilt.mk
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

PRODUCT_COPY_FILES += \\
    \$(LOCAL_PATH)/framework/am.pak:data/data/com.android.chrome/app_chrome/paks/am.pak \\
    \$(LOCAL_PATH)/framework/ar.pak:data/data/com.android.chrome/app_chrome/paks/ar.pak \\
    \$(LOCAL_PATH)/framework/bg.pak:data/data/com.android.chrome/app_chrome/paks/bg.pak \\
    \$(LOCAL_PATH)/framework/bn.pak:data/data/com.android.chrome/app_chrome/paks/bn.pak \\
    \$(LOCAL_PATH)/framework/ca.pak:data/data/com.android.chrome/app_chrome/paks/ca.pak \\
    \$(LOCAL_PATH)/framework/cs.pak:data/data/com.android.chrome/app_chrome/paks/cs.pak \\
    \$(LOCAL_PATH)/framework/da.pak:data/data/com.android.chrome/app_chrome/paks/da.pak \\
    \$(LOCAL_PATH)/framework/de.pak:data/data/com.android.chrome/app_chrome/paks/de.pak \\
    \$(LOCAL_PATH)/framework/el.pak:data/data/com.android.chrome/app_chrome/paks/el.pak \\
    \$(LOCAL_PATH)/framework/en-GB.pak:data/data/com.android.chrome/app_chrome/paks/en-GB.pak \\
    \$(LOCAL_PATH)/framework/en-US.pak:data/data/com.android.chrome/app_chrome/paks/en-US.pak \\
    \$(LOCAL_PATH)/framework/es.pak:data/data/com.android.chrome/app_chrome/paks/es.pak \\
    \$(LOCAL_PATH)/framework/es-419.pak:data/data/com.android.chrome/app_chrome/paks/es-419.pak \\
    \$(LOCAL_PATH)/framework/et.pak:data/data/com.android.chrome/app_chrome/paks/et.pak \\
    \$(LOCAL_PATH)/framework/fa.pak:data/data/com.android.chrome/app_chrome/paks/fa.pak \\
    \$(LOCAL_PATH)/framework/fi.pak:data/data/com.android.chrome/app_chrome/paks/fi.pak \\
    \$(LOCAL_PATH)/framework/fil.pak:data/data/com.android.chrome/app_chrome/paks/fil.pak \\
    \$(LOCAL_PATH)/framework/fr.pak:data/data/com.android.chrome/app_chrome/paks/fr.pak \\
    \$(LOCAL_PATH)/framework/gu.pak:data/data/com.android.chrome/app_chrome/paks/gu.pak \\
    \$(LOCAL_PATH)/framework/he.pak:data/data/com.android.chrome/app_chrome/paks/he.pak \\
    \$(LOCAL_PATH)/framework/hi.pak:data/data/com.android.chrome/app_chrome/paks/hi.pak \\
    \$(LOCAL_PATH)/framework/hr.pak:data/data/com.android.chrome/app_chrome/paks/hr.pak \\
    \$(LOCAL_PATH)/framework/hu.pak:data/data/com.android.chrome/app_chrome/paks/hu.pak \\
    \$(LOCAL_PATH)/framework/id.pak:data/data/com.android.chrome/app_chrome/paks/id.pak \\
    \$(LOCAL_PATH)/framework/it.pak:data/data/com.android.chrome/app_chrome/paks/it.pak \\
    \$(LOCAL_PATH)/framework/ja.pak:data/data/com.android.chrome/app_chrome/paks/ja.pak \\
    \$(LOCAL_PATH)/framework/kn.pak:data/data/com.android.chrome/app_chrome/paks/kn.pak \\
    \$(LOCAL_PATH)/framework/ko.pak:data/data/com.android.chrome/app_chrome/paks/ko.pak \\
    \$(LOCAL_PATH)/framework/lt.pak:data/data/com.android.chrome/app_chrome/paks/lt.pak \\
    \$(LOCAL_PATH)/framework/lv.pak:data/data/com.android.chrome/app_chrome/paks/lv.pak \\
    \$(LOCAL_PATH)/framework/ml.pak:data/data/com.android.chrome/app_chrome/paks/ml.pak \\
    \$(LOCAL_PATH)/framework/mr.pak:data/data/com.android.chrome/app_chrome/paks/mr.pak \\
    \$(LOCAL_PATH)/framework/ms.pak:data/data/com.android.chrome/app_chrome/paks/ms.pak \\
    \$(LOCAL_PATH)/framework/nb.pak:data/data/com.android.chrome/app_chrome/paks/nb.pak \\
    \$(LOCAL_PATH)/framework/nl.pak:data/data/com.android.chrome/app_chrome/paks/nl.pak \\
    \$(LOCAL_PATH)/framework/pl.pak:data/data/com.android.chrome/app_chrome/paks/pl.pak \\
    \$(LOCAL_PATH)/framework/pt-BR.pak:data/data/com.android.chrome/app_chrome/paks/pt-BR.pak \\
    \$(LOCAL_PATH)/framework/pt-PT.pak:data/data/com.android.chrome/app_chrome/paks/pt-PT.pak \\
    \$(LOCAL_PATH)/framework/ro.pak:data/data/com.android.chrome/app_chrome/paks/ro.pak \\
    \$(LOCAL_PATH)/framework/ru.pak:data/data/com.android.chrome/app_chrome/paks/ru.pak \\
    \$(LOCAL_PATH)/framework/sk.pak:data/data/com.android.chrome/app_chrome/paks/sk.pak \\
    \$(LOCAL_PATH)/framework/sl.pak:data/data/com.android.chrome/app_chrome/paks/sl.pak \\
    \$(LOCAL_PATH)/framework/sr.pak:data/data/com.android.chrome/app_chrome/paks/sr.pak \\
    \$(LOCAL_PATH)/framework/sv.pak:data/data/com.android.chrome/app_chrome/paks/sv.pak \\
    \$(LOCAL_PATH)/framework/sw.pak:data/data/com.android.chrome/app_chrome/paks/sw.pak \\
    \$(LOCAL_PATH)/framework/ta.pak:data/data/com.android.chrome/app_chrome/paks/ta.pak \\
    \$(LOCAL_PATH)/framework/te.pak:data/data/com.android.chrome/app_chrome/paks/te.pak \\
    \$(LOCAL_PATH)/framework/th.pak:data/data/com.android.chrome/app_chrome/paks/th.pak \\
    \$(LOCAL_PATH)/framework/tr.pak:data/data/com.android.chrome/app_chrome/paks/tr.pak \\
    \$(LOCAL_PATH)/framework/uk.pak:data/data/com.android.chrome/app_chrome/paks/uk.pak \\
    \$(LOCAL_PATH)/framework/vi.pak:data/data/com.android.chrome/app_chrome/paks/vi.pak \\
    \$(LOCAL_PATH)/framework/webviewchromium.pak:data/data/com.android.chrome/app_chrome/paks/webviewchromium.pak \\
    \$(LOCAL_PATH)/framework/zh-CN.pak:data/data/com.android.chrome/app_chrome/paks/zh-CN.pak \\
    \$(LOCAL_PATH)/framework/zh-TW.pak:data/data/com.android.chrome/app_chrome/paks/zh-TW.pak \\
    \$(LOCAL_PATH)/lib/libwebviewchromium.so:system/lib/libwebviewchromium.so \\
    \$(LOCAL_PATH)/app/webview/webview.apk:system/app/webview/webview.apk \\
    \$(LOCAL_PATH)/lib/libwebviewchromium_plat_support.so:system/lib/libwebviewchromium_plat_support.so \\
    \$(LOCAL_PATH)/lib/libwebviewchromium_loader.so:system/lib/libwebviewchromium_loader.so

    \$(shell mkdir -p out/target/product/__DEVICE__/system/app/webview/lib/$ARCH_PREBUILT_CHROMIUM/)
    \$(shell cp -r \$(LOCAL_PATH)/app/webview/lib/$ARCH_PREBUILT_CHROMIUM/libwebviewchromium.so out/target/product/__DEVICE__/system/app/webview/lib/$ARCH_PREBUILT_CHROMIUM/libwebviewchromium.so)

EOF

echo "Done!"
