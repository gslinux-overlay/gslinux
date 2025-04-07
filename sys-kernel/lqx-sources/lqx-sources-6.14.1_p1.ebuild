# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="extras"
K_GENPATCHES_VER="1"
CKV="$(ver_cut 1-3)"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
LQX_PATCHSET="${PV/*_p}"

inherit kernel-2
detect_version

KEYWORDS="~amd64 ~arm64 ~x86"
HOMEPAGE="https://github.com/zen-kernel"
IUSE=""

DESCRIPTION="The Liquorix Kernel Live Sources"

K_BRANCH_ID="${KV_MAJOR}.${KV_MINOR}"
# LQX_URI="https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${K_BRANCH_ID}-lqx${LQX_PATCHSET}.tar.gz"
LQX_URI="https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${K_BRANCH_ID}.${KV_PATCH}-lqx${LQX_PATCHSET}.tar.gz"
SRC_URI="${LQX_URI} ${GENPATCHES_URI} ${ARCH_URI}"

KV_FULL="${PVR/_p/-lqx}"
S="${WORKDIR}/linux-${KV_FULL}"

K_EXTRAEINFO="For more info on zen-sources-lqx, and for how to report problems, see: \
${HOMEPAGE}, also go to #zen-sources-lqx on oftc"

src_unpack() {
	# Since the Codeberg-hosted pf-sources include full kernel sources, we need to manually override
	# the src_unpack phase because kernel-2_src_unpack() does a lot of unwanted magic here.
	unpack ${A}

#	mv zen-kernel-${K_BRANCH_ID}-lqx${LQX_PATCHSET} linux-${K_BRANCH_ID}.${KV_PATCH}-lqx${LQX_PATCHSET} || die "Failed to move source directory"

	mv zen-kernel-${K_BRANCH_ID}.${KV_PATCH}-lqx${LQX_PATCHSET} linux-${K_BRANCH_ID}.${KV_PATCH}-lqx${LQX_PATCHSET} || die "Failed to move source directory"
}

src_prepare() {
	# When genpatches basic version is bumped, it also includes vanilla linux updates. Those are
	# already in the -pf patch set, so need to remove the vanilla linux patches to avoid conflicts.
	if [[ ${K_GENPATCHES_VER} -ne 1 ]]; then
		find "${WORKDIR}"/ -type f -name '10*linux*patch' -delete ||
			die "Failed to delete vanilla linux patches in src_prepare."
	fi

	# kernel-2_src_prepare doesn't apply PATCHES(). Chosen genpatches are also applied here.
	eapply "${WORKDIR}"/*.patch
	default
}

pkg_setup() {
	ewarn
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the zen-lqx developers directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn
	kernel-2_pkg_setup
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
