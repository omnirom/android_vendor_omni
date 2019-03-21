package android
type Product_variables struct {
	TargetNeedsHWCOnFirstRef struct {
		Cflags []string
	}
}

type ProductVariables struct {
	TargetNeedsHWCOnFirstRef  *bool `json:",omitempty"`
}
