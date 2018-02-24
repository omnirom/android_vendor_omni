function __print_omni_functions_help() {
cat <<EOF
Additional OmniROM functions:
- breakfast:       Setup the build environment, but only list
                   devices we support.
- brunch:          Sets up build environment using breakfast(),
                   and then comiles using mka() against cookies target.
- mka:             Builds using SCHED_BATCH on all processors.
- pushboot:        Push a file from your OUT dir to your phone and
                   reboots it, using absolute path.
- repopick:        Utility to fetch changes from Gerrit.
EOF
}

function brunch()
{
    breakfast $*
    if [ $? -eq 0 ]; then
        time mka cookies
    else
        echo "No such item in brunch menu. Try 'breakfast'"
        return 1
    fi
    return $?
}

function breakfast()
{
    target=$1
    local variant=$2
    CUSTOM_DEVICES_ONLY="true"
    unset LUNCH_MENU_CHOICES
    add_lunch_combo full-eng
    for f in `/bin/ls device/*/*/vendorsetup.sh 2> /dev/null`
        do
            echo "including $f"
            . $f
        done
    unset f

    if [ $# -eq 0 ]; then
        # No arguments, so let's have the full menu
        lunch
    else
        echo "z$target" | grep -q "-"
        if [ $? -eq 0 ]; then
            # A buildtype was specified, assume a full device name
            lunch $target
        else
            # This is probably just the omni model name
            if [ -z "$variant" ]; then
                variant="userdebug"
            fi
            lunch omni_$target-$variant
        fi
    fi
    return $?
}

alias bib=breakfast

function fixup_common_out_dir() {
    common_out_dir=$(get_build_var OUT_DIR)/target/common
    target_device=$(get_build_var TARGET_DEVICE)
    if [ ! -z $ANDROID_FIXUP_COMMON_OUT ]; then
        if [ -d ${common_out_dir} ] && [ ! -L ${common_out_dir} ]; then
            mv ${common_out_dir} ${common_out_dir}-${target_device}
            ln -s ${common_out_dir}-${target_device} ${common_out_dir}
        else
            [ -L ${common_out_dir} ] && rm ${common_out_dir}
            mkdir -p ${common_out_dir}-${target_device}
            ln -s ${common_out_dir}-${target_device} ${common_out_dir}
        fi
    else
        [ -L ${common_out_dir} ] && rm ${common_out_dir}
        mkdir -p ${common_out_dir}
    fi
}

# Make using all available CPUs
function mka() {
    m "$@"
}

function pushboot() {
    if [ ! -f $OUT/$* ]; then
        echo "File not found: $OUT/$*"
        return 1
    fi

    adb root
    sleep 1
    adb wait-for-device
    adb remount

    adb push $OUT/$* /$*
    adb reboot
}

function repopick() {
    set_stuff_for_environment
    T=$(gettop)
    $T/vendor/omni/build/tools/repopick.py $@
}

