
OMNI_TARGET_PACKAGE := $(PRODUCT_OUT)/omni-$(ROM_VERSION).zip

MD5 := prebuilts/build-tools/path/$(HOST_OS)-x86/md5sum

.PHONY: cookies
cookies: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(OMNI_TARGET_PACKAGE)
	$(hide) $(MD5) $(OMNI_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(OMNI_TARGET_PACKAGE).md5sum
	@echo -e "Package complete: $(OMNI_TARGET_PACKAGE)" >&2
