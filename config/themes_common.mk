# T-Mobile theme engine
PRODUCT_PACKAGES += \
       ThemeManager \
       ThemeChooser \
       com.tmobile.themes

PRODUCT_COPY_FILES += \
       vendor/omni/prebuilt/etc/permissions/com.tmobile.software.themes.xml:system/etc/permissions/com.tmobile.software.themes.xml \
       vendor/omni/prebuilt/etc/permissions/org.cyanogenmod.theme.xml:system/etc/permissions/org.cyanogenmod.theme.xml
