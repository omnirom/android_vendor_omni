function repopick() {
    set_stuff_for_environment
    T=$(gettop)
    $T/vendor/omni/build/tools/repopick.py $@
}
