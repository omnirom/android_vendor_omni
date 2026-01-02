#!/system/bin/sh

#
# Copyright (C) 2016 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This script runs as a postinstall step to drive Pre-reboot Dexopt. During Pre-reboot Dexopt, the
# new version of this code is run. See system/extras/postinst/postinst.sh for some docs.

TARGET_SLOT="$1"
STATUS_FD="$2"

# "1" if the script is triggered by the `UpdateEngine.triggerPostinstall` API. Empty otherwise.
TRIGGERED_BY_API="$3"

# First ensure the system is booted. This is to work around issues when cmd would
# infinitely loop trying to get a service manager (which will never come up in that
# mode). b/30797145
BOOT_PROPERTY_NAME="dev.bootcomplete"

BOOT_COMPLETE=$(getprop $BOOT_PROPERTY_NAME)
if [ "$BOOT_COMPLETE" != "1" ] ; then
  echo "$0: Error: boot-complete not detected."
  # We must return 0 to not block sideload.
  exit 0
fi

# Compute target slot suffix.
# TODO: Once bootctl is not restricted, we should query from there. Or get this from
#       update_engine as a parameter.
if [ "$TARGET_SLOT" = "0" ] ; then
  TARGET_SLOT_SUFFIX="_a"
elif [ "$TARGET_SLOT" = "1" ] ; then
  TARGET_SLOT_SUFFIX="_b"
else
  echo "$0: Unknown target slot $TARGET_SLOT"
  exit 1
fi

# A source that infinitely emits arbitrary lines.
# When connected to STDIN of another process, this source keeps STDIN open until
# the consumer process closes STDIN or this script dies.
# In practice, the pm command keeps consuming STDIN, so we don't need to worry
# about running out of buffer space.
function infinite_source {
  while echo .; do
    sleep 1
  done
}

if [[ "$TRIGGERED_BY_API" = "1" ]]; then
  # During OTA installation, the script is called the first time, and
  # `TRIGGERED_BY_API` can never be "1". `TRIGGERED_BY_API` being "1" means this
  # is the second call to this script, through the
  # `UpdateEngine.triggerPostinstall` API.
  # When we reach here, it means Pre-reboot Dexopt is enabled in asynchronous
  # mode and the job scheduler determined that it's the time to run the job.
  # Start Pre-reboot Dexopt now and wait for it to finish.
  infinite_source | pm art on-ota-staged --start
  exit $?
fi
