SOONG_CONFIG_NAMESPACES += omniGlobalVars
SOONG_CONFIG_omniGlobalVars += \
    target_create_device_symlinks \
    target_init_vendor_lib \
    target_surfaceflinger_udfps_lib \
    gralloc_handle_has_reserved_size \
    healthd_use_battery_info \
    healthd_enable_op_fastchg \
    targetNeedsHWCOnFirstRef \
    uses_metadata_as_fde_key \
    target_use_sdclang \
    target_camera_needs_client_info \
    target_enforce_ab_ota_partition_list

SOONG_CONFIG_NAMESPACES += omniQcomVars
SOONG_CONFIG_omniQcomVars += \
    healthd_enable_tricolor_led \
    supports_hw_fde \
    supports_hw_fde_perf

# Soong bool variables
SOONG_CONFIG_omniQcomVars_healthd_enable_tricolor_led := $(HEALTHD_ENABLE_TRICOLOR_LED)
SOONG_CONFIG_omniQcomVars_supports_hw_fde := $(TARGET_HW_DISK_ENCRYPTION)
SOONG_CONFIG_omniQcomVars_supports_hw_fde_perf := $(TARGET_HW_DISK_ENCRYPTION_PERF)
SOONG_CONFIG_omniGlobalVars_gralloc_handle_has_reserved_size := $(TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE)
SOONG_CONFIG_omniGlobalVars_healthd_use_battery_info := $(HEALTHD_USE_BATTERY_INFO)
SOONG_CONFIG_omniGlobalVars_healthd_enable_op_fastchg := $(HEALTHD_ENABLE_OP_FASTCHG_CHECK)
SOONG_CONFIG_omniGlobalVars_targetNeedsHWCOnFirstRef := $(TARGET_NEEDS_HWC_ONFIRSTREF)
SOONG_CONFIG_omniGlobalVars_uses_metadata_as_fde_key := $(TARGET_USES_METADATA_AS_FDE_KEY)
SOONG_CONFIG_omniGlobalVars_target_use_sdclang := $(TARGET_USE_SDCLANG)
SOONG_CONFIG_omniGlobalVars_target_camera_needs_client_info := $(TARGET_CAMERA_NEEDS_CLIENT_INFO)
SOONG_CONFIG_omniGlobalVars_target_enforce_ab_ota_partition_list := $(TARGET_ENFORCE_AB_OTA_PARTITION_LIST)
SOONG_CONFIG_omniGlobalVars_target_create_device_symlinks := $(TARGET_CREATE_DEVICE_SYMLINKS)

# Set default values
TARGET_INIT_VENDOR_LIB ?= vendor_init
TARGET_SURFACEFLINGER_UDFPS_LIB ?= surfaceflinger_udfps_lib
TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE ?= false

# Soong value variables
SOONG_CONFIG_omniGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
SOONG_CONFIG_omniGlobalVars_target_surfaceflinger_udfps_lib := $(TARGET_SURFACEFLINGER_UDFPS_LIB)
