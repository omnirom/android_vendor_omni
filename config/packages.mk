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
    OmniOta \
    OmniWallpaper \
    OmniRemote \
    OmniControl

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
    SystemWebView \
    omni-overlays


$(call inherit-product-if-exists, external/google-fonts/lato/fonts.mk)
$(call inherit-product-if-exists, vendor/omni/prebuilt/fonts/fonts.mk)
