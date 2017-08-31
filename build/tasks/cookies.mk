OMNI_TARGET_PACKAGE := $(PRODUCT_OUT)/omni-$(ROM_VERSION).zip

.PHONY: otapackage cookies
otapackage: $(INTERNAL_OTA_PACKAGE_TARGET)
cookies: otapackage
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(OMNI_TARGET_PACKAGE)
	$(hide) $(MD5SUM) $(OMNI_TARGET_PACKAGE) | cut -d ' ' -f1 > $(OMNI_TARGET_PACKAGE).md5sum
	@echo -e "Package complete: $(OMNI_TARGET_PACKAGE)"
