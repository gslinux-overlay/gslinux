# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="A small free software GUI toolkit"
HOMEPAGE="https://github.com/iurie-sw/redkite"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/iurie-sw/redkite.git"
else
	SRC_URI="https://github.com/iurie-sw/redkite/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi
LICENSE="GPL-2"
SLOT="0"

IUSE=""

RDEPEND="
	x11-libs/cairo[X]"
DEPEND="${RDEPEND}"

src_configure() {
	cmake-utils_src_configure
}
