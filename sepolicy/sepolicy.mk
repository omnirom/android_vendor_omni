#
# This policy configuration will be used by all products that
# inherit from Monster
#

BOARD_SEPOLICY_DIRS += \
    vendor/monster/sepolicy

BOARD_SEPOLICY_UNION += \
    file_contexts \
    file.te \
    genfs_contexts \
    installd.te \
    mac_permissions.xml \
	vold.te
