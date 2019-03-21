_contents := $(_contents)    "Omnirom": {$(newline)

# See build/core/soong_config.mk for the add_json_* functions you can use here.
$(call add_json_bool, TargetNeedsHWCOnFirstRef, $(filter true,$(TARGET_NEEDS_HWC_ONFIRSTREF)))

# This causes the build system to strip out the last comma in our nested struct, to keep the JSON valid.
_contents := $(_contents)__SV_END

_contents := $(_contents)    },$(newline)
