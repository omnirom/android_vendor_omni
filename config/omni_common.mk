PRODUCT_BRAND ?= omni

# bootanimation
PRODUCT_COPY_FILES += \
	vendor/omni/bootanimation.zip:system/media/bootanimation.zip

# general properties
PRODUCT_PROPERTIES_OVERRIDE += \
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

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/omni/overlay/common

# Additional packages
PRODUCT_PACKAGES += \
	Development \
	LatinIME \
	VideoEditor \
	VoiceDialer \
	SoundRecorder \
	Basic

# Additional apps
PRODUCT_PACKAGES += \
	Apollo \
	DashClock \
	DSPManager \
	libcyanogen-dsp \
	audio_effects.conf \
	MonthCalendarWidget

PRODUCT_PACKAGES += \
	CellBroadcastReceiver

# Additional tools
PRODUCT_PACKAGES += \
	openvpn \
	e2fsck \
	mke2fs \
	tune2fs \
	bash \
	vim \
	nano \
	htop \
	powertop \
	lsof

# Versioning of the ROM
PRODUCT_VERSION_MAJOR = 4
PRODUCT_VERSION_MINOR = 3
PRODUCT_VERSION_REVISION = 0

ifdef BUILDTYPE_NIGHTLY
	ROM_BUILDTYPE := NIGHTLY
endif
ifdef BUILDTYPE_AUTOTEST
	ROM_BUILDTYPE := AUTOTEST
endif
ifdef BUILDTYPE_EXPERIMENTAL
	ROM_BUILDTYPE := EXPERIMENTAL
endif
ifdef BUILDTYPE_RELEASE
	ROM_BUILDTYPE := RELEASE
endif

ifndef ROM_BUILDTYPE
	ROM_BUILDTYPE := HOMEMADE
endif

# Build the final version string
ifdef BUILDTYPE_RELEASE
	ROM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_REVISION)-$(TARGET_PRODUCT)
else
	ROM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_REVISION)-$(shell date -u +%Y%m%d)-$(TARGET_PRODUCT)-$(ROM_BUILDTYPE)
endif

# Apply it to build.prop
PRODUCT_PROPERTY_OVERRIDES += \
	ro.modversion=$(ROM_VERSION)

# Disable ADB authentication and set root access to Apps and ADB
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.adb.secure=0 \
    persist.sys.root_access=3
