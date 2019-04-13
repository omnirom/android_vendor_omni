package android
type Product_variables struct {
	Healthd_use_battery_info struct {
		Cflags []string
	}
	TargetNeedsHWCOnFirstRef struct {
		Cflags []string
	}
}

type ProductVariables struct {
	Healthd_use_battery_info  *bool `json:",omitempty"`
	TargetNeedsHWCOnFirstRef  *bool `json:",omitempty"`
}
