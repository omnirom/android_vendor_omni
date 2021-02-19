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
OMNI_PRODUCT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
OMNI_PRODUCT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# general properties
OMNI_PRODUCT_PROPERTIES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.build.selinux=1 \
    persist.sys.disable_rescue=true

# Google assistant
OMNI_PRODUCT_PROPERTIES += \
    ro.opa.eligible_device=true

# Tethering - allow without requiring a provisioning app
# (for devices that check this)
OMNI_PRODUCT_PROPERTIES += \
    net.tethering.noprovisioning=true

# Enforce privapp-permissions whitelist
OMNI_PRODUCT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/bin/clean_cache.sh:system/bin/clean_cache.sh

# Backup Tool
ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/omni/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/omni/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
ifeq ($(filter $(ROM_BUILDTYPE), GAPPS MICROG),)
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/addon.d/69-gapps.sh:system/addon.d/69-gapps.sh
endif
else
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/omni/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/omni/prebuilt/bin/blacklist:system/addon.d/blacklist
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/sysconfig/backup.xml:system/etc/sysconfig/backup.xml

# Init script file with omni extras
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/init.local.rc:system/etc/init/init.omni.rc

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

#permissions
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/permissions/privapp-permissions-omni.xml:system/etc/permissions/privapp-permissions-omni.xml \
    vendor/omni/prebuilt/etc/permissions/omni-power-whitelist.xml:system/etc/sysconfig/omni-power-whitelist.xml

# custom omni sounds
OMNI_PRODUCT_PROPERTIES += \
    ro.config.ringtone=omni_ringtone1.ogg \
    ro.config.notification_sound=omni_notification1.ogg \
    ro.config.alarm_alert=omni_alarm1.ogg

PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/sounds/camera_click_48k.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/camera_click.ogg \
    vendor/omni/prebuilt/sounds/VideoRecord_48k.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/VideoRecord.ogg \
    vendor/omni/prebuilt/sounds/VideoStop_48k.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/VideoStop.ogg \
    vendor/omni/prebuilt/sounds/omni_ringtone1.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ringtones/omni_ringtone1.ogg \
    vendor/omni/prebuilt/sounds/omni_ringtone2.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ringtones/omni_ringtone2.ogg \
    vendor/omni/prebuilt/sounds/omni_ringtone3.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ringtones/omni_ringtone3.ogg \
    vendor/omni/prebuilt/sounds/omni_alarm1.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/alarms/omni_alarm1.ogg \
    vendor/omni/prebuilt/sounds/omni_alarm2.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/alarms/omni_alarm2.ogg \
    vendor/omni/prebuilt/sounds/omni_notification1.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/notifications/omni_notification1.ogg \
    vendor/omni/prebuilt/sounds/omni_lowbattery1.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/omni_lowbattery1.ogg \
    vendor/omni/prebuilt/sounds/omni_lock_phone.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/omni_lock_phone.ogg \
    vendor/omni/prebuilt/sounds/omni_unlock_phone.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/omni_unlock_phone.ogg \
    vendor/omni/prebuilt/sounds/omni_charge_start.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/ChargingStarted.ogg

# mkshrc
#PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/mkshrc:system/etc/mkshrc

# whitelist packages for location providers not in system
OMNI_PRODUCT_PROPERTIES += \
    ro.services.whitelist.packagelist=com.google.android.gms

PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

# Additional packages
-include vendor/omni/config/packages.mk

# Versioning
-include vendor/omni/config/version.mk

# Add our overlays
DEVICE_PACKAGE_OVERLAYS += vendor/omni/overlay/common
