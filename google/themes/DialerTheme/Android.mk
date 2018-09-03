LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_PACKAGE_NAME := DialerTheme
LOCAL_RRO_THEME := DialerTheme
LOCAL_CERTIFICATE := platform
LOCAL_MODULE_TAGS := optional
LOCAL_SDK_VERSION := current
LOCAL_SRC_FILES := $(call all-subdir-java-files)
LOCAL_USE_AAPT2 := true
LOCAL_AAPT_FLAGS += \
        --auto-add-overlay \

RES_DIRS := $(call all-subdir-named-dirs,res,.)
LOCAL_RESOURCE_DIR := $(addprefix $(LOCAL_PATH)/, $(RES_DIRS))
 

include $(BUILD_RRO_PACKAGE)
