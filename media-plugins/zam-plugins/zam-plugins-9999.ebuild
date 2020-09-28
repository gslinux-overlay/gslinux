# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/zamaudio/zam-plugins.git"

inherit git-r3

DESCRIPTION="A collection of high-quality audio plugins"
HOMEPAGE="http://www.zamaudio.com/?p=976"
LICENSE="GPL-2"
SLOT="0"

DEPEND="
	media-libs/ladspa-sdk
	media-libs/liblo
	virtual/jack
	virtual/opengl
	x11-libs/libX11
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_compile() {
	emake SKIP_STRIPPING=true
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LIBDIR="$(get_libdir)" install
}
