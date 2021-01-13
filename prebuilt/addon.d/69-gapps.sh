#!/system/bin/sh
#
# ADDOND_VERSION=2
#
# /system/addon.d/69-gapps.sh
#
. /postinstall/tmp/backuptool.functions

if [ -z $backuptool_ab ]; then
  SYS=$S
  TMP=/tmp
else
  SYS=/postinstall/system
  TMP=/postinstall/tmp
fi


list_files() {
cat <<EOF
app/GoogleCalendarSyncAdapter/GoogleCalendarSyncAdapter.apk
app/GoogleContactsSyncAdapter/GoogleContactsSyncAdapter.apk
app/GoogleExtShared/GoogleExtShared.apk
app/GoogleTTS/GoogleTTS.apk
app/MarkupGoogle/MarkupGoogle.apk
app/SoundPickerPrebuilt/SoundPickerPrebuilt.apk
etc/default-permissions/default-permissions.xml
etc/default-permissions/opengapps-permissions-q.xml
etc/g.prop
etc/permissions/com.google.android.dialer.support.xml
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.android.media.effects.xml
etc/permissions/privapp-permissions-google.xml
etc/permissions/split-permissions-google.xml
etc/preferred-apps/google.xml
etc/sysconfig/dialer_experience.xml
etc/sysconfig/google-hiddenapi-package-whitelist.xml
etc/sysconfig/google.xml
etc/sysconfig/google_build.xml
etc/sysconfig/google_exclusives_enable.xml
framework/com.google.android.dialer.support.jar
framework/com.google.android.maps.jar
framework/com.google.android.media.effects.jar
lib/libsketchology_native.so
lib64/libjni_latinimegoogle.so
lib64/libsketchology_native.so
priv-app/CarrierSetup/CarrierSetup.apk
priv-app/ConfigUpdater/ConfigUpdater.apk
priv-app/GoogleBackupTransport/GoogleBackupTransport.apk
priv-app/GoogleExtServices/GoogleExtServices.apk
priv-app/GoogleFeedback/GoogleFeedback.apk
priv-app/GoogleOneTimeInitializer/GoogleOneTimeInitializer.apk
priv-app/GooglePackageInstaller/GooglePackageInstaller.apk
priv-app/GooglePartnerSetup/GooglePartnerSetup.apk
priv-app/GoogleRestore/GoogleRestore.apk
priv-app/GoogleServicesFramework/GoogleServicesFramework.apk
priv-app/Phonesky/Phonesky.apk
priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk
priv-app/SetupWizard/SetupWizard.apk
priv-app/Turbo/Turbo.apk
priv-app/Velvet/Velvet.apk
priv-app/WellbeingPrebuilt/WellbeingPrebuilt.apk
product/overlay/WellbeingOverlay.apk
usr/srec/en-US/APP_NAME.fst
usr/srec/en-US/APP_NAME.syms
usr/srec/en-US/CLG.prewalk.fst
usr/srec/en-US/CONTACT_NAME.fst
usr/srec/en-US/CONTACT_NAME.syms
usr/srec/en-US/SONG_NAME.fst
usr/srec/en-US/SONG_NAME.syms
usr/srec/en-US/am_phonemes.syms
usr/srec/en-US/app_bias.fst
usr/srec/en-US/c_fst
usr/srec/en-US/commands.abnf
usr/srec/en-US/compile_grammar.config
usr/srec/en-US/config.pumpkin
usr/srec/en-US/confirmation_bias.fst
usr/srec/en-US/contacts.abnf
usr/srec/en-US/contacts_bias.fst
usr/srec/en-US/contacts_disambig.fst
usr/srec/en-US/dict
usr/srec/en-US/dictation.config
usr/srec/en-US/dnn
usr/srec/en-US/embedded_class_denorm.mfar
usr/srec/en-US/embedded_normalizer.mfar
usr/srec/en-US/endpointer_dictation.config
usr/srec/en-US/endpointer_model
usr/srec/en-US/endpointer_model.mmap
usr/srec/en-US/endpointer_voicesearch.config
usr/srec/en-US/ep_portable_mean_stddev
usr/srec/en-US/ep_portable_model.uint8.mmap
usr/srec/en-US/g2p.data
usr/srec/en-US/g2p_fst
usr/srec/en-US/g2p_graphemes.syms
usr/srec/en-US/g2p_phonemes.syms
usr/srec/en-US/grammar.config
usr/srec/en-US/hmm_symbols
usr/srec/en-US/hmmlist
usr/srec/en-US/input_mean_std_dev
usr/srec/en-US/lexicon.U.fst
usr/srec/en-US/lstm_model.uint8.data
usr/srec/en-US/magic_mic.config
usr/srec/en-US/media_bias.fst
usr/srec/en-US/metadata
usr/srec/en-US/monastery_config.pumpkin
usr/srec/en-US/norm_fst
usr/srec/en-US/offensive_word_normalizer.mfar
usr/srec/en-US/offline_action_data.pb
usr/srec/en-US/phonelist
usr/srec/en-US/portable_lstm
usr/srec/en-US/portable_meanstddev
usr/srec/en-US/pumpkin.mmap
usr/srec/en-US/read_items_bias.fst
usr/srec/en-US/rescoring.fst.compact
usr/srec/en-US/semantics.pumpkin
usr/srec/en-US/skip_items_bias.fst
usr/srec/en-US/time_bias.fst
usr/srec/en-US/transform.mfar
usr/srec/en-US/voice_actions.config
usr/srec/en-US/voice_actions_compiler.config
usr/srec/en-US/word_confidence_classifier
usr/srec/en-US/wordlist.syms
EOF
}

mount_generic() {
  local device_abpartition=$(getprop ro.build.ab_update)
  local partitions="$*"
  if [ -z "$device_abpartition" ]; then
    # We're on an A only device
    local partition
    for partition in $partitions; do
      if [ "$(getprop ro.boot.dynamic_partitions)" = "true" ]; then
        mount -o ro -t auto /dev/block/mapper/"$partition" /"$partition" 2> /dev/null
        blockdev --setrw /dev/block/mapper/"$partition" 2> /dev/null
        mount -o rw,remount -t auto /dev/block/mapper/"$partition" /"$partition" 2> /dev/null
      else
        mount -o ro -t auto /"$partition" 2> /dev/null
        mount -o rw,remount -t auto /"$partition" 2> /dev/null
      fi
    done
  fi
}

# Backup/Restore using /sdcard if the installed GApps size plus a buffer for other addon.d backups (204800=200MB) is larger than /tmp
installed_gapps_size_kb=$(grep "^installed_gapps_size_kb" $TMP/gapps.prop | cut -d '=' -f 2)
if [ ! "$installed_gapps_size_kb" ]; then
  installed_gapps_size_kb="$(cd $SYS; size=0; for n in $(du -ak $(list_files) | cut -f 1); do size=$((size+n)); done; echo "$size")"
  echo "installed_gapps_size_kb=$installed_gapps_size_kb" >> $TMP/gapps.prop
fi

free_tmp_size_kb=$(grep "^free_tmp_size_kb" $TMP/gapps.prop | cut -d '=' -f 2)
if [ ! "$free_tmp_size_kb" ]; then
  free_tmp_size_kb="$(echo $(df -k $TMP | tail -n 1) | cut -d ' ' -f 4)"
  echo "free_tmp_size_kb=$free_tmp_size_kb" >> $TMP/gapps.prop
fi

buffer_size_kb=204800
if [ $((installed_gapps_size_kb + buffer_size_kb)) -ge "$free_tmp_size_kb" ]; then
  C=/sdcard/tmp-gapps
fi

# Get ROM SDK from installed GApps
rom_build_sdk=$(grep "^rom_build_sdk" $TMP/gapps.prop | cut -d '=' -f 2)
if [ ! "$rom_build_sdk" ]; then
  rom_build_sdk="$(cd $SYS; grep "^ro.addon.sdk" etc/g.prop | cut -d '=' -f 2)"
  echo "rom_build_sdk=$rom_build_sdk" >> $TMP/gapps.prop
fi

case "$1" in
  backup)
    list_files | while read -r FILE DUMMY; do
      backup_file "$S"/"$FILE"
    done

    umount /product /vendor 2> /dev/null
  ;;
  restore)
    list_files | while read -r FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file "$S"/"$FILE" "$R"
    done
  ;;
  pre-backup)
    mount_generic product vendor
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    mount_generic product vendor

    # Remove Stock/AOSP apps (from GApps Installer)
    rm -rf $SYS/priv-app/ExtServices
    rm -rf $SYS/product/priv-app/ExtServices
    rm -rf $SYS/app/ExtShared
    rm -rf $SYS/product/app/ExtShared
    rm -rf $SYS/app/PackageInstaller
    rm -rf $SYS/priv-app/PackageInstaller
    rm -rf $SYS/priv-app/packageinstaller
    rm -rf $SYS/product/app/PackageInstaller
    rm -rf $SYS/product/priv-app/PackageInstaller
    rm -rf $SYS/product/priv-app/packageinstaller
    rm -rf $SYS/app/Provision
    rm -rf $SYS/priv-app/Provision
    rm -rf $SYS/product/app/Provision
    rm -rf $SYS/product/priv-app/Provision

    # Remove 'other' apps (per installer.data)
    rm -rf $SYS/app/BookmarkProvider
    rm -rf $SYS/app/BooksStub
    rm -rf $SYS/app/CalendarGoogle
    rm -rf $SYS/app/CloudPrint
    rm -rf $SYS/app/DeskClockGoogle
    rm -rf $SYS/app/EditorsDocsStub
    rm -rf $SYS/app/EditorsSheetsStub
    rm -rf $SYS/app/EditorsSlidesStub
    rm -rf $SYS/app/Gmail
    rm -rf $SYS/app/Gmail2
    rm -rf $SYS/app/GoogleCalendar
    rm -rf $SYS/app/GoogleCloudPrint
    rm -rf $SYS/app/GoogleHangouts
    rm -rf $SYS/app/GoogleKeep
    rm -rf $SYS/app/GoogleLatinIme
    rm -rf $SYS/app/Keep
    rm -rf $SYS/app/NewsstandStub
    rm -rf $SYS/app/PartnerBookmarksProvider
    rm -rf $SYS/app/PrebuiltBugleStub
    rm -rf $SYS/app/PrebuiltKeepStub
    rm -rf $SYS/app/QuickSearchBox
    rm -rf $SYS/app/Vending
    rm -rf $SYS/priv-app/GmsCore
    rm -rf $SYS/priv-app/GmsCore_update
    rm -rf $SYS/priv-app/GoogleHangouts
    rm -rf $SYS/priv-app/GoogleNow
    rm -rf $SYS/priv-app/GoogleSearch
    rm -rf $SYS/priv-app/OneTimeInitializer
    rm -rf $SYS/priv-app/QuickSearchBox
    rm -rf $SYS/priv-app/Velvet_update
    rm -rf $SYS/priv-app/Vending
    rm -rf $SYS/product/app/BookmarkProvider
    rm -rf $SYS/product/app/BooksStub
    rm -rf $SYS/product/app/CalendarGoogle
    rm -rf $SYS/product/app/CloudPrint
    rm -rf $SYS/product/app/DeskClockGoogle
    rm -rf $SYS/product/app/EditorsDocsStub
    rm -rf $SYS/product/app/EditorsSheetsStub
    rm -rf $SYS/product/app/EditorsSlidesStub
    rm -rf $SYS/product/app/Gmail
    rm -rf $SYS/product/app/Gmail2
    rm -rf $SYS/product/app/GoogleCalendar
    rm -rf $SYS/product/app/GoogleCloudPrint
    rm -rf $SYS/product/app/GoogleHangouts
    rm -rf $SYS/product/app/GoogleKeep
    rm -rf $SYS/product/app/GoogleLatinIme
    rm -rf $SYS/product/app/Keep
    rm -rf $SYS/product/app/NewsstandStub
    rm -rf $SYS/product/app/PartnerBookmarksProvider
    rm -rf $SYS/product/app/PrebuiltBugleStub
    rm -rf $SYS/product/app/PrebuiltKeepStub
    rm -rf $SYS/product/app/QuickSearchBox
    rm -rf $SYS/product/app/Vending
    rm -rf $SYS/product/priv-app/GmsCore
    rm -rf $SYS/product/priv-app/GmsCore_update
    rm -rf $SYS/product/priv-app/GoogleHangouts
    rm -rf $SYS/product/priv-app/GoogleNow
    rm -rf $SYS/product/priv-app/GoogleSearch
    rm -rf $SYS/product/priv-app/OneTimeInitializer
    rm -rf $SYS/product/priv-app/QuickSearchBox
    rm -rf $SYS/product/priv-app/Velvet_update
    rm -rf $SYS/product/priv-app/Vending

    # Remove 'priv-app' apps from 'app' (per installer.data)
    rm -rf $SYS/app/CanvasPackageInstaller
    rm -rf $SYS/app/ConfigUpdater
    rm -rf $SYS/app/GoogleBackupTransport
    rm -rf $SYS/app/GoogleFeedback
    rm -rf $SYS/app/GoogleLoginService
    rm -rf $SYS/app/GoogleOneTimeInitializer
    rm -rf $SYS/app/GooglePartnerSetup
    rm -rf $SYS/app/GoogleServicesFramework
    rm -rf $SYS/app/OneTimeInitializer
    rm -rf $SYS/app/Phonesky
    rm -rf $SYS/app/PrebuiltGmsCore
    rm -rf $SYS/app/SetupWizard
    rm -rf $SYS/app/Velvet
    rm -rf $SYS/product/app/CanvasPackageInstaller
    rm -rf $SYS/product/app/ConfigUpdater
    rm -rf $SYS/product/app/GoogleBackupTransport
    rm -rf $SYS/product/app/GoogleFeedback
    rm -rf $SYS/product/app/GoogleLoginService
    rm -rf $SYS/product/app/GoogleOneTimeInitializer
    rm -rf $SYS/product/app/GooglePartnerSetup
    rm -rf $SYS/product/app/GoogleServicesFramework
    rm -rf $SYS/product/app/OneTimeInitializer
    rm -rf $SYS/product/app/Phonesky
    rm -rf $SYS/product/app/PrebuiltGmsCore
    rm -rf $SYS/product/app/SetupWizard
    rm -rf $SYS/product/app/Velvet

    # Remove 'required' apps (per installer.data)
    rm -rf $SYS/app/LatinIME/lib//libjni_keyboarddecoder.so
    rm -rf $SYS/app/LatinIME/lib//libjni_latinimegoogle.so
    rm -rf $SYS/lib/libjni_keyboarddecoder.so
    rm -rf $SYS/lib/libjni_latinimegoogle.so
    rm -rf $SYS/lib64/libjni_keyboarddecoder.so
    rm -rf $SYS/lib64/libjni_latinimegoogle.so
    rm -rf $SYS/product/app/LatinIME/lib//libjni_keyboarddecoder.so
    rm -rf $SYS/product/app/LatinIME/lib//libjni_latinimegoogle.so
    rm -rf $SYS/product/lib/libjni_keyboarddecoder.so
    rm -rf $SYS/product/lib/libjni_latinimegoogle.so
    rm -rf $SYS/product/lib64/libjni_keyboarddecoder.so
    rm -rf $SYS/product/lib64/libjni_latinimegoogle.so

    # Remove 'user requested' apps (from gapps-config)

  ;;
  post-restore)
    # Recreate required symlinks (from GApps Installer)
    install -d "$SYS/app/MarkupGoogle/lib/arm64"
    ln -sfn "$SYS/lib64/libsketchology_native.so" "$SYS/app/MarkupGoogle/lib/arm64/libsketchology_native.so"
    install -d "$SYS/app/LatinIME/lib64/arm64"
    ln -sfn "$SYS/product/lib64/libjni_latinimegoogle.so" "$SYS/product/app/LatinIME/lib64/arm64/libjni_latinimegoogle.so"
    ln -sfn "$SYS/product/lib64/libjni_keyboarddecoder.so" "$SYS/product/app/LatinIME/lib64/arm64/libjni_keyboarddecoder.so"
    ln -sfn "$SYS/lib64/libjni_latinimegoogle.so" "$SYS/app/LatinIME/lib64/arm64/libjni_latinimegoogle.so"
    ln -sfn "$SYS/lib64/libjni_keyboarddecoder.so" "$SYS/app/LatinIME/lib64/arm64/libjni_keyboarddecoder.so"

    # Apply build.prop changes (from GApps Installer)
    sed -i "s/ro.error.receiver.system.apps=.*/ro.error.receiver.system.apps=com.google.android.gms/g" $SYS/build.prop

    # Re-pre-ODEX APKs (from GApps Installer)

    # Remove any empty folders we may have created during the removal process
    for i in $SYS/app $SYS/priv-app $SYS/vendor/pittpatt $SYS/usr/srec; do
      if [ -d $i ]; then
        find $i -type d -exec rmdir -p '{}' \+ 2>/dev/null
      fi
    done

    # Fix ownership/permissions and clean up after backup and restore from /sdcard
    find $SYS/vendor/pittpatt -type d -exec chown 0:2000 '{}' \; 2>/dev/null # Change pittpatt folders to root:shell per Google Factory Settings
    for i in $(list_files); do
      chown root:root "$SYS/$i"
      chmod 644 "$SYS/$i"
      chmod 755 "$(dirname "$SYS/$i")" "$(dirname "$SYS/$i")/../"
      case $i in
        */overlay/*) chcon -h u:object_r:vendor_overlay_file:s0 "$SYS/$i";;
      esac
    done

    umount /product /vendor 2> /dev/null

    if [ "$rom_build_sdk" -ge "26" ]; then # Android 8.0+ uses 0600 for its permission on build.prop
      chmod 600 "$SYS/build.prop"
    fi
    rm -rf /sdcard/tmp-gapps
  ;;
esac
