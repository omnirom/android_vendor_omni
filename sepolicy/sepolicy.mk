#
# This policy configuration will be used by all products that
# inherit from Omni
#

BOARD_SEPOLICY_DIRS += \
    vendor/omni/sepolicy

BOARD_SEPOLICY_UNION += \
    adbd.te \
    file_contexts \
    file.te \
    genfs_contexts \
    healthd.te \
    property_contexts \
    installd.te \
    property.te \
    shell.te \
    sysinit.te \
    system.te \
    system_app.te \
    system_server.te \
    ueventd.te \
    userinit.te \
    vold.te
