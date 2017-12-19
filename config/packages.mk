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
    mkshrc_vendor \
    toybox_vendor \
    sh_vendor

PRODUCT_COPY_FILES += \
    vendor/omni/prebuilt/bin/vi:system/bin/vi

# Telephony extension
PRODUCT_PACKAGES += telephony-ext
PRODUCT_BOOT_JARS += telephony-ext

# OMS support
#PRODUCT_PACKAGES += ThemeInterfacer \
    OmniTheme \
    OmniSubs

# Themes
PRODUCT_PACKAGES += \
    PixelTheme

# for fun
PRODUCT_PACKAGES += EggGame
