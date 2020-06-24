# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ $PV == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/johanmalm/jgmenu.git"
	KEYWORDS=""
else
	MY_PV="v${PV}"
	SRC_URI="https://github.com/johanmalm/${PN}/archive/${MY_PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit xdg-utils

DESCRIPTION="A small X11 menu"
HOMEPAGE="https://github.com/johanmalm/jgmenu/wiki"
LICENSE="GPL-2"
SLOT="0"
IUSE="-lxde -openbox"

RDEPEND="
	lxde? ( lxde-base/menu-cache dev-libs/glib )
	openbox? ( dev-libs/libxml2 )
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/cairo
	x11-libs/pango
	gnome-base/librsvg"
DEPEND="${RDEPEND}"

src_compile() {
	emake $(usex lxde "" "NOLX=1") all
}

src_install() {
	emake \
		DESTDIR="$D" \
		prefix="/usr" \
		$(usex lxde "" "NOLX=1") \
		install
	einstalldocs
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
