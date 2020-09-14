# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Virtual analogue synthesizer"
HOMEPAGE="https://github.com/amsynth/amsynth"

if [[ ${PV} == *9999* ]]; then
	inherit autotools git-r3
	EGIT_REPO_URI="https://github.com/amsynth/amsynth.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/${PN}/${PN}/releases/download/release-${PV}/${P}.tar.bz2"
	KEYWORDS="amd64 ~ppc x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="alsa dssi gtk jack lash lv2 oss sndfile"

REQUIRED_USE="dssi? ( gtk ) lv2? ( gtk )"

BDEPEND="
	virtual/pkgconfig
"
RDEPEND="
	alsa? (
		media-libs/alsa-lib:=
		media-sound/alsa-utils
	)
	dssi? (
		media-libs/dssi:=
		media-libs/liblo:=
	)
	gtk? ( >=x11-libs/gtk+-2.20:2 )
	jack? ( virtual/jack )
	lash? ( media-sound/lash )
	lv2? ( media-libs/lv2 )
	sndfile? ( >=media-libs/libsndfile-1:= )
"
DEPEND="${RDEPEND}
	oss? ( virtual/os-headers )
"

src_configure() {
if [[ ${PV} == *9999* ]]; then
    eautoreconf
fi
	append-cxxflags -std=c++11
	econf \
		$(use_with oss) \
		$(use_with alsa) \
		$(use_with gtk gui) \
		$(use_with jack) \
		$(use_with lash) \
		$(use_with lv2) \
		$(use_with sndfile) \
		$(use_with dssi)
}
