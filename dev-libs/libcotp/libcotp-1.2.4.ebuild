# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/paolostivanin/libcotp/archive/v${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/paolostivanin/libcotp.git"
fi

DESCRIPTION="C library that generates TOTP and HOTP according to RFC-6238"
HOMEPAGE="https://github.com/paolostivanin/libcotp/"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND="
        dev-libs/libbaseencode
        dev-libs/libgcrypt
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
	)
		
    cmake-utils_src_configure
}
