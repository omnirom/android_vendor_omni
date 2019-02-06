# Additional apps
PRODUCT_PACKAGES += \
    MonthCalendarWidget \
    OmniSwitch \
    Chromium \
    OmniJaws \
    OmniStyle \
    OmniClockOSS \
    MusicFX \
    Phonograph \
    MatLog \
    OmniChange \
    OpenDelta \
    Turbo \
    OmniRecord

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

# Themes
#PRODUCT_PACKAGES += \
    GboardOmniTheme

PRODUCT_PACKAGES += \
    ContactsTheme \
    DocumentsUITheme \
    DialerTheme \
    MessagesTheme \
    TelecommTheme \
    PhonographTheme

PRODUCT_PACKAGES += \
    NotificationsDark \
    NotificationsLight \
    NotificationsPrimary

PRODUCT_PACKAGES += \
    AccentSluttyPink \
    AccentPixel \
    AccentGoldenShower \
    AccentDeepOrange \
    AccentOmni \
    AccentWhite \
    AccentTeal \
    AccentFromHell \
    AccentBlueMonday \
    AccentSmokingGreen \
    AccentDeadRed \
    AccentRottenOrange \
    AccentDeepPurple

PRODUCT_PACKAGES += \
    PrimaryAlmostBlack \
    PrimaryBlack \
    PrimaryOmni \
    PrimaryWhite \
    PrimaryColdWhite \
    PrimaryWarmWhite \
    PrimaryDarkBlue

# Textclassifiers
#PRODUCT_PACKAGES += \
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
PRODUCT_PACKAGES += \
    EggGame

#PRODUCT_PACKAGES += \
    ExtraFonts
