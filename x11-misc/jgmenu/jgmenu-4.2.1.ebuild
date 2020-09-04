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
IUSE="gtk lxde openbox xfce"

RDEPEND="
	lxde? ( lxde-base/menu-cache )
	openbox? ( dev-libs/libxml2 )
	xfce? ( xfce-base/xfce4-panel )
	dev-libs/glib
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/cairo
	x11-libs/pango
	gnome-base/librsvg"
DEPEND="${RDEPEND}"

src_configure() {
	local myconf=(
		$(usex gtk '--with-gtktheme' '')
		$(usex lxde '--with-lx' '')
		$(usex xfce '--with-xfce4-panel-applet' '')
	)

	econf "${myconf[@]}"
}

src_install() {
	emake \
		DESTDIR="$D" \
		prefix="/usr" \
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
