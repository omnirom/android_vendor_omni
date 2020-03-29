#!/system/bin/sh
#
# LineageOS A/B OTA Postinstall Script
#

log -t "update_engine" "backuptool_postinstall.sh backup"

/postinstall/system/bin/backuptool_ab.sh backup

log -t "update_engine" "backuptool_postinstall.sh restore"

/postinstall/system/bin/backuptool_ab.sh restore

sync

exit 0
