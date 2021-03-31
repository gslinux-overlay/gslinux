# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
inherit python-r1 xdg-utils

DESCRIPTION="Agordejo (Esperanto: ‘place to set things up’) is a music production session manager."
HOMEPAGE="https://www.laborejo.org/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.laborejo.org/lss/${PN}.git"
else
	SRC_URI="https://www.laborejo.org/downloads/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	sys-libs/glibc
	dev-python/PyQt5
	media-fonts/dejavu
	media-sound/new-session-manager[-gui]
	sys-apps/grep
"
DEPEND="${RDEPEND}"

src_configure()
{
	econf --prefix=/usr
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
