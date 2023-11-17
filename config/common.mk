PRODUCT_BRAND ?= omni

# use specific resolution for bootanimation
ifneq ($(TARGET_BOOTANIMATION_SIZE),)
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/bootanimation/res/$(TARGET_BOOTANIMATION_SIZE).zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip \
    vendor/omni/prebuilt/bootanimation/res/$(TARGET_BOOTANIMATION_SIZE).zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation-dark.zip
else
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/bootanimation/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip \
    vendor/omni/prebuilt/bootanimation/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation-dark.zip
endif

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# general properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.build.selinux=1 \
    persist.sys.disable_rescue=true

# Google assistant
PRODUCT_PRODUCT_PROPERTIES += \
    ro.opa.eligible_device=true

# Tethering - allow without requiring a provisioning app
# (for devices that check this)
PRODUCT_PRODUCT_PROPERTIES += \
    net.tethering.noprovisioning=true

# Enforce privapp-permissions whitelist
#OMNI_PRODUCT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Backup Tool
ifeq ($(ROM_BUILDTYPE),WEEKLY)
ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/omni/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/omni/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
else
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/common/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/omni/prebuilt/common/bin/backuptool.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool.sh \
    vendor/omni/prebuilt/common/bin/backuptool.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool.functions
endif
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/sysconfig/backup.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/backup.xml

# bg excemption whitelist
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/sysconfig/omniota.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/omniota.xml

# Init script file with omni extras
PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/init.local.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.omni.rc

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/android.software.sip.voip.xml

PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/permissions/privapp-permissions-omni-ext.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-omni-ext.xml

# custom omni sounds
PRODUCT_PRODUCT_PROPERTIES += \
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

PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/etc/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

# Additional packages
-include vendor/omni/config/packages.mk

# Set support one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# SystemUI plugins
ifeq ($(ROM_BUILDTYPE),$(filter $(ROM_BUILDTYPE),GAPPS))
PRODUCT_PACKAGES += \
    QuickAccessWallet
endif

# Versioning
-include vendor/omni/config/version.mk

# Add our overlays
DEVICE_PACKAGE_OVERLAYS += vendor/omni/overlay/common
