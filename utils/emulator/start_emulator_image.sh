#!/bin/sh

# assumes the image zip has been extracted in /tmp

~/Android/Sdk/tools/emulator  -verbose -skindir /tmp/generic_x86/skins/ -skin pixel_xl -ramdisk ~/Android/Sdk/system-images/android-26/google_apis/x86/ramdisk.img  -kernel ~/Android/Sdk/system-images/android-26/google_apis/x86/kernel-ranchu -ranchu -gpu host
