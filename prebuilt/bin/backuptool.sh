#!/sbin/sh
#
# Backup and restore addon /system files
#

export C=/tmp/backupdir
export S=$2
export V=9

export ADDOND_VERSION=1

DEBUG=0

# Preserve /system/addon.d in /tmp/addon.d
preserve_addon_d() {
  if [ -d $S/addon.d/ ]; then
    mkdir -p /tmp/addon.d/
    cp -a $S/addon.d/* /tmp/addon.d/
    # Discard any scripts that aren't at least our version level
    for f in /postinstall/tmp/addon.d/*sh; do
      SCRIPT_VERSION=$(grep "^# ADDOND_VERSION=" $f | cut -d= -f2)
      if [ -z "$SCRIPT_VERSION" ]; then
        SCRIPT_VERSION=1
      fi
      if [ $SCRIPT_VERSION -lt $ADDOND_VERSION ]; then
        rm $f
      fi
    done
    chmod 755 /tmp/addon.d/*.sh
  fi
}

# Restore /system/addon.d in /tmp/addon.d
restore_addon_d() {
  if [ -d /tmp/addon.d/ ]; then
    mkdir -p $S/addon.d/
    cp -a /tmp/addon.d/* $S/addon.d/
    rm -rf /tmp/addon.d/
  fi
}

# Restore only if backup has the expected major and minor version
check_prereq() {
  if [ ! -f $S/build.prop ]; then
    # this will block any backups made before 8 cause file was not copied before
    echo "Not restoring files from incompatible version: $V"
    exit 127
  fi
  if ( ! grep -q "^ro.build.version.release=$V.*" $S/build.prop ); then
    echo "Not restoring files from incompatible version: $V"
    exit 127
  fi
}

check_blacklist() {
  if [ -f $S/addon.d/blacklist -a -d /$1/addon.d/ ]; then
    ## Discard any known bad backup scripts
    cd /$1/addon.d/
    for f in *sh; do
      [ -f $f ] || continue
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

case "$1" in
  backup)
    # make sure we dont start with any leftovers
    rm -rf $C
    cp /system/bin/backuptool.functions /tmp
    cp /system/build.prop /tmp
    mkdir -p $C
    #check_prereq
    check_blacklist system
    preserve_addon_d
    run_stage pre-backup
    run_stage backup
    run_stage post-backup
  ;;
  restore)
    cp /system/bin/backuptool.functions /tmp
    check_prereq
    check_blacklist tmp
    run_stage pre-restore
    run_stage restore
    run_stage post-restore
    restore_addon_d
    rm -rf $C
    sync
  ;;
  *)
    echo "Usage: $0 {backup|restore}"
    exit 1
esac

exit 0
