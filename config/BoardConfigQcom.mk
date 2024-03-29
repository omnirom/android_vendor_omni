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

$(call set-device-specific-path,AUDIO,audio,hardware/qcom-caf/$(QCOM_HARDWARE_VARIANT)/audio)
$(call set-device-specific-path,DISPLAY,display,hardware/qcom-caf/$(QCOM_HARDWARE_VARIANT)/display)
$(call set-device-specific-path,MEDIA,media,hardware/qcom-caf/$(QCOM_HARDWARE_VARIANT)/media)

$(call set-device-specific-path,BT_VENDOR,bt-vendor,hardware/qcom-caf/bt)
$(call set-device-specific-path,DATA_IPA_CFG_MGR,data-ipa-cfg-mgr,vendor/qcom/opensource/data-ipa-cfg-mgr)
$(call set-device-specific-path,DATASERVICES,dataservices,vendor/qcom/opensource/dataservices)
$(call set-device-specific-path,VR,vr,hardware/qcom-caf/vr)
$(call set-device-specific-path,WLAN,wlan,hardware/qcom-caf/wlan)

PRODUCT_CFI_INCLUDE_PATHS += \
    hardware/qcom-caf/wlan/qcwcn/wpa_supplicant_8_lib
