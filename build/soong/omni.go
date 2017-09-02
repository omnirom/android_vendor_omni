// Copyright (C) 2016 The Android Open Source Project
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
package omni

import (
  "strings"

  "android/soong/android"
  "android/soong/cc"

  "github.com/google/blueprint"
)

func init() {
  android.RegisterModuleType("omni_defaults", omniDefaultsFactory)
}

func omniDefaultsFactory() (blueprint.Module, []interface{}) {
  module, props := cc.DefaultsFactory()
  android.AddLoadHook(module, omniDefaults)

  return module, props
}

func omniDefaults(ctx android.LoadHookContext) {
  type props struct {
    Cflags []string
  }

  p := &props{}
  p.Cflags = globalDefaults(ctx)

  ctx.AppendProperties(p)
}

func globalDefaults(ctx android.BaseContext) ([]string) {
  var cflags []string

  qti_hardware := ctx.DeviceConfig().BoardUsesQTIHardware()
  if (qti_hardware) {
      cflags = append(cflags, "-DQCOM_HARDWARE")
      cflags = append(cflags, "-DQCOM_BSP")
      cflags = append(cflags, "-DQTI_BSP")
  }

  return cflags
}
