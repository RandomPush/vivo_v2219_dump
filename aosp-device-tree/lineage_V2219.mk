#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from V2219 device
$(call inherit-product, device/vivo/V2219/device.mk)

PRODUCT_DEVICE := V2219
PRODUCT_NAME := lineage_V2219
PRODUCT_BRAND := vivo
PRODUCT_MODEL := V2219
PRODUCT_MANUFACTURER := vivo

PRODUCT_GMS_CLIENTID_BASE := android-vivo

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="sys_mssi_64_cn_armv82-user 14 UP1A.230519.001 bsppre18 release-keys"

BUILD_FINGERPRINT := vivo/V2219/V2219:13/TP1A.220624.014/compiler07061743:user/release-keys
