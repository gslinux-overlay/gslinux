# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils xdg-utils

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://codeload.github.com/tsujan/${PN}/tar.gz/V${PV} -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	MY_P="${P/arqiver/Arqiver}"
	S="${WORKDIR}/${MY_P}"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tsujan/${PN}.git"
fi

DESCRIPTION="Is a simple Qt5 archive manager as a front-end for libarchive (bsdtar), gzip and 7z"
HOMEPAGE="https://github.com/tsujan/Arqiver"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtx11extras:5
	dev-qt/qtsvg:5"

DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

src_configure() {
	eqmake5
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${ED}" install
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
