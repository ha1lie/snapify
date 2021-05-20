TARGET := iphone:clang:14.4:7.0
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e
PREFIX=$(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/

PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Snapify

Snapify_FILES = Tweak.xm 
Snapify_CFLAGS = -fobjc-arc
Snapify_PRIVATE_FRAMEWORKS = ChatKit
Snapify_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += snapifyprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
