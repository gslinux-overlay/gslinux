# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Kapitonov-Plugins-Pack - set of plugins for guitar sound processing"
HOMEPAGE="https://github.com/olegkapitonov/Kapitonov-Plugins-Pack"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
    EGIT_REPO_URI="https://github.com/olegkapitonov/Kapitonov-Plugins-Pack.git"
else
	SRC_URI="https://github.com/olegkapitonov/Kapitonov-Plugins-Pack/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/Kapitonov-Plugins-Pack-${PV}"
fi
LICENSE="GPL-2"
SLOT="0"

CDEPEND="
	virtual/jack
	x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/cairo
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/pixman
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng
	x11-libs/libxcb
	x11-libs/libXrender
	x11-libs/libX11
	x11-libs/libXext
	sys-libs/zlib
	dev-libs/libbsd
	dev-libs/expat
	sci-libs/fftw:3.0
	dev-libs/boost
	media-libs/lv2
	media-libs/ladspa-sdk
	media-libs/zita-resampler
	media-libs/zita-convolver
	dev-util/meson
	=dev-lang/faust-9999
"
RDEPEND="${CDEPEND}"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
        -Dladspadir=/usr/$(get_libdir)/ladspa
        -Dlv2dir=/usr/$(get_libdir)/lv2
    )
	meson_src_configure
}
