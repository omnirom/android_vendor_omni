PRODUCT_BRAND ?= omni

# general properties
PRODUCT_PROPERTY_OVERRIDES += \
	keyguard.no_require_sim=true \
	ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
	ro.com.google.clientidbase=android-google \
	ro.com.android.wifi-watchlist=GoogleGuest \
	ro.setupwizard.enterprise_mode=1 \
	ro.com.android.dateformat=MM-dd-yyyy \
	ro.com.android.dataroaming=false \
	persist.sys.root_access=1

# enable ADB authentication if not on eng build
ifneq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/omni/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/omni/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/omni/prebuilt/bin/blacklist:system/addon.d/blacklist

# init.d support
PRODUCT_COPY_FILES += \
	vendor/omni/prebuilt/etc/init.d/00banner:system/etc/init.d/00banner \
	vendor/omni/prebuilt/bin/sysinit:system/bin/sysinit

# userinit support
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/init.d/90userinit:system/etc/init.d/90userinit

# Init script file with omni extras
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/init.local.rc:root/init.omni.rc

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Additional packages
-include vendor/omni/config/packages.mk

# Versioning
-include vendor/omni/config/version.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/omni/overlay/common

ifeq($(DEVICE_RESOLUTION),)

# bootanimation 		
PRODUCT_COPY_FILES += \		
    vendor/omni/prebuilt/bootanimation/bootanimation.zip:system/media/bootanimation.zip

else

TARGET_SCREEN_DIMENSIONS := $(shell echo $(DEVICE_RESOLUTION) | sed -e 's/x/\n/g')
TARGET_SCREEN_WIDTH := TARGET_SCREEN_DIMENSIONS[0]
TARGET_SCREEN_HEIGHT := TARGET_SCREEN_DIMENSIONS[1]

# Boot animation include
ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))

# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/omni/prebuilt/bootanimation))	
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \	
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
endif

endif
