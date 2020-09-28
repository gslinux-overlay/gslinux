# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

V_KLYSTRON="for-klystrack-exec"
SRC_URI="
	https://github.com/kometbomb/klystrack/archive/${PV}-make-fix.tar.gz -> ${P}.tar.gz
	https://github.com/kometbomb/klystron/archive/${V_KLYSTRON}.tar.gz -> klystron-${V_KLYSTRON}.tar.gz
"
KEYWORDS="~amd64"

DESCRIPTION="A really cool fakebit tracker"
HOMEPAGE="http://kometbomb.github.io/klystrack/"
LICENSE="MIT"
SLOT="0"

DEPEND="
	media-libs/libsdl2
	media-libs/sdl2-image
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	default
	mv "${WORKDIR}/${P}-make-fix" "${WORKDIR}/${P}"
	rm -rf "${S}/klystron" || die
	cp -r "${WORKDIR}/klystron-${V_KLYSTRON}" "${S}/klystron" || die
}
