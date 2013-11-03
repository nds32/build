CONFIG:=config
PWD:=$(shell pwd)
KCONFIG_DIR:=$(PWD)/kconfig
MCONF:=mconf

all:

$(KCONFIG_DIR)/$(MCONF):
	cd $(KCONFIG_DIR) && \
	  make -f Makefile.olibc mconf obj=`pwd` \
	  CC="gcc" HOSTCC="gcc" LKC_GENPARSER=1

config: $(KCONFIG_DIR)/$(MCONF)
	$(KCONFIG_DIR)/$(MCONF) build/Config.in
