#!/system/bin/sh
#
# ADDOND_VERSION=2
#
# /system/addon.d/30-gapps.sh
#
. /postinstall/tmp/backuptool.functions

list_files() {
cat <<EOF
app/FaceLock/FaceLock.apk
app/GoogleCalendarSyncAdapter/GoogleCalendarSyncAdapter.apk
app/GoogleContactsSyncAdapter/GoogleContactsSyncAdapter.apk
app/GoogleExtShared/GoogleExtShared.apk
app/GoogleTTS/GoogleTTS.apk
etc/default-permissions/default-permissions.xml
etc/default-permissions/opengapps-permissions.xml
etc/g.prop
etc/permissions/com.google.android.dialer.support.xml
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.android.media.effects.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/permissions/privapp-permissions-google.xml
etc/preferred-apps/google.xml
etc/sysconfig/dialer_experience.xml
etc/sysconfig/framework-sysconfig.xml
etc/sysconfig/google.xml
etc/sysconfig/google_build.xml
etc/sysconfig/whitelist_com.android.omadm.service.xml
framework/com.google.android.dialer.support.jar
framework/com.google.android.maps.jar
framework/com.google.android.media.effects.jar
framework/com.google.widevine.software.drm.jar
lib/libfilterpack_facedetect.so
lib/libfrsdk.so
lib64/libfacenet.so
lib64/libfilterpack_facedetect.so
lib64/libfrsdk.so
lib64/libjni_latinimegoogle.so
priv-app/ConfigUpdater/ConfigUpdater.apk
priv-app/GmsCoreSetupPrebuilt/GmsCoreSetupPrebuilt.apk
priv-app/GoogleBackupTransport/GoogleBackupTransport.apk
priv-app/GoogleExtServices/GoogleExtServices.apk
priv-app/GoogleFeedback/GoogleFeedback.apk
priv-app/GoogleOneTimeInitializer/GoogleOneTimeInitializer.apk
priv-app/GooglePackageInstaller/GooglePackageInstaller.apk
priv-app/GooglePartnerSetup/GooglePartnerSetup.apk
priv-app/GoogleServicesFramework/GoogleServicesFramework.apk
priv-app/Phonesky/Phonesky.apk
priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk
priv-app/SetupWizard/SetupWizard.apk
priv-app/Turbo/Turbo.apk
priv-app/Velvet/Velvet.apk
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
addon.d/69-gapps.sh
addon.d/addond_tail
addon.d/addond_head
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
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
    if [ -d "/postinstall" ]; then
      P="/postinstall/system"
    else
      P="/system"
    fi

    for i in $(list_files); do
      chown root:root "$P/$i"
      chmod 644 "$P/$i"
      chmod 755 "$(dirname "$P/$i")"
    done

    # Recreate required symlinks (from GApps Installer)
    install -d "/postinstall/system/app/FaceLock/lib/arm64"
    ln -sfn "/postinstall/system/lib64/libfacenet.so" "/postinstall/system/system/app/FaceLock/lib/arm64/libfacenet.so"
    install -d "/postinstall/system/app/LatinIME/lib64/arm64"
    ln -sfn "/postinstall/system/lib64/libjni_latinimegoogle.so" "/postinstall/system/app/LatinIME/lib64/arm64/libjni_latinimegoogle.so"
    ln -sfn "/postinstall/system/lib64/libjni_keyboarddecoder.so" "/postinstall/system/app/LatinIME/lib64/arm64/libjni_keyboarddecoder.so"

    # Apply build.prop changes (from GApps Installer)
    sed -i "s/ro.error.receiver.system.apps=.*/ro.error.receiver.system.apps=com.google.android.gms/g" /postinstall/system/build.prop

    done;
  ;;
esac
