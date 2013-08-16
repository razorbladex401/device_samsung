# Copyright (C) 2010 The Android Open Source Project
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


# This file is the device-specific product definition file for
# smdk4x12. It lists all the overlays, files, modules and properties
# that are specific to this hardware: i.e. those are device-specific
# drivers, configuration files, settings, etc...

# Note that smdk4x12 is not a fully open device. Some of the drivers
# aren't publicly available in all circumstances, which means that some
# of the hardware capabilities aren't present in builds where those
# drivers aren't available. Such cases are handled by having this file
# separated into two halves: this half here contains the parts that
# are available to everyone, while another half in the vendor/ hierarchy
# augments that set with the parts that are only relevant when all the
# associated drivers are available. Aspects that are irrelevant but
# harmless in no-driver builds should be kept here for simplicity and
# transparency. There are two variants of the half that deals with
# the unavailable drivers: one is directly checked into the unreleased
# vendor tree and is used by engineers who have access to it. The other
# is generated by setup-makefile.sh in the same directory as this files,
# and is used by people who have access to binary versions of the drivers
# but not to the original vendor tree. Be sure to update both.



# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.

LOCAL_PATH := device/samsung/smdk4x12

include $(LOCAL_PATH)/BoardConfig.mk

ifeq ($(BOARD_EMMC_BSP),true)
source_vold_fstab_file := $(LOCAL_PATH)/conf/vold_emmc.fstab
else
source_vold_fstab_file := $(LOCAL_PATH)/conf/vold_sdmmc.fstab
endif

DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay

# These are the hardware-specific configuration files
PRODUCT_COPY_FILES += \
	$(source_vold_fstab_file):system/etc/vold.fstab


#libion.so uses the same name with system/libion, so trick it here
PRODUCT_COPY_FILES += \
       device/samsung/exynos4/lib/mali_ump/libion.so:system/lib/libion.so
       

#media codec file
PRODUCT_COPY_FILES += \
       device/samsung/smdk4x12/media_codecs.xml:system/etc/media_codecs.xml


# Init files
PRODUCT_COPY_FILES += \
	device/samsung/smdk4x12/conf/init.smdk4x12.rc:root/init.smdk4x12.rc \
	device/samsung/smdk4x12/conf/init.smdk4x12.usb.rc:root/init.smdk4x12.usb.rc

#Camera video backgroud effect file.
#PRODUCT_COPY_FILES += \
#        frameworks/base/data/videos/Sunset.480p.mq.mp4:system/media/video/Sunset.480p.mp4 \
#        frameworks/base/data/videos/Sunset.240p.mp4:system/media/video/Sunset.240p.mp4 \
#        frameworks/base/data/videos/Disco.480p.mq.mp4:system/media/video/Disco.480p.mp4 \
#        frameworks/base/data/videos/Disco.240p.mp4:system/media/video/Disco.240p.mp4 \
#        frameworks/base/data/videos/AndroidInSpace.240p.mp4:system/media/video/AndroidInSpace.240p.mp4 \
#        frameworks/base/data/videos/AndroidInSpace.480p.mq.mp4:system/media/video/AndroidInSpace.480p.mp4

# For V4L2
ifeq ($(BOARD_USE_V4L2), true)
ifeq ($(BOARD_USE_V4L2_ION), true)
PRODUCT_COPY_FILES += \
	device/samsung/smdk4x12/conf/ueventd.smdk4x12.v4l2ion.rc:root/ueventd.smdk4x12.rc
else
PRODUCT_COPY_FILES += \
	device/samsung/smdk4x12/conf/ueventd.smdk4x12.v4l2.rc:root/ueventd.smdk4x12.rc
endif
else
PRODUCT_COPY_FILES += \
	device/samsung/smdk4x12/conf/ueventd.smdk4x12.rc:root/ueventd.smdk4x12.rc
endif


#yyd- 120112 add ecompass apk
#PRODUCT_COPY_FILES += \
#	device/samsung/smdk4x12/apk/com.apksoftware.compass.apk:system/app/com.apksoftware.compass.apk

ifeq ($(BOARD_USES_FFMPEG), true)
#yujian- 120216 add mediaplayer apk
#PRODUCT_COPY_FILES += \
#	device/samsung/smdk4x12/apk/MediaPlayer.apk:system/app/MediaPlayer.apk
endif

# Prebuilt kl keymaps
#jmq.disable key layout, will check later
#PRODUCT_COPY_FILES += \
#	device/samsung/smdk4x12/samsung-keypad.kl:system/usr/keylayout/samsung-keypad.kl \
#	device/samsung/smdk4x12/pixcir-i2c-ts_key.kl:system/usr/keylayout/pixcir-i2c-ts_key.kl 
PRODUCT_COPY_FILES += \
        device/samsung/smdk4x12/eGalaxTouchScreen.idc:system/usr/idc/eGalaxTouchScreen.idc
# Generated kcm keymaps
#PRODUCT_PACKAGES := \
#	samsung-keypad.kcm

PRODUCT_PACKAGES :=

# Mali
PRODUCT_PACKAGES += \
        libEGL_mali \
        libGLESv1_CM_mali \
        libGLESv2_mali \
        libMali \
        libUMP \
        libion2
# gralloc
PRODUCT_PACKAGES += \
       gralloc.smdk4x12 \

# Filesystem management tools
PRODUCT_PACKAGES += \
	make_ext4fs \
	setup_fs

# audio
PRODUCT_PACKAGES += \
	audio_policy.smdk4x12 \
	audio.primary.smdk4x12 \
	audio.a2dp.default \
	libaudioutils
# wenpni.cui: AudioPolicyManager will read this file.
PRODUCT_COPY_FILES += \
        device/samsung/smdk4x12/audio_policy.conf:/system/etc/audio_policy.conf

# ULP Audio
#ifeq ($(USE_ULP_AUDIO),true)
#PRODUCT_PACKAGES += \
#	libaudiohw \
#	MusicULP \
#	libsa_jni
#endif

# ALP Audio
ifeq ($(BOARD_USE_ALP_AUDIO),true)
PRODUCT_PACKAGES += \
	libOMX.SEC.MP3.Decoder
endif

# Camera
PRODUCT_PACKAGES += \
	camera.smdk4x12 \

# SEC_Camera
ifeq ($(USE_SEC_CAMERA),true)
PRODUCT_PACKAGES += \
	SEC_Camera
endif

# Libs
PRODUCT_PACKAGES += \
	libstagefrighthw \
	com.android.future.usb.accessory

# Video Editor
PRODUCT_PACKAGES += \
	VideoEditorGoogle

# Misc other modules
PRODUCT_PACKAGES += \
	hwcomposer.exynos4 \
	lights.smdk4x12 

#GPS
#PRODUCT_PACKAGES += \
#       	gps.exynos4

# Widevine DRM
PRODUCT_PACKAGES += com.google.widevine.software.drm.xml \
	com.google.widevine.software.drm \
	WidevineSamplePlayer \
	test-libwvm \
	test-wvdrmplugin \
	test-wvplayer_L1 \
	libdrmwvmplugin \
	libwvm \
	libWVStreamControlAPI_L1 \
	libwvdrm_L1
	
# OpenMAX IL configuration files
PRODUCT_COPY_FILES += \
	device/samsung/smdk4x12/media_profiles.xml:system/etc/media_profiles.xml

# OpenMAX IL modules
PRODUCT_PACKAGES += \
	libSEC_OMX_Core \
	libSEC_OMX_Resourcemanager \
	libOMX.SEC.AVC.Decoder \
	libOMX.SEC.M4V.Decoder \
	libOMX.SEC.M4V.Encoder \
	libOMX.SEC.AVC.Encoder

# hwconvertor modules
PRODUCT_PACKAGES += \
	libhwconverter \

# MFC firmware
PRODUCT_COPY_FILES += \
	device/samsung/exynos4/firmware/mfc_fw.bin:root/vendor/firmware/mfc_fw.bin

# FIMC-IS firmware
PRODUCT_COPY_FILES += \
	device/samsung/exynos4/firmware/fimc_is_fw.bin:root/vendor/firmware/fimc_is_fw.bin \
	device/samsung/exynos4/firmware/setfile.bin:root/vendor/firmware/setfile.bin

# Input device calibration files
#PRODUCT_COPY_FILES += \
#	device/samsung/smdk4x12/s5pc210_ts.idc:system/usr/idc/s5pc210_ts.idc \
#	device/samsung/smdk4x12/pixcir-i2c-ts.idc:system/usr/idc/pixcir-i2c-ts.idc

#PRODUCT_COPY_FILES += \
#	frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
#	frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
#	frameworks/base/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
#	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES := \
	ro.opengles.version=131072

PRODUCT_PROPERTY_OVERRIDES += \
	debug.hwui.render_dirty_regions=false

# Widevine DRM
PRODUCT_PROPERTY_OVERRIDES += \
	drm.service.enabled=true

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mass_storage

ifeq ($(BOARD_USES_HIGH_RESOLUTION_LCD),true)
PRODUCT_CHARACTERISTICS := tablet

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)

else
PRODUCT_CHARACTERISTICS := phone

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=160

PRODUCT_AAPT_CONFIG := normal hdpi
endif

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# NFC
#PRODUCT_PACKAGES += \
#	libnfc \
#	libnfc_jni \
#	Nfc \
#	Tag \
#	libsnfc_fw

# NFC
#PRODUCT_PACKAGES += \
#	nfc.default


# NFC
#PRODUCT_COPY_FILES += \
#	frameworks/base/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml

# NFC EXTRAS add-on API
#PRODUCT_PACKAGES += \
#	com.android.nfc_extras
#PRODUCT_COPY_FILES += \
#	frameworks/base/nfc-extras/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml

#sensors
#PRODUCT_PACKAGES += \
    libinvensense_hal \
    sensors.smdk4x12

