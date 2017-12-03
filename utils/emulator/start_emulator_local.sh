#!/bin/sh

# assumes the image zip has been extracted in /tmp

emulator  -verbose -skindir $ANDROID_BUILD_TOP/vendor/omni/utils/emulator/skins/ -skin pixel_xl -ramdisk ~/Android/Sdk/system-images/android-26/google_apis/x86/ramdisk.img  -kernel ~/Android/Sdk/system-images/android-26/google_apis/x86/kernel-ranchu -gpu host -writable-system
