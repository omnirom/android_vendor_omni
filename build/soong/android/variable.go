package android
type Product_variables struct {
	Healthd_use_battery_info struct {
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
                Whole_static_libs []string
                Cflags []string
        }

}

type ProductVariables struct {
	Healthd_use_battery_info   *bool `json:",omitempty"`
	Healthd_enable_op_fastchg  *bool `json:",omitempty"`
	TargetNeedsHWCOnFirstRef   *bool `json:",omitempty"`
	Uses_metadata_as_fde_key   *bool `json:",omitempty"`
	Target_use_sdclang         *bool `json:",omitempty"`
	Target_init_vendor_lib     *string `json:",omitempty"`
}
