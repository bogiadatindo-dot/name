TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

# Kiểm tra nếu biến ROOTLESS được bật thì áp dụng cấu hình cho rootless
ifeq ($(ROOTLESS),1)
THEOS_PACKAGE_SCHEME = rootless
PACKAGE_VERSION = $(THEOS_PACKAGE_VERSION)-rootless
else
PACKAGE_VERSION = $(THEOS_PACKAGE_VERSION)-rootful
endif

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BogiadatXTedTeam

BogiadatXTedTeam_FILES = Tweak.xm
BogiadatXTedTeam_CFLAGS = -fobjc-arc
BogiadatXTedTeam_FRAMEWORKS = UIKit QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk
