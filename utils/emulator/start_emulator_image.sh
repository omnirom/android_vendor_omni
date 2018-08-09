#!/bin/sh

export ANDROID_BUILD_TOP=`pwd`
export ANDROID_PRODUCT_OUT=`pwd`

/home/maxl/Android/Sdk/emulator/emulator  -verbose -skindir $ANDROID_BUILD_TOP/skins/ -skin pixel_xl -gpu host -qemu -cpu qemu64
