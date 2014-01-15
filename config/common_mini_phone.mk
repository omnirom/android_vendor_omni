# Inherit common CM stuff
$(call inherit-product, vendor/Anime/config/common.mk)

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/Anime/prebuilt/common/bootanimation/bootanimation.zip:system/media/bootanimation.zip
endif

$(call inherit-product, vendor/Anime/config/telephony.mk)
