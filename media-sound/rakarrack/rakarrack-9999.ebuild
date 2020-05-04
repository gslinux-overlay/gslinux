# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Re-hosted from SourceForge

EAPI=5

inherit git-r3 autotools-utils

DESCRIPTION="Richly featured multi-effects processor emulating a guitar effects pedalboard"
HOMEPAGE="http://rakarrack.sourceforge.net/"
EGIT_REPO_URI="git://rakarrack.git.sourceforge.net/gitroot/rakarrack/rakarrack"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="altivec sse sse2"

RDEPEND="x11-libs/fltk:1
	x11-libs/libXpm
	>=media-libs/alsa-lib-0.9
	media-libs/libsamplerate
	media-libs/libsndfile
	>=media-sound/alsa-utils-0.9
	virtual/jack"
DEPEND="${RDEPEND}"

# PATCHES=( "${FILESDIR}/${P}-assume-fltk.patch" )

AUTOTOOLS_AUTORECONF="1"

src_configure() {
	local myeconfargs=(
		$(use_enable altivec)
		$(use_enable sse)
		$(use_enable sse2)
	)
	autotools-utils_src_configure
}
