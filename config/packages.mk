# Additional packages
ifneq ($(TARGET_LOW_RAM_DEVICE), true)
PRODUCT_PACKAGES += \
    Basic \
    Development
endif

# Additional apps
PRODUCT_PACKAGES += \
    Apollo \
    audio_effects.conf \
    DSPManager \
    libcyanogen-dsp \
    MonthCalendarWidget \
    OpenDelta \
    OmniSwitch

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

