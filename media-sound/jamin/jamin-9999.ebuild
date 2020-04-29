# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools git-r3 xdg-utils

DESCRIPTION="JAMin is the JACK Audio Connection Kit (JACK) Audio Mastering interface"
HOMEPAGE="http://jamin.sourceforge.net"
EGIT_REPO_URI="https://git.code.sf.net/p/jamin/code jamin-code"

LICENSE="GPL-2"
SLOT="0"

IUSE="osc"

RDEPEND="
	>=dev-libs/libxml2-2.5
	>=media-plugins/swh-plugins-0.4.6
	virtual/jack
	>=sci-libs/fftw-3.0.1
	>=x11-libs/gtk+-3:3
	>=media-libs/clutter-1.12.0
	>=media-libs/clutter-gtk-1.2.0
	media-libs/alsa-lib
	media-libs/ladspa-sdk
	media-libs/libsndfile
	osc? ( >=media-libs/liblo-0.5 )
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable osc)
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
