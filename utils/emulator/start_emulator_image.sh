#!/bin/sh

export ANDROID_BUILD_TOP=`pwd`
export ANDROID_PRODUCT_OUT=`pwd`

cp $HOME/Android/Sdk/system-images/android-28/google_apis/x86/vendor.img .
$HOME/Android/Sdk/emulator/emulator  -verbose -skindir $ANDROID_BUILD_TOP/skins/ -skin pixel_2_xl -gpu host -writable-system -qemu -cpu qemu64
