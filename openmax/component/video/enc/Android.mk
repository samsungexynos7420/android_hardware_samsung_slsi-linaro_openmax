LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	Exynos_OMX_VencControl.c \
	Exynos_OMX_Venc.c

LOCAL_MODULE := libExynosOMX_Venc
LOCAL_ARM_MODE := arm
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true

LOCAL_C_INCLUDES := \
	$(EXYNOS_OMX_INC)/exynos \
	$(EXYNOS_OMX_TOP)/osal \
	$(EXYNOS_OMX_TOP)/core \
	$(EXYNOS_OMX_COMPONENT)/common \
	$(EXYNOS_OMX_COMPONENT)/video/enc \
	$(EXYNOS_VIDEO_CODEC)/include \
	$(TOP)/hardware/samsung_slsi-linaro/exynos/include \

ifeq ($(BOARD_USE_KHRONOS_OMX_HEADER), true)
LOCAL_CFLAGS += -DUSE_KHRONOS_OMX_HEADER
LOCAL_C_INCLUDES += $(EXYNOS_OMX_INC)/khronos
else
ifeq ($(BOARD_USE_ANDROID), true)
LOCAL_HEADER_LIBRARIES := media_plugin_headers
LOCAL_CFLAGS += -DUSE_ANDROID
endif
endif

ifeq ($(EXYNOS_OMX_SUPPORT_TUNNELING), true)
LOCAL_CFLAGS += -DTUNNELING_SUPPORT
endif

ifeq ($(BOARD_USE_DMA_BUF), true)
LOCAL_CFLAGS += -DUSE_DMA_BUF
endif

ifeq ($(BOARD_USE_GSC_RGB_ENCODER), true)
LOCAL_CFLAGS += -DUSE_HW_CSC_GRALLOC_SOURCE
endif

ifeq ($(BOARD_USE_FIMC_RGB_ENCODER), true)
LOCAL_CFLAGS += -DUSE_HW_CSC_GRALLOC_SOURCE
LOCAL_CFLAGS += -DUSE_FIMC_CSC
endif

ifeq ($(BOARD_USE_CSC_HW), true)
LOCAL_CFLAGS += -DUSE_CSC_HW
endif

ifeq ($(BOARD_USE_VIDEO_EXT_FOR_WFD_HDCP), true)
LOCAL_CFLAGS += -DUSE_VIDEO_EXT_FOR_WFD_HDCP
endif

ifdef BOARD_EXYNOS_S10B_FORMAT_ALIGN
LOCAL_CFLAGS += -DS10B_FORMAT_8B_ALIGNMENT=$(BOARD_EXYNOS_S10B_FORMAT_ALIGN)
endif

LOCAL_SHARED_LIBRARIES := liblog libcsc


LOCAL_CFLAGS += -Wno-unused-variable -Wno-unused-label
include $(BUILD_STATIC_LIBRARY)
