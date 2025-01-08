
MD5 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/md5sum

define get-omni-target-package
  $(PRODUCT_OUT)/omni-$$(sed -n -e'/ro.omni.version=/s/^.*=//p' $(PRODUCT_OUT)/system/build.prop).zip
endef

.PHONY: cookies
cookies: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(call get-omni-target-package)
	$(hide) $(MD5) $(OMNI_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(call get-omni-target-package).md5sum
	@echo -e "Package complete: $(OMNI_TARGET_PACKAGE)" >&2
