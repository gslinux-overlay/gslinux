# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson xdg-utils

DESCRIPTION="Standalone software guitar processor, editor of *.tapf profile files for tubeAmp (KPP) and guitar amp profiler"
HOMEPAGE="https://github.com/olegkapitonov/tubeAmp-Designer"
EGIT_REPO_URI="https://github.com/olegkapitonov/tubeAmp-Designer.git"
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

CDEPEND="
	virtual/jack
	sci-libs/gsl
	dev-qt/qtcore
	dev-qt/qtchooser
	sci-libs/fftw:3.0
	media-libs/zita-resampler
	media-libs/zita-convolver
	dev-util/meson
	=dev-lang/faust-9999
"
RDEPEND="${CDEPEND}"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		--prefix /usr
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
