# Bring in Qualcomm helper macros
include vendor/omni/build/core/qcom_utils.mk
include vendor/omni/build/core/pathmap.mk

# Target-specific configuration
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    qcom_flags := -DQCOM_HARDWARE
    ifeq ($(TARGET_USES_QCOM_BSP),true)
        qcom_flags += -DQCOM_BSP
        qcom_flags += -DQTI_BSP
    endif

#    TARGET_GLOBAL_CFLAGS += $(qcom_flags)
#    TARGET_GLOBAL_CPPFLAGS += $(qcom_flags)
    PRIVATE_TARGET_GLOBAL_CFLAGS += $(qcom_flags)
    PRIVATE_TARGET_GLOBAL_CPPFLAGS += $(qcom_flags)

    # Multiarch needs these too..
#    2ND_TARGET_GLOBAL_CFLAGS += $(qcom_flags)
#    2ND_TARGET_GLOBAL_CPPFLAGS += $(qcom_flags)
#    2ND_CLANG_TARGET_GLOBAL_CFLAGS += $(qcom_flags)
#    2ND_CLANG_TARGET_GLOBAL_CPPFLAGS += $(qcom_flags)

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
endif

# Set device-specific HALs into project pathmap
define set-device-specific-path
$(if $(USE_DEVICE_SPECIFIC_$(1)), \
    $(if $(DEVICE_SPECIFIC_$(1)_PATH), \
        $(eval path := $(DEVICE_SPECIFIC_$(1)_PATH)), \
        $(eval path := $(TARGET_DEVICE_DIR)/$(2))), \
    $(eval path := $(3))) \
$(call project-set-path,qcom-$(2),$(strip $(path)))
endef

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)

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

endif
