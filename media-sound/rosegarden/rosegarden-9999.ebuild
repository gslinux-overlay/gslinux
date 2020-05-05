# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils xdg subversion

DESCRIPTION="MIDI and audio sequencer and notation editor"
HOMEPAGE="https://www.rosegardenmusic.com/"
ESVN_REPO_URI="https://svn.code.sf.net/p/rosegarden/code/trunk/rosegarden"
ESVN_PROJECT="rosegarden-code"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="lirc"

BDEPEND="
	dev-qt/linguist-tools:5
	virtual/pkgconfig
"
RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/alsa-lib:=
	>=media-libs/dssi-1.0.0:=
	media-libs/ladspa-sdk:=
	media-libs/liblo:=
	media-libs/liblrdf:=
	media-libs/libsamplerate:=
	media-libs/libsndfile:=
	sci-libs/fftw:3.0
	sys-libs/zlib:=
	virtual/jack
	x11-libs/libSM:=
	lirc? ( app-misc/lirc:= )
"
DEPEND="${RDEPEND}
	dev-qt/qttest:5
"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		"-DDISABLE_LIRC=$(usex lirc OFF ON)"
	)
	cmake-utils_src_configure
}

pkg_postinst(){
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm(){
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}
