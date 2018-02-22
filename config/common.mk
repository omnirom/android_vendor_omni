PRODUCT_BRAND ?= omni

# bootanimation
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/bootanimation/bootanimation.zip:system/media/bootanimation.zip

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# general properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.build.selinux=1 \
    persist.sys.disable_rescue=true 



# Tethering - allow without requiring a provisioning app
# (for devices that check this)
PRODUCT_PROPERTY_OVERRIDES += \
    net.tethering.noprovisioning=true

# enable ADB authentication if not on eng build
ifneq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES  += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/omni/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/omni/prebuilt/bin/blacklist:system/addon.d/blacklist \
    vendor/omni/prebuilt/bin/clean_cache.sh:system/bin/clean_cache.sh

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/sysconfig/backup.xml:system/etc/sysconfig/backup.xml

# Init script file with omni extras
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/init.local.rc:root/init.omni.rc

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# mkshrc
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/mkshrc:system/etc/mkshrc    

# AR
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/common/etc/calibration_cad.xml:system/etc/calibration_cad.xml      

# Additional packages
-include vendor/omni/config/packages.mk

# GApps
-include vendor/gapps/config.mk

# Pixelstyle
-include vendor/pixelstyle/config.mk

# Versioning
-include vendor/omni/config/version.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/omni/overlay/common

# Enable dexpreopt for all nightlies
ifeq ($(ROM_BUILDTYPE),NIGHTLY)
    ifeq ($(WITH_DEXPREOPT),)
        WITH_DEXPREOPT := true
        WITH_DEXPREOPT_PIC := true
    endif
endif
# and weeklies
ifeq ($(ROM_BUILDTYPE),WEEKLY)
    ifeq ($(WITH_DEXPREOPT),)
        WITH_DEXPREOPT := true
        WITH_DEXPREOPT_PIC := true
    endif
endif
# and security releases
ifeq ($(ROM_BUILDTYPE),SECURITY_RELEASE)
    ifeq ($(WITH_DEXPREOPT),)
        WITH_DEXPREOPT := true
        WITH_DEXPREOPT_PIC := true
    endif
endif
# but not homemades
ifeq ($(ROM_BUILDTYPE),HOMEMADE)
    WITH_DEXPREOPT := true
    WITH_DEXPREOPT_PIC := true
endif
