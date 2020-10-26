PRODUCT_COPY_FILES += \
    vendor/omni/utils/omni_emulator/fstab.ranchu.initrd:$(TARGET_COPY_OUT_RAMDISK)/fstab.ranchu \
    vendor/omni/utils/omni_emulator/fstab.ranchu:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.ranchu \
    vendor/omni/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

PRODUCT_USE_DYNAMIC_PARTITIONS := true
TARGET_NO_VENDOR_BOOT := true
PRODUCT_QUOTA_PROJID := 1
PRODUCT_PROPERTY_OVERRIDES += external_storage.projid.enabled=1
PRODUCT_PROPERTY_OVERRIDES += external_storage.sdcardfs.enabled=0

$(call inherit-product, $(SRC_TARGET_DIR)/product/sdk_x86.mk)

$(call inherit-product, vendor/omni/config/gsm.mk)

$(call inherit-product, vendor/omni/utils/omni_emulator/common.mk)

QEMU_USE_SYSTEM_EXT_PARTITIONS := false

# Override product naming for Omni
PRODUCT_NAME := omni_emulator
PRODUCT_MANUFACTURER := OmniROM
PRODUCT_DEVICE := omni_emulator

DEVICE_PACKAGE_OVERLAYS += vendor/omni/utils/omni_emulator/overlay

ALLOW_MISSING_DEPENDENCIES := true 
PRODUCT_ENFORCE_RRO_TARGETS := framework-res