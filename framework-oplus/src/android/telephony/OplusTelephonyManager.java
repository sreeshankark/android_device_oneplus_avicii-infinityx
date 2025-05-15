package android.telephony;

import android.content.Context;

public class OplusTelephonyManager {
    private static OplusTelephonyManager sInstance = null;

    public OplusTelephonyManager(Context context) {}

    public static OplusTelephonyManager getInstance(Context context) {
        if (sInstance == null) {
            sInstance = new OplusTelephonyManager(context);
        }
        return sInstance;
    }

    public String getImsType(int slotId) {
        return null;
    }
}