/*
* Copyright (C) 2015 The OmniROM Project
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*
*/
package org.omnirom.device;

import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.KeyEvent;

import com.android.internal.util.omni.DeviceKeyHandler;

public class KeyHandler implements DeviceKeyHandler {

    private static final String TAG = KeyHandler.class.getSimpleName();
    private static final boolean DEBUG = true;

    public KeyHandler(Context context) {
        if (DEBUG) Log.i(TAG, "KeyHandler");
    }

    @Override
    public boolean handleKeyEvent(KeyEvent event) {
        if (DEBUG) Log.i(TAG, "scanCode=" + event.getScanCode());
        return false;
    }

    @Override
    public boolean canHandleKeyEvent(KeyEvent event) {
        if (DEBUG) Log.i(TAG, "canHandleKeyEvent=" + event.getScanCode());
        return false;
    }

    @Override
    public boolean isDisabledKeyEvent(KeyEvent event) {
        if (DEBUG) Log.i(TAG, "isDisabledKeyEvent=" + event.getScanCode());
        return false;
    }

    @Override
    public boolean isCameraLaunchEvent(KeyEvent event) {
        if (DEBUG) Log.i(TAG, "isCameraLaunchEvent=" + event.getScanCode());
        return false;
    }

    @Override
    public boolean isWakeEvent(KeyEvent event){
        if (DEBUG) Log.i(TAG, "isWakeEvent=" + event.getScanCode());
        return false;
    }

    @Override
    public Intent isActivityLaunchEvent(KeyEvent event) {
        if (DEBUG) Log.i(TAG, "isActivityLaunchEvent=" + event.getScanCode());
        return null;
    }
}
