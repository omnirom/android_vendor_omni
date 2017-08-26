LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(call all-java-files-under, src)
LOCAL_PACKAGE_NAME := GoldfishParts
LOCAL_CERTIFICATE := platform
LOCAL_AAPT_FLAGS := --auto-add-overlay
LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/res

package_resource_overlays := $(strip \
    $(wildcard $(foreach dir, $(PRODUCT_PACKAGE_OVERLAYS), \
      $(addprefix $(dir)/, packages/apps/GoldfishParts/res))) \
    $(wildcard $(foreach dir, $(DEVICE_PACKAGE_OVERLAYS), \
      $(addprefix $(dir)/, packages/apps/GoldfishParts/res))))

LOCAL_RESOURCE_DIR := $(package_resource_overlays) $(LOCAL_RESOURCE_DIR)

LOCAL_PROGUARD_ENABLED := disabled
LOCAL_DEX_PREOPT := false

include $(BUILD_PACKAGE)

include $(call all-makefiles-under,$(LOCAL_PATH))
