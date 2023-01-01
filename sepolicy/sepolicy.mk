#
# This policy configuration will be used by all products that
# inherit from Omni
#

BOARD_VENDOR_SEPOLICY_DIRS += \
    vendor/omni/sepolicy/vendor

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += vendor/omni/sepolicy/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += vendor/omni/sepolicy/public

ifeq ($(BOARD_USES_QCOM_HARDWARE), true)
BOARD_VENDOR_SEPOLICY_DIRS += \
    vendor/omni/sepolicy/qcom/vendor
endif