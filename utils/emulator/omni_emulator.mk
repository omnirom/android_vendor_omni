$(call inherit-product, build/target/product/sdk_x86.mk)

$(call inherit-product, vendor/omni/utils/emulator/common.mk)

# Override product naming for Omni
PRODUCT_NAME := omni_emulator
