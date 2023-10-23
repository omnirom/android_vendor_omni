# OmniRom Platform Library
PRODUCT_PACKAGES += \
    omnirom-res \
    OmniLib

# Additional apps
PRODUCT_PACKAGES += \
    MonthCalendarWidget \
    OmniSwitch \
    OmniJaws \
    MatLog \
    OmniStoreInstallerPrebuilt \
    WallpaperCropper2 \
    OmniOta \
    OmniWallpaper

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
    vncflinger \
    vncpasswd \
    OmniRemote \
    SystemWebView \
    OmniControl \
    omni-overlays

#PRODUCT_PACKAGES += \
    ThemePicker \
    OmniOverlayStub \

ifeq ($(BOARD_INCLUDE_CMDLINE_TOOLS),true)
PRODUCT_PACKAGES += \
    htop \
    zip

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh
endif

# Config
#PRODUCT_PACKAGES += \
    SimpleDeviceConfig

ifeq ($(ROM_BUILDTYPE),MICROG)
PRODUCT_PACKAGES += \
    MicrogUIOverlay
endif

# Telephony extension
#PRODUCT_PACKAGES += telephony-ext
#PRODUCT_BOOT_JARS += telephony-ext

# for fun
#PRODUCT_PACKAGES += \
    EggGame

$(call inherit-product-if-exists, external/google-fonts/lato/fonts.mk)
$(call inherit-product-if-exists, vendor/omni/prebuilt/fonts/fonts.mk)
