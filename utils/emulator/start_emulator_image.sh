#!/bin/sh

export ANDROID_BUILD_TOP=`pwd`
export ANDROID_PRODUCT_OUT=`pwd`

cp $HOME/Android/Sdk/system-images/android-29/google_apis/x86/vendor.img .
$HOME/Android/Sdk/emulator/emulator  -verbose -skindir $ANDROID_BUILD_TOP/skins/ -skin pixel_2_xl -gpu host -writable-system -qemu -append "androidboot.vbmeta.size=4352 androidboot.vbmeta.hash_alg=sha256 androidboot.vbmeta.digest=8fe6dcf73940be6e49f5b466d1d8c0dfe993873aca2dd0358fd63a0eb1650693"
