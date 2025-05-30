/*
 * Copyright (C) 2022 The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#include <android-base/file.h>
#include <android-base/logging.h>
#include <android-base/properties.h>
#include <android-base/strings.h>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

using android::base::GetProperty;
using android::base::ReadFileToString;
using android::base::Split;
using android::base::Trim;

/*
 * SetProperty does not allow updating read only properties and as a result
 * does not work for our use case. Write "OverrideProperty" to do practically
 * the same thing as "SetProperty" without this restriction.
 */
void OverrideProperty(const char* name, const char* value) {
    size_t valuelen = strlen(value);

    prop_info* pi = (prop_info*)__system_property_find(name);
    if (pi != nullptr) {
        __system_property_update(pi, value, valuelen);
    } else {
        __system_property_add(name, strlen(name), value, valuelen);
    }
}

/*
 * Only for read-only properties. Properties that can be wrote to more
 * than once should be set in a typical init script (e.g. init.oplus.hw.rc)
 * after the original property has been set.
 */
void vendor_load_properties() {
    auto device = GetProperty("ro.product.product.device", "");
    auto rf_version = std::stoi(GetProperty("ro.boot.rf_version", "0"));

    switch (rf_version) {
        case 13: // IN
            OverrideProperty("ro.product.product.model", "AC2001");
            break;
        case 14: // EU/GLO
            OverrideProperty("ro.product.product.model", "AC2003");
            break;
        default:
            LOG(ERROR) << "Unexpected RF version: " << rf_version;
    }
    
    if (std::string content; ReadFileToString("/proc/devinfo/ddr_type", &content)) {
        OverrideProperty("ro.boot.ddr_type", Split(Trim(content), "\t").back().c_str());
    }
    
    // Infinity-X Properties
    OverrideProperty("ro.infinity.maintainer", "Sreeshankar K");
    OverrideProperty("ro.infinity.soc", "Snapdragon 765G 5G");
    OverrideProperty("ro.infinity.battery", "4115 mAh");
    OverrideProperty("ro.infinity.display", "1080 x 2400, 90Hz");
    OverrideProperty("ro.infinity.camera", "48MP + 8MP + 5MP + 2MP");
    OverrideProperty("ro.product.marketname", "OnePlus Nord");
}
