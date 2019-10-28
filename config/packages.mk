# Additional apps
PRODUCT_PACKAGES += \
    MonthCalendarWidget \
    OmniSwitch \
    Chromium \
    OmniJaws \
    OmniStyle \
    MusicFX \
    Phonograph \
    MatLog \
    OmniChange \
    OpenDelta \
    Turbo \
    OmniRecord \
    WallpaperPicker2 \
    ThemePicker \
    webview

PRODUCT_PACKAGES += \
     StatixOverlayStub

# Additional tools
PRODUCT_PACKAGES += \
    e2fsck \
    fsck.exfat \
    lsof \
    mke2fs \
    mount.exfat \
    openvpn \
    tune2fs \
    mkfs.ntfs \
    mount.ntfs \
    fsck.ntfs \
    mkshrc_vendor \
    toybox_vendor \
    sh_vendor \
    vim

ifeq ($(BOARD_INCLUDE_CMDLINE_TOOLS),true)
PRODUCT_PACKAGES += \
    bash \
    htop \
    nano \
    powertop \
    rsync \
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
PRODUCT_PACKAGES += telephony-ext
PRODUCT_BOOT_JARS += telephony-ext

# for fun
PRODUCT_PACKAGES += \
    EggGame

#PRODUCT_PACKAGES += \
    ExtraFonts

PRODUCT_PACKAGES_ENG += \
    bash \
    su
