# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/iurie-sw/geonkick/archive/v${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/iurie-sw/geonkick.git"
fi

DESCRIPTION="A free software percussion synthesizer"
HOMEPAGE="https://github.com/iurie-sw/geonkick"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/rapidjson
	media-libs/libsndfile
	media-libs/lv2
	x11-libs/redkite
"
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
