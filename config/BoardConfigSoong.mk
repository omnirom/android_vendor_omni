# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE

# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/LineageOS/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

$(call add_soong_config_namespace,omniromVarsPlugin)
$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call add_soong_config_var,omniromVarsPlugin,$(v))))

SOONG_CONFIG_NAMESPACES += omniGlobalVars
SOONG_CONFIG_omniGlobalVars += \
    healthd_use_battery_info \
    healthd_enable_op_fastchg \
    launcher3Gapps \
    launcher3Mock \
    targetNeedsHWCOnFirstRef \
    uses_metadata_as_fde_key \
    useWeeklyBuild \
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
SOONG_CONFIG_omniGlobalVars_healthd_use_battery_info := $(HEALTHD_USE_BATTERY_INFO)
SOONG_CONFIG_omniGlobalVars_healthd_enable_op_fastchg := $(HEALTHD_ENABLE_OP_FASTCHG_CHECK)
SOONG_CONFIG_omniGlobalVars_targetNeedsHWCOnFirstRef := $(TARGET_NEEDS_HWC_ONFIRSTREF)
SOONG_CONFIG_omniGlobalVars_uses_metadata_as_fde_key := $(TARGET_USES_METADATA_AS_FDE_KEY)
SOONG_CONFIG_omniGlobalVars_target_use_sdclang := $(TARGET_USE_SDCLANG)
SOONG_CONFIG_omniGlobalVars_target_camera_needs_client_info := $(TARGET_CAMERA_NEEDS_CLIENT_INFO)
SOONG_CONFIG_omniGlobalVars_target_enforce_ab_ota_partition_list := $(TARGET_ENFORCE_AB_OTA_PARTITION_LIST)

# Set default values
SOONG_CONFIG_omniGlobalVars_launcher3Gapps ?= false
SOONG_CONFIG_omniGlobalVars_launcher3Mock ?= false
SOONG_CONFIG_omniGlobalVars_useWeeklyBuild ?= false

# Soong value variables
ifeq ($(ROM_BUILDTYPE),GAPPS)
    SOONG_CONFIG_omniGlobalVars_launcher3Gapps := true
else
    SOONG_CONFIG_omniGlobalVars_launcher3Mock := true
endif

ifeq ($(ROM_BUILDTYPE),WEEKLY)
    SOONG_CONFIG_omniGlobalVars_useWeeklyBuild := true
endif

# Camera
ifneq ($(TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED),)
    $(error TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED is deprecated, please migrate to soong_config_set,camera,override_format_from_reserved)
endif

# Libui
ifneq ($(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS),)
    $(call soong_config_set,libui,additional_gralloc_10_usage_bits,$(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS))
endif

# Lineage Health HAL
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH is deprecated, please migrate to soong_config_set,lineage_health,charging_control_charging_path)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_DEADLINE_PATH),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_DEADLINE_PATH is deprecated, please migrate to soong_config_set,lineage_health,charging_control_deadline_path)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED is deprecated, please migrate to soong_config_set,lineage_health,charging_control_charging_enabled)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED is deprecated, please migrate to soong_config_set,lineage_health,charging_control_charging_disabled)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS is deprecated, please migrate to soong_config_set,lineage_health,charging_control_supports_bypass)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE is deprecated, please migrate to soong_config_set,lineage_health,charging_control_supports_deadline)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_LIMIT),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_LIMIT is deprecated, please migrate to soong_config_set,lineage_health,charging_control_supports_limit)
endif
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE),)
    $(error TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE is deprecated, please migrate to soong_config_set,lineage_health,charging_control_supports_toggle)
endif

# Surfaceflinger
ifneq ($(TARGET_SURFACEFLINGER_UDFPS_LIB),)
    $(error TARGET_SURFACEFLINGER_UDFPS_LIB is deprecated, please migrate to soong_config_set,surfaceflinger,udfps_lib)
endif

# Vendor init
ifneq ($(TARGET_INIT_VENDOR_LIB),)
    $(error TARGET_INIT_VENDOR_LIB is deprecated, please migrate to soong_config_set,libinit,vendor_init_lib)
endif

ifneq ($(TARGET_CREATE_DEVICE_SYMLINKS),)
    $(error TARGET_CREATE_DEVICE_SYMLINKS is deprecated, please migrate to soong_config_set,libinit,vendor_init_device_symlinks)
endif
