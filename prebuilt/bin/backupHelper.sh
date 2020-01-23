#!/sbin/sh
#
# Addon backuptool helper
#
SYSDEV="$(readlink -nf "$2")"

determine_system_mount() {
  if grep -q -e"^$SYSDEV" /proc/mounts; then
    umount $(grep -e"^$SYSDEV" /proc/mounts | cut -d" " -f2)
  fi

  if [ -d /mnt/system ]; then
    SYSMOUNT="/mnt/system"
  elif [ -d /system_root ]; then
    SYSMOUNT="/system_root"
  else
    SYSMOUNT="/system"
  fi

  SYSDIR=$SYSMOUNT/system
}

mount_system() {
  mount -t $SYSDEV $SYSMOUNT -o rw,discard
}

unmount_system() {
  umount $SYSMOUNT
}

determine_system_mount
mount_system
$SYSDIR/bin/backuptool.sh "$1" "$SYSDIR"
unmount_system

