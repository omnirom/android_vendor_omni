ifneq ($(TARGET_NO_CHARGER),true)
LOCAL_PATH := $(call my-dir)

ifneq (,$(PRODUCT_AAPT_PREF_CONFIG))
# If PRODUCT_AAPT_PREF_CONFIG includes a dpi bucket, then use that value.
charger_density := $(word 1,$(PRODUCT_AAPT_PREF_CONFIG))
else
# Otherwise, use the default medium density.
charger_density := 480dpi
endif

include $(CLEAR_VARS)
LOCAL_MODULE := font_charger.png
LOCAL_SRC_FILES := fonts/$(charger_density)/font_charger.png
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_PRODUCT_MODULE := true
LOCAL_MODULE_RELATIVE_PATH := res/images
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := animation.txt
LOCAL_SRC_FILES := anim/animation.txt
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_PRODUCT_MODULE := true
LOCAL_MODULE_RELATIVE_PATH := res/values/charger
include $(BUILD_PREBUILT)

define _add-omni-charger-image
include $$(CLEAR_VARS)
LOCAL_MODULE := omni_core_charger_$(notdir $(1))
LOCAL_MODULE_STEM := $(notdir $(1))
_img_modules += $$(LOCAL_MODULE)
LOCAL_SRC_FILES := $1
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_PRODUCT_MODULE := true
LOCAL_MODULE_RELATIVE_PATH := res/images/charger
include $$(BUILD_PREBUILT)
endef

_img_modules :=
_images :=
$(foreach _img, $(call find-subdir-subdir-files, "images/$(charger_density)", "*.png"), \
  $(eval $(call _add-omni-charger-image,$(_img))))

include $(CLEAR_VARS)
LOCAL_MODULE := omni_charger_res_images
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_OWNER := omni
LOCAL_REQUIRED_MODULES := $(_img_modules)
include $(BUILD_PHONY_PACKAGE)

_add-charger-image :=
_img_modules :=
endif
