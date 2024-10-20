# Board platforms lists to be used for
# TARGET_BOARD_PLATFORM specific featurization
QCOM_BOARD_PLATFORMS := msm7627_surf
QCOM_BOARD_PLATFORMS += msm7627_6x
QCOM_BOARD_PLATFORMS += msm7627a
QCOM_BOARD_PLATFORMS += msm7630_surf
QCOM_BOARD_PLATFORMS += msm7630_fusion
QCOM_BOARD_PLATFORMS += msm8226
QCOM_BOARD_PLATFORMS += msm8660
QCOM_BOARD_PLATFORMS += msm8909
QCOM_BOARD_PLATFORMS += msm8916
QCOM_BOARD_PLATFORMS += msm8939
QCOM_BOARD_PLATFORMS += msm8937
QCOM_BOARD_PLATFORMS += msm8952
QCOM_BOARD_PLATFORMS += msm8953
QCOM_BOARD_PLATFORMS += msm8960
QCOM_BOARD_PLATFORMS += msm8974
QCOM_BOARD_PLATFORMS += msm8992
QCOM_BOARD_PLATFORMS += msm8994
QCOM_BOARD_PLATFORMS += msm8996
QCOM_BOARD_PLATFORMS += msm8998
QCOM_BOARD_PLATFORMS += apq8084
QCOM_BOARD_PLATFORMS += sdm660
QCOM_BOARD_PLATFORMS += sdm710
QCOM_BOARD_PLATFORMS += sdm845
QCOM_BOARD_PLATFORMS += sm8150
QCOM_BOARD_PLATFORMS += msmnile
QCOM_BOARD_PLATFORMS += kona
QCOM_BOARD_PLATFORMS += sm6150
QCOM_BOARD_PLATFORMS += sm8250
QCOM_BOARD_PLATFORMS += lahaina
QCOM_BOARD_PLATFORMS += sm8350
QCOM_BOARD_PLATFORMS += taro

MSM7K_BOARD_PLATFORMS := msm7630_surf
MSM7K_BOARD_PLATFORMS += msm7630_fusion
MSM7K_BOARD_PLATFORMS += msm7627_surf
MSM7K_BOARD_PLATFORMS += msm7627_6x
MSM7K_BOARD_PLATFORMS += msm7627a
MSM7K_BOARD_PLATFORMS += msm7k

QSD8K_BOARD_PLATFORMS := qsd8k

# Target-specific configuration
qcom_flags := -DQCOM_HARDWARE
ifeq ($(TARGET_USES_QCOM_BSP),true)
    qcom_flags += -DQCOM_BSP
    qcom_flags += -DQTI_BSP
endif

PRIVATE_TARGET_GLOBAL_CFLAGS += $(qcom_flags)
PRIVATE_TARGET_GLOBAL_CPPFLAGS += $(qcom_flags)

TARGET_COMPILE_WITH_MSM_KERNEL := true
MSM_VIDC_TARGET_LIST := \
    msm8974 \
    msm8610 \
    msm8226 \
    apq8084 \
    msm8916 \
    msm8937 \
    msm8952 \
    msm8953 \
    msm8994 \
    msm8909 \
    msm8992 \
    msm8996 \
    msm8998 \
    sdm660 \
    sdm710 \
    sdm845 \
    sm8150 \
    msmnile \
    sm6150 \
    kona

# Gralloc Usage Bits
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS := (1 << 13) | (1 << 21) | (1 << 27)

# Wlan AOSP guard
TARGET_USES_HARDWARE_QCOM_WLAN := false

# Wlan Qcom Guard
PRODUCT_CFI_INCLUDE_PATHS += \
    hardware/qcom-caf/wlan/qcwcn/wpa_supplicant_8_lib

PRODUCT_SOONG_NAMESPACES += hardware/qcom-caf/wlan

# Qcom Display
PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/commonsys/display \
    vendor/qcom/opensource/commonsys-intf/display

SOONG_CONFIG_omniQcomVars += \
    qcom_display_headers_namespace
SOONG_CONFIG_omniQcomVars_qcom_display_headers_namespace := vendor/qcom/opensource/commonsys-intf/display
