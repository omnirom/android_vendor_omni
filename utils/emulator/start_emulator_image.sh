#!/bin/sh

# assumes the image zip has been extracted in /tmp
export ANDROID_BUILD_TOP=/tmp/generic_x86
export ANDROID_PRODUCT_OUT=/tmp/generic_x86

~/Android/Sdk/tools/emulator  -verbose -skindir /tmp/generic_x86/skins/ -skin pixel_xl -kernel ~/Android/Sdk/system-images/android-26/google_apis/x86/kernel-ranchu -gpu host -ramdisk ~/Android/Sdk/system-images/android-26/google_apis/x86/ramdisk.img -writable-system
