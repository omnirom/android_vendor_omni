# Versioning of the ROM

ifndef ROM_BUILDTYPE
    ROM_BUILDTYPE := HOMEMADE
endif

TARGET_PRODUCT_SHORT := $(TARGET_PRODUCT)
TARGET_PRODUCT_SHORT := $(subst omni_,,$(TARGET_PRODUCT_SHORT))

# Build the final version string
ifeq ($(ROM_BUILDTYPE),GAPPS)
include vendor/gapps/config.mk
    VENDOR_EXCEPTION_PATHS += \
    gapps
endif
ifeq ($(ROM_BUILDTYPE),MICROG)
include vendor/microg/microg.mk
    VENDOR_EXCEPTION_PATHS += \
    microg
endif
ifeq ($(ROM_BUILDTIME_UTC),y)
    ROM_VERSION := $(PLATFORM_VERSION)-$(shell date -u +%Y%m%d)-$(TARGET_PRODUCT_SHORT)-$(ROM_BUILDTYPE)
else
    ROM_VERSION := $(PLATFORM_VERSION)-$(shell date +%Y%m%d)-$(TARGET_PRODUCT_SHORT)-$(ROM_BUILDTYPE)
endif

# Apply it to build.prop
OMNI_PRODUCT_PROPERTIES += \
    ro.modversion=OmniROM-$(ROM_VERSION) \
    ro.omni.version=$(ROM_VERSION)
