# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Create a kwallet like functionality for lxqt"
HOMEPAGE="https://lxqt.org/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/lxqt_wallet.git"
else
	SRC_URI="https://github.com/lxqt/lxqt_wallet/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="amd64 arm arm64 x86"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="-gnome -kde"

BDEPEND="
	dev-qt/linguist-tools:5
"
RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
"
DEPEND="
	${RDEPEND}
	gnome? ( app-crypt/libsecret )
	kde? ( kde-frameworks/kwallet:5 )
"


src_configure() {
	local mycmakeargs=(
		-DNOKDESUPPORT=$(!usex kde)
		-DNOSECRETSUPPORT=$(!usex gnome)
		-DCMAKE_INSTALL_PREFIX=/usr
		-DCMAKE_BUILD_TYPE=RELEASE
	)
		
    cmake-utils_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
