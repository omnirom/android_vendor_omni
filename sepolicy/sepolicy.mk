#
# This policy configuration will be used by all products that
# inherit from AnimeROM
#

BOARD_SEPOLICY_DIRS += \
    vendor/Anime/sepolicy

BOARD_SEPOLICY_UNION += \
   mac_permissions.xml \
   file_contexts \
   file.te \
   genfs_contexts \
   installd.te \
   vold.te
