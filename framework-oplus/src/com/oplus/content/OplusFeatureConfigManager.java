package com.oplus.content;

import android.text.TextUtils;

import java.util.List;

public class OplusFeatureConfigManager {

    public static OplusFeatureConfigManager sOplusFeatureConfigManager = null;

    public static OplusFeatureConfigManager getInstance() {
        if (sOplusFeatureConfigManager == null) {
            sOplusFeatureConfigManager = new OplusFeatureConfigManager();
        }
        return sOplusFeatureConfigManager;
    }

    public boolean hasFeature(String name) {
        return false;
    }

     public interface OnFeatureObserver {
        default void onFeatureUpdate(List<String> features) {}
    }
}
