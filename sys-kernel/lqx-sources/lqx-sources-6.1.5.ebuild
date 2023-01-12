# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="1"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~amd64 ~x86"
HOMEPAGE="https://github.com/damentz/liquorix-package"
IUSE=""

DESCRIPTION="The Liquorix Kernel Live Sources"

ZEN_URI="https://github.com/zen-kernel/zen-kernel/releases/download/v${PV}-lqx1/v${PV}-lqx1.patch.xz"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${ZEN_URI}"

UNIPATCH_LIST="${DISTDIR}/v${PV}-lqx1.patch.xz"
UNIPATCH_STRICTORDER="yes"

K_EXTRAEINFO="For more info on liquorix-sources, and for how to report problems, see: \
${HOMEPAGE}, also go to #zen-sources on oftc"

src_prepare() {
	default

	sed \
		"s/default PREEMPT_NONE/default PREEMPT_RT/g" \
		-i "${S}/kernel/Kconfig.preempt" || die "sed failed"
}

pkg_setup() {
	ewarn
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the zen developers directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn
	kernel-2_pkg_setup
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
