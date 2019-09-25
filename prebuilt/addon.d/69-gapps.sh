#!/sbin/sh
# 
# ADDOND_VERSION=2
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

if [ -z $backuptool_ab ]; then
  SYS=$S
  TMP=/tmp
else
  SYS=/postinstall/system
  TMP=/postinstall/tmp
fi

list_files() {
cat <<EOF
app/FaceLock/FaceLock.apk
app/GoogleCalendarSyncAdapter/GoogleCalendarSyncAdapter.apk
app/GoogleContactsSyncAdapter/GoogleContactsSyncAdapter.apk
app/GoogleExtShared/GoogleExtShared.apk
app/GoogleTTS/GoogleTTS.apk
app/MarkupGoogle/MarkupGoogle.apk
app/SoundPickerPrebuilt/SoundPickerPrebuilt.apk
etc/default-permissions/default-permissions.xml
etc/default-permissions/opengapps-permissions.xml
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
lib/libfilterpack_facedetect.so
lib/libfrsdk.so
lib/libsketchology_native.so
lib64/libfacenet.so
lib64/libfilterpack_facedetect.so
lib64/libfrsdk.so
lib64/libjni_latinimegoogle.so
lib64/libsketchology_native.so
priv-app/CarrierSetup/CarrierSetup.apk
priv-app/ConfigUpdater/ConfigUpdater.apk
priv-app/GmsCoreSetupPrebuilt/GmsCoreSetupPrebuilt.apk
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

case "$1" in
  backup)
    list_files | while read -r FILE DUMMY; do
      backup_file "$S"/"$FILE"
    done
  ;;
  restore)
    list_files | while read -r FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file "$S"/"$FILE" "$R"
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Remove Stock/AOSP apps (from GApps Installer)
    rm -rf $SYS/priv-app/ExtServices
    rm -rf $SYS/app/ExtShared
    rm -rf $SYS/app/PackageInstaller
    rm -rf $SYS/priv-app/PackageInstaller
    rm -rf $SYS/priv-app/packageinstaller
    rm -rf $SYS/app/Provision
    rm -rf $SYS/priv-app/Provision

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

    # Remove 'required' apps (per installer.data)
    rm -rf $SYS/app/LatinIME/lib//libjni_keyboarddecoder.so
    rm -rf $SYS/app/LatinIME/lib//libjni_latinimegoogle.so
    rm -rf $SYS/lib/libjni_keyboarddecoder.so
    rm -rf $SYS/lib/libjni_latinimegoogle.so
    rm -rf $SYS/lib64/libjni_keyboarddecoder.so
    rm -rf $SYS/lib64/libjni_latinimegoogle.so

    # Remove 'user requested' apps (from gapps-config)

  ;;
  post-restore)
    # Recreate required symlinks (from GApps Installer)
    install -d "/system/app/MarkupGoogle/lib/arm64"
    ln -sfn "/system/lib64/libsketchology_native.so" "/system/app/MarkupGoogle/lib/arm64/libsketchology_native.so"
    install -d "$SYS/app/FaceLock/lib/arm64"
    ln -sfn "$SYS/lib64/libfacenet.so" "$SYS/app/FaceLock/lib/arm64/libfacenet.so"
    install -d "$SYS/app/LatinIME/lib64/arm64"
    ln -sfn "$SYS/lib64/libjni_latinimegoogle.so" "$SYS/app/LatinIME/lib64/arm64/libjni_latinimegoogle.so"
    ln -sfn "$SYS/lib64/libjni_keyboarddecoder.so" "$SYS/app/LatinIME/lib64/arm64/libjni_keyboarddecoder.so"

    # Apply build.prop changes (from GApps Installer)
    sed -i "s/ro.error.receiver.system.apps=.*/ro.error.receiver.system.apps=com.google.android.gms/g" $SYS/build.prop

    # Re-pre-ODEX APKs (from GApps Installer)

    # Remove any empty folders we may have created during the removal process
    for i in $SYS/app $SYS/priv-app $SYS/vendor/pittpatt $SYS/usr/srec; do
      if [ -d $i ]; then
        find $i -type d -exec rmdir -p '{}' \+ 2>/dev/null;
      fi
    done;
    # Fix ownership/permissions and clean up after backup and restore from /sdcard
    find $SYS/vendor/pittpatt -type d -exec chown 0:2000 '{}' \; # Change pittpatt folders to root:shell per Google Factory Settings
    for i in $(list_files); do
      chown root:root "$SYS/$i"
      chmod 644 "$SYS/$i"
      chmod 755 "$(dirname "$SYS/$i")"
        if [ "$API" -ge "26" ]; then # Android 8.0+ uses 0600 for its permission on build.prop
          chmod 600 "$SYS/build.prop"
        fi
    done
    rm -rf /sdcard/tmp-gapps
  ;;
esac