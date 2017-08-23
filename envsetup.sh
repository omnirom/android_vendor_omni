function repopick() {
    set_stuff_for_environment
    T=$(gettop)
    $T/build/tools/repopick.py $@
}
