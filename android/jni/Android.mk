LOCAL_PATH := $(call my-dir)
TOP_LOCAL_PATH := $(LOCAL_PATH)

MUPDF_ROOT := ..

include $(TOP_LOCAL_PATH)/Core.mk
include $(TOP_LOCAL_PATH)/ThirdParty.mk
-include android-ndk-profiler.mk

# include the profiler snippet

include $(CLEAR_VARS)

LOCAL_C_INCLUDES := \
	$(MUPDF_ROOT)/draw \
	$(MUPDF_ROOT)/fitz \
	$(MUPDF_ROOT)/pdf
	
LOCAL_CFLAGS := -pg -fno-omit-frame-pointer -fno-function-sections
LOCAL_MODULE    := mupdf
LOCAL_SRC_FILES := mupdf.c
LOCAL_STATIC_LIBRARIES := mupdfcore mupdfthirdparty andprof

LOCAL_LDLIBS := -lm -llog -ljnigraphics -L$(call host-path, $(LOCAL_PATH))/$(TARGET_ARCH_ABI) -landprof

include $(BUILD_SHARED_LIBRARY)
