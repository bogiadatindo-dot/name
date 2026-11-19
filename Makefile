TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BogiadatXTedTeam

BogiadatXTedTeam_FILES = Tweak.xm
BogiadatXTedTeam_CFLAGS = -fobjc-arc
BogiadatXTedTeam_FRAMEWORKS = UIKit QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk
