package android
type Product_variables struct {
	Healthd_use_battery_info struct {
		Cflags []string
	}
	Supports_hw_fde struct {
		Cflags []string
		Header_libs []string
		Shared_libs []string
	}
	Supports_hw_fde_perf struct {
		Cflags []string
	}
	TargetNeedsHWCOnFirstRef struct {
		Cflags []string
	}
	Uses_metadata_as_fde_key struct {
		Cflags []string
	}
}

type ProductVariables struct {
	Healthd_use_battery_info  *bool `json:",omitempty"`
	Supports_hw_fde  *bool `json:",omitempty"`
	Supports_hw_fde_perf  *bool `json:",omitempty"`
	TargetNeedsHWCOnFirstRef  *bool `json:",omitempty"`
	Uses_metadata_as_fde_key  *bool `json:",omitempty"`
	Target_use_sdclang        *bool `json:",omitempty"`
}
