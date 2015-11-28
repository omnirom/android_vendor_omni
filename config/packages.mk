# Additional packages
ifneq ($(TARGET_LOW_RAM_DEVICE), true)
PRODUCT_PACKAGES += \
    Basic \
    Development
endif

# Additional apps
PRODUCT_PACKAGES += \
    Apollo \
    MonthCalendarWidget \
    OpenDelta \
    OmniSwitch \
    Chromium

ifneq ($(TARGET_NO_DSPMANAGER), true)
PRODUCT_PACKAGES += \
    audio_effects.conf \
    DSPManager \
    libcyanogen-dsp
endif

PRODUCT_PACKAGES += \
    CellBroadcastReceiver

# Additional tools
PRODUCT_PACKAGES += \
    bash \
    e2fsck \
    fsck.exfat \
    htop \
    lsof \
    mke2fs \
    mkfs.exfat \
    mount.exfat \
    nano \
    openvpn \
    powertop \
    tune2fs \
    vim \
    ntfsfix \
    ntfs-3g \
    mkntfs

