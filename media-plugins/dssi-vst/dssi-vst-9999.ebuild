# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6

inherit multilib toolchain-funcs flag-o-matic git-r3

DESCRIPTION="DSSI wrapper plugin for Windows VSTs"
HOMEPAGE="http://github.com/falkTX/dssi-vst"

EGIT_REPO_URI="https://github.com/falkTX/dssi-vst.git"

LICENSE="GPL-2"
SLOT="0"

RDEPEND=">=media-libs/dssi-0.9.0
	media-libs/ladspa-sdk
	>=media-libs/liblo-0.12
	media-libs/alsa-lib
	virtual/jack
	app-emulation/wine-staging"
DEPEND="${RDEPEND}"

src_compile(){
        tc-export CXX
        emake || "die emake failed"
}
