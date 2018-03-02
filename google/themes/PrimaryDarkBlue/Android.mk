LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_PACKAGE_NAME := PrimaryDarkBlue
LOCAL_RRO_THEME := PrimaryDarkBlue
LOCAL_CERTIFICATE := platform
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(call all-subdir-java-files)
LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/res

include $(BUILD_RRO_PACKAGE)
