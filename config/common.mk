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
    ro.build.selinux=1 \
    persist.sys.disable_rescue=true

# enable ADB authentication if not on eng build
ifneq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES  += ro.adb.secure=1
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
    vendor/omni/prebuilt/sounds/omni_lowbattery1.ogg:system/media/audio/ui/omni_lowbattery1.ogg \
    vendor/omni/prebuilt/sounds/omni_lock_phone.ogg:system/media/audio/ui/omni_lock_phone.ogg \
    vendor/omni/prebuilt/sounds/omni_unlock_phone.ogg:system/media/audio/ui/omni_unlock_phone.ogg

# mkshrc
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/mkshrc:system/etc/mkshrc

# Additional packages
-include vendor/omni/config/packages.mk

# Versioning
-include vendor/omni/config/version.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/omni/overlay/common

# Enable dexpreopt for all nightlies
ifeq ($(ROM_BUILDTYPE),NIGHTLY)
    ifeq ($(WITH_DEXPREOPT),)
        WITH_DEXPREOPT := true
    endif
endif
# and weeklies
ifeq ($(ROM_BUILDTYPE),WEEKLY)
    ifeq ($(WITH_DEXPREOPT),)
        WITH_DEXPREOPT := true
    endif
endif
# and security releases
ifeq ($(ROM_BUILDTYPE),SECURITY_RELEASE)
    ifeq ($(WITH_DEXPREOPT),)
        WITH_DEXPREOPT := true
    endif
endif
# but not homemades
ifeq ($(ROM_BUILDTYPE),HOMEMADE)
    WITH_DEXPREOPT := false
endif
