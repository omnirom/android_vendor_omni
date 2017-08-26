# Additional packages
ifneq ($(TARGET_LOW_RAM_DEVICE), true)
PRODUCT_PACKAGES += \
    Basic \
    Development
endif

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
    MatLog \
    OmniTheme \
    OmniSubs

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
    fsck.ntfs

# for easter fun
PRODUCT_PACKAGES += EggGame
