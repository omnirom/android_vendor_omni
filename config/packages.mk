# Additional apps
PRODUCT_PACKAGES += \
    MonthCalendarWidget \
    OpenDelta \
    OmniSwitch \
    Chromium \
    OmniJaws \
    OmniStyle \
    QuickSearchBox \
    OmniClockOSS \
    MusicFX \
    audio_effects.conf \
    libcyanogen-dsp \
    Phonograph \
    Turbo \
    MatLog

# Additional tools
PRODUCT_PACKAGES += \
    bash \
    e2fsck \
    fsck.exfat \
    htop \
    lsof \
    mke2fs \
    mount.exfat \
    nano \
    openvpn \
    powertop \
    tune2fs \
    vim \
    mkfs.ntfs \
    mount.ntfs \
    fsck.ntfs \
    mkshrc_vendor \
    toybox_vendor \
    sh_vendor


# Telephony extension
PRODUCT_PACKAGES += telephony-ext
PRODUCT_BOOT_JARS += telephony-ext

# OMS support
#PRODUCT_PACKAGES += ThemeInterfacer \
    OmniTheme \
    OmniSubs

# Themes
PRODUCT_PACKAGES += \
    PixelTheme \
    Stock

# for fun
PRODUCT_PACKAGES += EggGame
