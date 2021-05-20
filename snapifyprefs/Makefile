TARGET := iphone:clang:14.4:7.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SnapifyPrefs

SnapifyPrefs_FILES = SNPRootListController.m SNPAnimatedTitleView.m
SnapifyPrefs_FRAMEWORKS = UIKit
SnapifyPrefs_PRIVATE_FRAMEWORKS = Preferences
SnapifyPrefs_INSTALL_PATH = /Library/PreferenceBundles
SnapifyPrefs_CFLAGS = -fobjc-arc
SnapifyPrefs_EXTRA_FRAMEWORKS += Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk
