package android
type Product_variables struct {
	Healthd_enable_huawei_fastchg struct {
		Cflags []string
	}
	Healthd_use_battery_info struct {
		Cflags []string
	}
	TargetNeedsHWCOnFirstRef struct {
		Cflags []string
	}
}

type ProductVariables struct {
	Healthd_enable_huawei_fastchg  *bool `json:",omitempty"`
	Healthd_use_battery_info  *bool `json:",omitempty"`
	TargetNeedsHWCOnFirstRef  *bool `json:",omitempty"`
}
