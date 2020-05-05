# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="Linear/Logitudinal Time Code (LTC) Library"
HOMEPAGE="https://x42.github.io/libltc/"
EGIT_REPO_URI="https://github.com/x42/libltc.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE=""

RDEPEND=""

src_prepare() {
	eautoreconf

	default
}

src_configure() {
	econf 
}
