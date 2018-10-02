# Versioning of the ROM

ifndef ROM_BUILDTYPE
    ROM_BUILDTYPE := HOMEMADE
endif

TARGET_PRODUCT_SHORT := $(TARGET_PRODUCT)
TARGET_PRODUCT_SHORT := $(subst omni_,,$(TARGET_PRODUCT_SHORT))

# Build the final version string
ifeq ($(ROM_BUILDTIME_UTC),y)
    ROM_VERSION := $(PLATFORM_VERSION)-$(shell date -u +%Y%m%d%H%M)-$(TARGET_PRODUCT_SHORT)-$(ROM_BUILDTYPE)
else
    ROM_VERSION := $(PLATFORM_VERSION)-$(shell date +%Y%m%d%H%M)-$(TARGET_PRODUCT_SHORT)-$(ROM_BUILDTYPE)
endif

# Apply it to build.prop
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.modversion=OmniROM-$(ROM_VERSION) \
    ro.omni.version=$(ROM_VERSION)

ROM_FINGERPRINT := OmniROM/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date +%Y%m%d.%H:%M)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.omni.fingerprint=$(ROM_FINGERPRINT)
