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

SOONG_CONFIG_NAMESPACES += omniromVarsPlugin

SOONG_CONFIG_omniromVarsPlugin :=

define addVar
  SOONG_CONFIG_omniromVarsPlugin += $(1)
  SOONG_CONFIG_omniromVarsPlugin_$(1) := $($1)
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += omniGlobalVars
SOONG_CONFIG_omniGlobalVars += \
    aapt_version_code \
    additional_gralloc_10_usage_bits \
    camera_override_format_from_reserved \
    target_create_device_symlinks \
    target_health_charging_control_charging_enabled \
    target_health_charging_control_charging_disabled \
    target_health_charging_control_deadline_path \
    target_health_charging_control_supports_bypass \
    target_health_charging_control_supports_deadline \
    target_health_charging_control_supports_toggle \
    target_init_vendor_lib \
    target_surfaceflinger_udfps_lib \
    gralloc_handle_has_custom_content_md_reserved_size \
    gralloc_handle_has_reserved_size \
    gralloc_handle_has_ubwcp_format \
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

ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH),)
SOONG_CONFIG_omniGlobalVars += \
    target_health_charging_control_charging_path
endif

SOONG_CONFIG_NAMESPACES += omniQcomVars
SOONG_CONFIG_omniQcomVars += \
    healthd_enable_tricolor_led \
    supports_extended_compress_format \
    supports_hw_fde \
    supports_hw_fde_perf

# Only create display_headers_namespace var if dealing with UM platforms to avoid breaking build for all other platforms
ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_omniQcomVars += \
    qcom_display_headers_namespace
endif

# Soong bool variables
SOONG_CONFIG_omniQcomVars_healthd_enable_tricolor_led := $(HEALTHD_ENABLE_TRICOLOR_LED)
SOONG_CONFIG_omniQcomVars_supports_extended_compress_format := $(AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT)
SOONG_CONFIG_omniQcomVars_supports_hw_fde := $(TARGET_HW_DISK_ENCRYPTION)
SOONG_CONFIG_omniQcomVars_supports_hw_fde_perf := $(TARGET_HW_DISK_ENCRYPTION_PERF)
SOONG_CONFIG_omniGlobalVars_aapt_version_code := $(shell date -u +%Y%m%d)
SOONG_CONFIG_omniGlobalVars_camera_override_format_from_reserved := $(TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED)
SOONG_CONFIG_omniGlobalVars_gralloc_handle_has_custom_content_md_reserved_size := $(TARGET_GRALLOC_HANDLE_HAS_CUSTOM_CONTENT_MD_RESERVED_SIZE)
SOONG_CONFIG_omniGlobalVars_gralloc_handle_has_reserved_size := $(TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE)
SOONG_CONFIG_omniGlobalVars_gralloc_handle_has_ubwcp_format := $(TARGET_GRALLOC_HANDLE_HAS_UBWCP_FORMAT)
SOONG_CONFIG_omniGlobalVars_healthd_use_battery_info := $(HEALTHD_USE_BATTERY_INFO)
SOONG_CONFIG_omniGlobalVars_healthd_enable_op_fastchg := $(HEALTHD_ENABLE_OP_FASTCHG_CHECK)
SOONG_CONFIG_omniGlobalVars_targetNeedsHWCOnFirstRef := $(TARGET_NEEDS_HWC_ONFIRSTREF)
SOONG_CONFIG_omniGlobalVars_uses_metadata_as_fde_key := $(TARGET_USES_METADATA_AS_FDE_KEY)
SOONG_CONFIG_omniGlobalVars_target_use_sdclang := $(TARGET_USE_SDCLANG)
SOONG_CONFIG_omniGlobalVars_target_camera_needs_client_info := $(TARGET_CAMERA_NEEDS_CLIENT_INFO)
SOONG_CONFIG_omniGlobalVars_target_enforce_ab_ota_partition_list := $(TARGET_ENFORCE_AB_OTA_PARTITION_LIST)
SOONG_CONFIG_omniGlobalVars_target_create_device_symlinks := $(TARGET_CREATE_DEVICE_SYMLINKS)

# Set default values
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS ?= 0
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED ?= 1
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED ?= 0
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS ?= true
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE ?= false
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE ?= true
TARGET_INIT_VENDOR_LIB ?= vendor_init
TARGET_SURFACEFLINGER_UDFPS_LIB ?= surfaceflinger_udfps_lib
TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED ?= false
TARGET_GRALLOC_HANDLE_HAS_CUSTOM_CONTENT_MD_RESERVED_SIZE ?= false
TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE ?= false
TARGET_GRALLOC_HANDLE_HAS_UBWCP_FORMAT ?= false

SOONG_CONFIG_omniGlobalVars_launcher3Gapps ?= false
SOONG_CONFIG_omniGlobalVars_launcher3Mock ?= false
SOONG_CONFIG_omniGlobalVars_useWeeklyBuild ?= false

# Soong value variables
SOONG_CONFIG_omniGlobalVars_additional_gralloc_10_usage_bits := $(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS)
ifneq ($(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH),)
SOONG_CONFIG_omniGlobalVars_target_health_charging_control_charging_path := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH)
endif
SOONG_CONFIG_omniGlobalVars_target_health_charging_control_charging_enabled := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED)
SOONG_CONFIG_omniGlobalVars_target_health_charging_control_charging_disabled := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED)
SOONG_CONFIG_omniGlobalVars_target_health_charging_control_deadline_path := $(TARGET_HEALTH_CHARGING_CONTROL_DEADLINE_PATH)
SOONG_CONFIG_omniGlobalVars_target_health_charging_control_supports_bypass := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS)
SOONG_CONFIG_omniGlobalVars_target_health_charging_control_supports_deadline := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE)
SOONG_CONFIG_omniGlobalVars_target_health_charging_control_supports_toggle := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE)
SOONG_CONFIG_omniGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
SOONG_CONFIG_omniGlobalVars_target_surfaceflinger_udfps_lib := $(TARGET_SURFACEFLINGER_UDFPS_LIB)

ifneq ($(filter $(QSSI_SUPPORTED_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_omniQcomVars_qcom_display_headers_namespace := vendor/qcom/opensource/commonsys-intf/display
else
SOONG_CONFIG_omniQcomVars_qcom_display_headers_namespace := $(QCOM_SOONG_NAMESPACE)/display
endif

ifeq ($(ROM_BUILDTYPE),GAPPS)
    SOONG_CONFIG_omniGlobalVars_launcher3Gapps := true
else
    SOONG_CONFIG_omniGlobalVars_launcher3Mock := true
endif

ifeq ($(ROM_BUILDTYPE),WEEKLY)
    SOONG_CONFIG_omniGlobalVars_useWeeklyBuild := true
endif
