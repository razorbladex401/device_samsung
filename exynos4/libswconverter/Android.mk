LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
	swconvertor.c \
	csc_linear_to_tiled_crop_neon.s \
	csc_linear_to_tiled_interleave_crop_neon.s \
	csc_tiled_to_linear_crop_neon.s \
	csc_tiled_to_linear_deinterleave_crop_neon.s \
	csc_interleave_memcpy_neon.s \
	csc_ARGB8888_to_YUV420SP_NEON.s

LOCAL_C_INCLUDES := \
	$(TOP)/device/samsung/multimedia/openmax/include/khronos \
	$(TOP)/device/samsung/multimedia/openmax/include/sec \
	$(TOP)/device/samsung/exynos4/include \
	$(TOP)/device/samsung/exynos4/libhwconverter

ifeq ($(BOARD_USE_SAMSUNG_COLORFORMAT), true)
LOCAL_CFLAGS += -DUSE_SAMSUNG_COLORFORMAT
endif

LOCAL_MODULE := libswconverter

LOCAL_PRELINK_MODULE := false

LOCAL_CFLAGS :=

LOCAL_ARM_MODE := arm

LOCAL_STATIC_LIBRARIES :=
LOCAL_SHARED_LIBRARIES := liblog libfimc libhwconverter

include $(BUILD_STATIC_LIBRARY)
