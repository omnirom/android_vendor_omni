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
cd $ANDROID_PRODUCT_OUT/..
DIGEST=`grep "# " $TARGET_PRODUCT/VerifiedBootParams.textproto| sed -e 's/# //'`

cd $ANDROID_BUILD_TOP
cp -r vendor/omni/utils/$TARGET_PRODUCT/skins $ANDROID_PRODUCT_OUT
cat vendor/omni/utils/$TARGET_PRODUCT/start_emulator_image.sh | sed -e "s/vbmeta/$DIGEST/" > $ANDROID_PRODUCT_OUT/start_emulator_image.sh
chmod 755 $ANDROID_PRODUCT_OUT/start_emulator_image.sh
cp device/generic/goldfish/data/etc/advancedFeatures.ini $ANDROID_PRODUCT_OUT

cd $ANDROID_PRODUCT_OUT/..
rm /tmp/omni_emulator.zip
zip -r /tmp/omni_emulator.zip $TARGET_PRODUCT/skins $TARGET_PRODUCT/system-qemu.img $TARGET_PRODUCT/system/build.prop $TARGET_PRODUCT/cache.img $TARGET_PRODUCT/userdata.img $TARGET_PRODUCT/start_emulator_image.sh $TARGET_PRODUCT/advancedFeatures.ini $TARGET_PRODUCT/encryptionkey.img $TARGET_PRODUCT/kernel-ranchu-64 $TARGET_PRODUCT/ramdisk.img $TARGET_PRODUCT/vendor-qemu.img
