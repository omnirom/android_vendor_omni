#!/sbin/sh
#
# Backup and restore addon /system files
#

export C=/tmp/backupdir
export SYSDEV="$(readlink -nf "$2")"
export SYSFS="$3"
export V=13

DEBUG=0

export ADDOND_VERSION=3

# Partitions to mount for backup/restore in V3
export all_V3_partitions="vendor product system_ext"

get_script_version() {
  version=$(grep "^# ADDOND_VERSION=" $1 | cut -d= -f2)
  [ -z "$version" ] && version=1
  echo $version
}

# Preserve /system/addon.d in /tmp/addon.d
preserve_addon_d() {
  rm -rf /tmp/addon.d/
  mkdir -p /tmp/addon.d/
  cp -a $S/addon.d/* /tmp/addon.d/
  chmod 755 /tmp/addon.d/*.sh
}

# Restore /system/addon.d in /tmp/addon.d
restore_addon_d() {
  cp -a /tmp/addon.d/* $S/addon.d/
  rm -rf /tmp/addon.d/
}

# Restore only if backup has the expected major and minor version
check_prereq() {
  # If there is no build.prop file the partition is probably empty.
if [ ! -r $S/build.prop ]; then
  echo "Backup/restore is not possible. Partition is probably empty"
  return 1
fi
  if ( ! grep -q "^ro.build.version.release=$V.*" /tmp/build.prop ); then
    echo "Backup/restore is not possible. Incompatible ROM version: $V"
  return 2
  fi
  return 0
}

# Execute /system/addon.d/*.sh scripts with each $@ parameter
run_stages() {
  for script in $(find /tmp/addon.d/ -name '*.sh' |sort -n); do
    if [ $DEBUG -eq 1 ]; then
        echo run_stage $script $1
    fi
    v=$(get_script_version $script)
    if [ $v -ge 3 ]; then
      mount_extra $all_V3_partitions
    else
      umount_extra $all_V3_partitions
    fi

    for stage in $@; do
      if [ $v -ge 3 ]; then
        $script $stage
      else
        ADDOND_VERSION= $script $stage
      fi
    done
  done
}

#####################
### Mount helpers ###
#####################
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

  export S=$SYSMOUNT/system
}

mount_system() {
  mount -t $SYSFS $SYSDEV $SYSMOUNT -o rw,discard
}

unmount_system() {
  umount $SYSMOUNT
}

get_block_for_mount_point() {
  grep -v "^#" /etc/recovery.fstab | grep " $1 " | tail -n1 | tr -s ' ' | cut -d' ' -f1
}

find_block() {
  local name="$1"
  local fstab_entry=$(get_block_for_mount_point "/$name")
  # P-SAR hacks
  [ -z "$fstab_entry" ] && [ "$name" = "system" ] && fstab_entry=$(get_block_for_mount_point "/")
  [ -z "$fstab_entry" ] && [ "$name" = "system" ] && fstab_entry=$(get_block_for_mount_point "/system_root")

  local dev
  if [ "$DYNAMIC_PARTITIONS" = "true" ]; then
    if [ -n "$fstab_entry" ]; then
      dev="${BLK_PATH}/${fstab_entry}"
    else
      dev="${BLK_PATH}/${name}"
    fi
  else
    if [ -n "$fstab_entry" ]; then
      dev="$fstab_entry"
    else
      dev="${BLK_PATH}/${name}"
    fi
  fi

  if [ -b "$dev" ]; then
    echo "$dev"
  fi
}

determine_system_mount

DYNAMIC_PARTITIONS=$(getprop ro.boot.dynamic_partitions)
if [ "$DYNAMIC_PARTITIONS" = "true" ]; then
    BLK_PATH="/dev/block/mapper"
else
    BLK_PATH=$(dirname "$SYSDEV")
fi

mount_extra() {
  for partition in $@; do
    mnt_point="/$partition"
    mountpoint "$mnt_point" >/dev/null 2>&1 && continue
    [ -L "$SYSMOUNT/$partition" ] && continue

    blk_dev=$(find_block "$partition")
    if [ -e "$blk_dev" ]; then
      [ "$DYNAMIC_PARTITIONS" = "true" ] && blockdev --setrw "$blk_dev"
      mkdir -p "$mnt_point"
      mount -o rw "$blk_dev" "$mnt_point"
    fi
  done
}

umount_extra() {
  for partition in $@; do
    umount -l "/$partition" 2>/dev/null
  done
}

case "$1" in
  backup)
    # make sure we dont start with any leftovers
    rm -rf $C
    cp $S/bin/backuptool.functions /tmp
    cp $S/build.prop /tmp
    mount_system
    if check_prereq; then
      mkdir -p $C
      preserve_addon_d
      run_stages pre-backup backup post-backup
    fi
    unmount_system
  ;;
  restore)
    cp $S/bin/backuptool.functions /tmp
    mount_system
    if check_prereq; then
      run_stages pre-restore restore post-restore
      umount_extra $all_V3_partitions
      restore_addon_d
      rm -rf $C
      sync
    fi
    unmount_system
  ;;
  *)
    echo "Usage: $0 {backup|restore}"
    exit 1
esac

exit 0
