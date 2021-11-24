# Additional apps
PRODUCT_PACKAGES += \
    MonthCalendarWidget \
    OmniSwitch \
    OmniJaws \
    OmniStyle \
    MatLog \
    OmniStoreInstallerPrebuilt \
    OpenDelta \
    WallpaperCropper2

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

# Telephony extension
#PRODUCT_PACKAGES += telephony-ext
#PRODUCT_BOOT_JARS += telephony-ext

# for fun
#PRODUCT_PACKAGES += \
    EggGame

#PRODUCT_PACKAGES += \
    ExtraFonts

$(call inherit-product-if-exists, external/google-fonts/lato/fonts.mk)
$(call inherit-product-if-exists, vendor/omni/prebuilt/fonts/fonts.mk)
