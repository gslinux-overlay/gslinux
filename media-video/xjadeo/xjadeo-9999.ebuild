# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/x42/xjadeo/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/x42/xjadeo.git"
fi

DESCRIPTION="xjadeo is a simple video player that gets sync from jack"
HOMEPAGE="http://xjadeo.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="media-video/ffmpeg
	x11-libs/libX11
	media-libs/libltc
	media-libs/glu
	virtual/jack"

DEPEND="${RDEPEND}
	media-libs/glu
	x11-libs/libXv"

src_prepare() {
	default

	eautoreconf
}
src_configure() {
	econf \
		--prefix=/usr \
		--disable-portmidi \
		--enable-xinerama \
		--sysconfdir=/etc/xjadeo \
		--enable-contrib \
		--enable-embed-font
}
