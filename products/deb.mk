# Check for target product
ifeq (omni_deb,$(TARGET_PRODUCT))

# include Omni common configuration
include vendor/omni/config/omni_common.mk

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/omni/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/omni/tools/addprojects.py $(PRODUCT_NAME))

PRODUCT_NAME := omni_deb

endif
