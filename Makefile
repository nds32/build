CONFIG:=config.mak
PWD:=$(shell pwd)
KCONFIG_DIR:=$(PWD)/kconfig
MCONF:=mconf

-include $(CONFIG)
# Include path.mak for initialize XXX_DIR
include build/path.mak
# Include stmp.mak for initialize XXX_STMP
include build/stmp.mak
# Include var.mak for initialize misc variables
include build/var.mak

all: $(GCC_BOOTSTRAP_STMP) $(BINUTILS_STMP)

$(KCONFIG_DIR)/$(MCONF):
	cd $(KCONFIG_DIR) && \
	  make -f Makefile.olibc mconf obj=`pwd` \
	  CC="gcc" HOSTCC="gcc" LKC_GENPARSER=1

config: $(KCONFIG_DIR)/$(MCONF)
	NDS32_TOOLCHAIN_CONFIG=$(CONFIG) $(KCONFIG_DIR)/$(MCONF) build/Config.in

$(CONFIG): $(KCONFIG_DIR)/$(MCONF)
	NDS32_TOOLCHAIN_CONFIG=$(CONFIG) $(KCONFIG_DIR)/$(MCONF) build/Config.in

$(TOOLCHAIN_STMP): $(BINUTILS_STMP)

include build/host-tools.mak
include build/toolchain.mak
