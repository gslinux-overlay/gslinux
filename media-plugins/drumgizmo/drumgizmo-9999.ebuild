# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Open source cross-platform drum plugin & stand-alone application."
HOMEPAGE="http://drumgizmo.org"

if [[ ${PV} == *9999* ]]; then
	inherit autotools git-r3
	EGIT_REPO_URI="http://git.drumgizmo.org/drumgizmo.git"
else
	SRC_URI="http://www.drumgizmo.org/releases/${P}/${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND="virtual/jack
	media-libs/lv2
	x11-libs/libX11
	media-libs/libsndfile
	media-libs/zita-resampler
	dev-libs/expat
	media-libs/libsmf"
DEPEND="${RDEPEND}"

src_configure()
{
if [[ ${PV} == *9999* ]]; then
    eautoreconf
fi
	econf --enable-lv2
}
