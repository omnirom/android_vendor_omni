# OmniRom Platform Library
PRODUCT_PACKAGES += \
    omnirom-res \
    OmniLib \
    omnirom.internal

PRODUCT_SYSTEM_SERVER_JARS += \
    OmniLib

# Additional apps
PRODUCT_PACKAGES += \
    MonthCalendarWidget \
    OmniSwitch \
    OmniJaws \
    MatLog \
    OmniStoreInstallerPrebuilt \
    OmniOta \
    OmniWallpaper \
    OmniRemote \
    OmniControl \
    ThemePicker \
    ThemesStub

# Additional tools
PRODUCT_PACKAGES += \
    e2fsck \
    fsck.exfat \
    lsof \
    mke2fs \
    mkfs.exfat \
    openvpn \
    tune2fs \
    mkfs.ntfs \
    mount.ntfs \
    fsck.ntfs \
    mkshrc_vendor \
    toybox_vendor \
    sh_vendor \
    vim \
    vncpasswd \
    SystemWebView \
    omni-overlays

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# MicroG SystemUI overlay
ifeq ($(ROM_BUILDTYPE),MICROG)
PRODUCT_PACKAGES += \
    MicroGSystemUIOverlay
endif

$(call inherit-product-if-exists, external/google-fonts/lato/fonts.mk)
$(call inherit-product-if-exists, vendor/omni/prebuilt/fonts/fonts.mk)
