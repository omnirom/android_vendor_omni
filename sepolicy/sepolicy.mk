#
# This policy configuration will be used by all products that
# inherit from Omni
#

BOARD_VENDOR_SEPOLICY_DIRS += \
    vendor/omni/sepolicy/common

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += vendor/omni/sepolicy/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += vendor/omni/sepolicy/public
