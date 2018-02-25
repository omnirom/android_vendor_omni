# Additional apps
PRODUCT_PACKAGES += \
    OpenDelta \
    Chromium \
    OmniStyle \
    OmniJaws \
    QuickSearchBox \
    MusicFX \
    audio_effects.conf \
    libcyanogen-dsp \
    Phonograph \
    Turbo

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
    Stock \
    SluttyPinkTheme \
    DarknessMeisterTheme \
    SmokedGreenTheme \
    Bl4ckAndYell0Theme \
    OmniTheme \
    GboardOmniTheme \
    PixelBlackTheme \
    PixelDarkTheme \
    FromHellTheme \
    FromDeepHellTheme \
    GboardOmniTheme \
    ZeroZeroTheme

# Textclassifiers
PRODUCT_PACKAGES += \
    textclassifier.langid.model \
    textclassifier.smartselection.bundle1 \
    textclassifier.smartselection.ar.model \
    textclassifier.smartselection.it.model \
    textclassifier.smartselection.nl.model \
    textclassifier.smartselection.pl.model \
    textclassifier.smartselection.pt.model \
    textclassifier.smartselection.ru.model \
    textclassifier.smartselection.tr.model \
    textclassifier.smartselection.zh.model \
    textclassifier.smartselection.zh-Hant.model

# for fun
PRODUCT_PACKAGES += EggGame
