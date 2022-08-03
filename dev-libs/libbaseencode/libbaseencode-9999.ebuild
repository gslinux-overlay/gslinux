# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/paolostivanin/libbaseencode/archive/v${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/paolostivanin/libbaseencode.git"
fi

DESCRIPTION="Library written in C for encoding and decoding data using base32 or base64 according to RFC-4648"
HOMEPAGE="https://github.com/paolostivanin/libbaseencode/"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
	)
		
    cmake-utils_src_configure
}
