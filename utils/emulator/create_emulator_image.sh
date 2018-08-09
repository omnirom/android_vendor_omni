#!/bin/sh

if [ -z $ANDROID_BUILD_TOP ]; then
    echo $ANDROID_BUILD_TOP undefined
    exit 1
fi

if [ -z $ANDROID_PRODUCT_OUT ]; then
    echo $ANDROID_PRODUCT_OUT undefined
    exit 1
fi

if [ ! -f $ANDROID_PRODUCT_OUT/system.img ]; then
    echo "Please build before running this"
    exit 1
fi

# creates image zip in /tmp/
cd $ANDROID_BUILD_TOP
cp -r vendor/omni/utils/emulator/skins $ANDROID_PRODUCT_OUT
cp -r vendor/omni/utils/emulator/start_emulator_image.sh $ANDROID_PRODUCT_OUT
cp -r vendor/omni/utils/emulator/advancedFeatures.ini $ANDROID_PRODUCT_OUT

cd $ANDROID_PRODUCT_OUT/..
zip -r /tmp/omni_emulator.zip generic_x86/skins generic_x86/system-qemu.img generic_x86/system/build.prop generic_x86/cache.img generic_x86/userdata-qemu.img generic_x86/start_emulator_image.sh generic_x86/advancedFeatures.ini generic_x86/vendor-qemu.img generic_x86/encryptionkey.img generic_x86/kernel-ranchu-64 generic_x86/ramdisk.img
