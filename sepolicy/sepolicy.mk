#
# This policy configuration will be used by all products that
# inherit from Omni
#

BOARD_SEPOLICY_DIRS += \
    vendor/omni/sepolicy

BOARD_SEPOLICY_UNION += \
    file.te \
    file_contexts \
    fs_use \
    genfs_contexts \
    installd.te \
    ueventd.te \
    vold.te \
    mac_permissions.xml