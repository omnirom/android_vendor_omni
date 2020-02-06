Empty "fake" static overlay for android
Can be used to bind mount and hide static overlays from /vendor/overlay
that a device dont want to see. Using /dev/null breaks idmap2 run
which also breaks valid static overlays that might be in /product/overlay

Usage:
Put into init.rc file for every overlay
    mount none /system/overlay/EmptyOverlay/EmptyOverlay.apk /vendor/overlay/FrameworksResCommon.apk bind

