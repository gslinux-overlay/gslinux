# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

V_DPF="08669d1bc30c6e971fde800eade4ca40104ba8b2"
SRC_URI="
	https://github.com/zamaudio/zam-plugins/archive/${PV}.tar.gz  -> ${P}.tar.gz
	https://github.com/DISTRHO/DPF/archive/${V_DPF}.tar.gz -> dpf-${V_DPF}.tar.gz
"
KEYWORDS="~amd64"

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

src_unpack() {
	default
	rm -rf "${S}/dpf" || die
	cp -r "${WORKDIR}/DPF-${V_DPF}" "${S}/dpf" || die
}

src_compile() {
	emake SKIP_STRIPPING=true
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LIBDIR="$(get_libdir)" install
}
