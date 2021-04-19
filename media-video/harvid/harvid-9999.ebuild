# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/x42/harvid/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/x42/harvid.git"
fi

DESCRIPTION="Harvid decodes still images from movie files and serves them via HTTP"
HOMEPAGE="https://github.com/x42/harvid"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="media-video/ffmpeg"

DEPEND="${RDEPEND}
	media-libs/libpng"
