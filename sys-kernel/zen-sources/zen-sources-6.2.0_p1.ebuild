# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="1"
CKV="$(ver_cut 1-3)"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
ZEN_PATCHSET="${PV/*_p}"

inherit kernel-2
detect_version

KEYWORDS="~amd64 ~arm64 ~x86"
HOMEPAGE="https://github.com/zen-kernel"
IUSE=""

DESCRIPTION="The Zen Kernel Live Sources"

K_BRANCH_ID="${KV_MAJOR}.${KV_MINOR}"
ZEN_URI="https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${K_BRANCH_ID}-zen${ZEN_PATCHSET}.tar.gz"
SRC_URI="${ZEN_URI} ${GENPATCHES_URI} ${ARCH_URI}"

KV_FULL="${PVR/_p/-zen}"
S="${WORKDIR}/linux-${KV_FULL}"

K_EXTRAEINFO="For more info on zen-sources, and for how to report problems, see: \
${HOMEPAGE}, also go to #zen-sources on oftc"

src_unpack() {
	# Since the Codeberg-hosted pf-sources include full kernel sources, we need to manually override
	# the src_unpack phase because kernel-2_src_unpack() does a lot of unwanted magic here.
	unpack ${A}

	mv zen-kernel-${K_BRANCH_ID}-zen${ZEN_PATCHSET} linux-${K_BRANCH_ID}.${KV_PATCH}-zen${ZEN_PATCHSET} || die "Failed to move source directory"
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
