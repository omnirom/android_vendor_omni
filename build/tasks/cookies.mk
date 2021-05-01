
OMNI_TARGET_PACKAGE := $(PRODUCT_OUT)/omni-$(ROM_VERSION).zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: cookies
cookies: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(OMNI_TARGET_PACKAGE)
	$(hide) $(SHA256) $(OMNI_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(OMNI_TARGET_PACKAGE).sha256sum
	@echo -e "Package complete: $(OMNI_TARGET_PACKAGE)" >&2
