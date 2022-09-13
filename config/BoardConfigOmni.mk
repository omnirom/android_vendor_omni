ifneq ($(TARGET_USES_KERNEL_PLATFORM),true)
include vendor/omni/config/BoardConfigKernel.mk
endif

include vendor/omni/config/BoardConfigSoong.mk
