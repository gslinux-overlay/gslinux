# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Dedicated AVLDrumkits LV2 Plugin"
HOMEPAGE="https://x42-plugins.com/x42/x42-avldrums"
EGIT_REPO_URI="https://github.com/x42/avldrums.lv2.git"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"

RDEPEND="
	media-libs/lv2
	x11-libs/pango
	dev-libs/glib
	x11-libs/cairo
	virtual/opengl
	media-libs/libsamplerate
"
src_compile() {
	emake
}
src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LV2DIR="/usr/$(get_libdir)/lv2" install
}
