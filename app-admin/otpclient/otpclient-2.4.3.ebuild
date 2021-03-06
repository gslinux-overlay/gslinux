# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils xdg-utils

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/paolostivanin/OTPClient/archive/v${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S=${WORKDIR}/OTPClient-${PV}
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/paolostivanin/OTPClient.git"
fi

DESCRIPTION="Highly secure and easy to use GTK+ software for two-factor authentication that supports both Time-based One-time Passwords (TOTP) and HMAC-Based One-Time Passwords (HOTP)"
HOMEPAGE="https://github.com/paolostivanin/OTPClient/"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
        >=x11-libs/gtk+-3.22
        >=dev-libs/glib-2.50
        >=dev-libs/jansson-2.6.0
        >=dev-libs/libgcrypt-1.6.0
        >=dev-libs/libzip-1.0.0
        >=media-libs/libpng-1.2.0
        >=dev-libs/libcotp-1.2.1
        >=media-gfx/zbar-0.10
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
	)
		
    cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	gunzip -f "${ED}"/usr/share/man/man1/*.gz || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
