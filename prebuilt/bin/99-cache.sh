#!/sbin/sh
#
# /system/addon.d/99-cache.sh
# During a firmware upgrade, this script deletes cache files
# in /data/system/package_cache/*
#

case "$1" in
  backup)
    # Stub
  ;;
  restore)
    if [ -d /data/system/package_cache/ ]; then
        rm /data/system/package_cache/*
    fi
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    # Stub
  ;;
esac
