#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
#
# makefile fragment that defines the download of the kernel version
#

#-------------------------------------------------------------------------------
# Need the Linux kernel downloaded before building xtools

LINUX_VERSION		= 3.2
LINUX_SUBVERSION	= $(LINUX_VERSION).35
LINUX_TARBALL		= linux-$(LINUX_SUBVERSION).tar.xz
export LINUX_TARBALL
LINUX_TARBALL_URLS	+= $(ONIE_MIRROR) https://www.kernel.org/pub/linux/kernel/v3.x

KERNEL_DOWNLOAD_STAMP	= $(DOWNLOADDIR)/kernel-download

PHONY += kernel-download kernel-download-clean

DOWNLOAD += $(KERNEL_DOWNLOAD_STAMP)
kernel-download: $(KERNEL_DOWNLOAD_STAMP)
$(KERNEL_DOWNLOAD_STAMP): $(PROJECT_STAMP)
	$(Q) rm -f $@ && eval $(PROFILE_STAMP)
	$(Q) echo "==== Getting Linux ===="
	$(Q) $(SCRIPTDIR)/fetch-package $(DOWNLOADDIR) $(UPSTREAMDIR) \
		$(LINUX_TARBALL) $(LINUX_TARBALL_URLS)
	$(Q) touch $@

DOWNLOAD_CLEAN += kernel-download-clean
kernel-download-clean:
	$(Q) rm -f $(KERNEL_DOWNLOAD_STAMP) $(DOWNLOADDIR)/$(LINUX_TARBALL)

#-------------------------------------------------------------------------------
#
# Local Variables:
# mode: makefile-gmake
# End:
