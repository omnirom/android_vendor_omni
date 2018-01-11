LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_PACKAGE_NAME := LeftySettingsTheme
LOCAL_RRO_THEME := LeftySettingsTheme
LOCAL_CERTIFICATE := platform
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(call all-subdir-java-files)
LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/res

include frameworks/base/packages/SettingsLib/common.mk

include $(BUILD_RRO_PACKAGE)
