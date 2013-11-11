#
# This policy configuration will be used by all products that
# inherit from Omni
#

BOARD_SEPOLICY_DIRS += \
    vendor/omni/sepolicy

BOARD_SEPOLICY_UNION += \
    file.te \
    genfs_contexts \
    mac_permissions.xml \
	vold.te
