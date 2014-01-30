PRODUCT_BRAND ?= Anime

# bootanimation
#PRODUCT_COPY_FILES += \
#	vendor/Anime/prebuilt/bootanimation/bootanimation.zip:system/media/bootanimation.zip


ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# general properties
PRODUCT_PROPERTY_OVERRIDES += \
	keyguard.no_require_sim=true \
	ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
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
    vendor/Anime/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/Anime/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/Anime/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/Anime/prebuilt/bin/blacklist:system/addon.d/blacklist

#superSU
PRODUCT_COPY_FILES += \
    vendor/Anime/prebuilt/bin/chattr:system/bin/chattr \
    vendor/Anime/prebuilt/bin/su:system/bin/su \
    vendor/Anime/prebuilt/app/Superuser.apk:system/app/Superuser.apk \
    vendor/Anime/prebuilt/etc/install-recovery.sh:system/etc/install-recovery.sh \
    vendor/Anime/prebuilt/etc/init.d/99SuperSUDaemon:system/etc/99SuperSUDaemon \
    vendor/Anime/prebuilt/xbin/su:system/xbin/su 


# init.d support
PRODUCT_COPY_FILES += \
	vendor/Anime/prebuilt/etc/init.d/00banner:system/etc/init.d/00banner \
	vendor/Anime/prebuilt/bin/sysinit:system/bin/sysinit

# userinit support
PRODUCT_COPY_FILES += \
    vendor/Anime/prebuilt/etc/init.d/90userinit:system/etc/init.d/90userinit

# Init script file with Anime extras
PRODUCT_COPY_FILES += \
    vendor/Anime/prebuilt/etc/init.local.rc:root/init.Anime.rc

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Additional packages
-include vendor/Anime/config/packages.mk

# Versioning
-include vendor/Anime/config/version.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/Anime/overlay/common
