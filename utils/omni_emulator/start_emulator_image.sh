#!/bin/sh

export ANDROID_BUILD_TOP=`pwd`
export ANDROID_PRODUCT_OUT=`pwd`

# -show-kernel

$HOME/Android/Sdk/emulator/emulator -show-kernel -verbose -skindir $ANDROID_BUILD_TOP/skins/ -skin pixel_2_xl -gpu host -writable-system -qemu -cpu qemu64 -append "vbmeta"
