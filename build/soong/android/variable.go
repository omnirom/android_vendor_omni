package android
type Product_variables struct {
    Healthd_use_battery_info struct {
        Cflags []string
    }
    Healthd_enable_tricolor_led struct {
        Cflags []string
    }
    Healthd_enable_op_fastchg struct {
        Cflags []string
    }
    TargetNeedsHWCOnFirstRef struct {
        Cflags []string
    }
    Uses_metadata_as_fde_key struct {
        Cflags []string
    }
    Target_init_vendor_lib struct {
        Static_libs []string
        Cflags []string
    }
    Target_camera_needs_client_info struct {
        Cflags []string
    }
    Target_motorized_camera struct {
        Cflags []string
    }
    Target_enforce_ab_ota_partition_list struct {
        Cflags []string
    }
    Target_surfaceflinger_fod_lib struct {
        Cflags []string
        Whole_static_libs []string
    }
    Target_vold_vendor_lib struct {
        Static_libs []string
        Cflags []string
    }
}

type ProductVariables struct {
    Healthd_use_battery_info                *bool `json:",omitempty"`
    Healthd_enable_tricolor_led             *bool `json:",omitempty"`
    Healthd_enable_op_fastchg               *bool `json:",omitempty"`
    TargetNeedsHWCOnFirstRef                *bool `json:",omitempty"`
    Uses_metadata_as_fde_key                *bool `json:",omitempty"`
    Target_use_sdclang                      *bool `json:",omitempty"`
    Target_camera_needs_client_info         *bool `json:",omitempty"`
    Target_motorized_camera                 *bool `json:",omitempty"`
    Target_init_vendor_lib                  *string `json:",omitempty"`
    Target_enforce_ab_ota_partition_list    *bool `json:",omitempty"`
    Target_surfaceflinger_fod_lib            *string `json:",omitempty"`
    Target_vold_vendor_lib                  *string `json:",omitempty"`
}
