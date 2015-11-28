LOCAL_PATH:= $(call my-dir)

ifeq (TARGET_ARCH),arm64)
include $(CLEAR_VARS)
LOCAL_MODULE       := Chromium
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := APPS
LOCAL_SRC_FILES    := 64bit/ChromePublic.apk
LOCAL_MODULE_PATH  := $(TARGET_OUT_APPS)
include $(BUILD_PREBUILT)
else
include $(CLEAR_VARS)
LOCAL_MODULE       := Chromium
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := APPS
LOCAL_SRC_FILES    := 32bit/ChromePublic.apk
LOCAL_MODULE_PATH  := $(TARGET_OUT_APPS)
include $(BUILD_PREBUILT)
endif
