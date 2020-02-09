#!/sbin/sh
#
# Backup and restore addon /system files
#

export C=/tmp/backupdir
export SYSDEV="$(readlink -nf "$2")"
export SYSFS="$3"
export V=13

DEBUG=0

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
  if [ ! -f /tmp/build.prop ]; then
    # this will block any backups made before 8 cause file was not copied before
    echo "Not restoring files from incompatible version: $V"
    exit 127
  fi
  if ( ! grep -q "^ro.build.version.release=$V.*" /tmp/build.prop ); then
    echo "Not restoring files from incompatible version: $V"
    exit 127
  fi
}

check_blacklist() {
  if [ -f $S/addon.d/blacklist ];then
    ## Discard any known bad backup scripts
    for f in /$1/addon.d/*sh; do
      s=$(md5sum $f | awk {'print $1'})
      grep -q $s $S/addon.d/blacklist && rm -f $f
    done
  fi
}

# Execute /system/addon.d/*.sh scripts with $1 parameter
run_stage() {
  for script in $(find /tmp/addon.d/ -name '*.sh' |sort -n); do
    if [ $DEBUG -eq 1 ]; then
        echo run_stage $script $1
    fi
    $script $1
  done
}

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

determine_system_mount

case "$1" in
  backup)
    # make sure we dont start with any leftovers
    rm -rf $C
    cp $S/bin/backuptool.functions /tmp
    cp $S/build.prop /tmp
    mount_system
    mkdir -p $C
    #check_prereq
    check_blacklist $S
    preserve_addon_d
    run_stage pre-backup
    run_stage backup
    run_stage post-backup
    unmount_system
  ;;
  restore)
    cp $S/bin/backuptool.functions /tmp
    mount_system
    check_prereq
    check_blacklist /tmp
    run_stage pre-restore
    run_stage restore
    run_stage post-restore
    restore_addon_d
    rm -rf $C
    sync
    unmount_system
  ;;
  *)
    echo "Usage: $0 {backup|restore}"
    exit 1
esac

exit 0
