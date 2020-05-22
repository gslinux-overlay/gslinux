# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="A synthesizer that can synthesize elements of percussion"
HOMEPAGE="https://github.com/iurie-sw/geonkick"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/iurie-sw/geonkick.git"
else
	SRC_URI="https://github.com/iurie-sw/geonkick/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi
LICENSE="GPL-2"
SLOT="0"

IUSE=""

RDEPEND="
    dev-util/redkite
    virtual/jack
    dev-libs/rapidjson
    media-libs/libsndfile
	media-libs/lv2"
DEPEND="${RDEPEND}"

src_configure() {
	cmake-utils_src_configure
}
