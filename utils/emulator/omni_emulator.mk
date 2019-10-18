PRODUCT_COPY_FILES += \
    vendor/omni/utils/emulator/fstab.ranchu:vendor/etc/fstab.ranchu \
    vendor/omni/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

$(call inherit-product, build/target/product/sdk_x86.mk)

$(call inherit-product, vendor/omni/config/gsm.mk)

$(call inherit-product, vendor/omni/utils/emulator/common.mk)

# Override product naming for Omni
PRODUCT_NAME := omni_emulator

DEVICE_PACKAGE_OVERLAYS += vendor/omni/utils/emulator/overlay

ALLOW_MISSING_DEPENDENCIES := true 

TARGET_RECOVERY_FSTAB := vendor/omni/utils/emulator/fstab.ranchu
