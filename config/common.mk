PRODUCT_BRAND ?= omni

# use specific resolution for bootanimation
ifneq ($(TARGET_BOOTANIMATION_SIZE),)
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/bootanimation/res/$(TARGET_BOOTANIMATION_SIZE).zip:system/media/bootanimation.zip
else
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/bootanimation/bootanimation.zip:system/media/bootanimation.zip
endif

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

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/sysconfig/backup.xml:system/etc/sysconfig/backup.xml

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

# custom omni sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=omni_ringtone1.ogg \
    ro.config.notification_sound=omni_notification1.ogg \
    ro.config.alarm_alert=omni_alarm1.ogg

PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/sounds/camera_click_48k.ogg:system/media/audio/ui/camera_click.ogg \
    vendor/omni/prebuilt/sounds/VideoRecord_48k.ogg:system/media/audio/ui/VideoRecord.ogg \
    vendor/omni/prebuilt/sounds/VideoStop_48k.ogg:system/media/audio/ui/VideoStop.ogg \
    vendor/omni/prebuilt/sounds/omni_ringtone1.ogg:system/media/audio/ringtones/omni_ringtone1.ogg \
    vendor/omni/prebuilt/sounds/omni_ringtone2.ogg:system/media/audio/ringtones/omni_ringtone2.ogg \
    vendor/omni/prebuilt/sounds/omni_ringtone3.ogg:system/media/audio/ringtones/omni_ringtone3.ogg \
    vendor/omni/prebuilt/sounds/omni_alarm1.ogg:system/media/audio/alarms/omni_alarm1.ogg \
    vendor/omni/prebuilt/sounds/omni_alarm2.ogg:system/media/audio/alarms/omni_alarm2.ogg \
    vendor/omni/prebuilt/sounds/omni_notification1.ogg:system/media/audio/notifications/omni_notification1.ogg \
    vendor/omni/prebuilt/sounds/omni_lowbattery1.ogg:system/media/audio/ui/omni_lowbattery1.ogg

# Additional packages
-include vendor/omni/config/packages.mk

# Versioning
-include vendor/omni/config/version.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/omni/overlay/common

# Enable dexpreopt for all nightlies
ifeq ($(ROM_BUILDTYPE),NIGHTLY)
    WITH_DEXPREOPT := true
endif
# and weeklies
ifeq ($(ROM_BUILDTYPE),WEEKLY)
    WITH_DEXPREOPT := true
endif
# and security releases
ifeq ($(ROM_BUILDTYPE),SECURITY_RELEASE)
    WITH_DEXPREOPT := true
endif
# but not homemades
ifeq ($(ROM_BUILDTYPE),HOMEMADE)
    WITH_DEXPREOPT := false
endif
