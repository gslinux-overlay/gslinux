# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/kometbomb/klystrack.git"

inherit git-r3

DESCRIPTION="A really cool fakebit tracker"
HOMEPAGE="http://kometbomb.github.io/klystrack/"
LICENSE="MIT"
SLOT="0"

DEPEND="
	media-libs/libsdl2
	media-libs/sdl2-image
"
RDEPEND="${DEPEND}"
BDEPEND=""
