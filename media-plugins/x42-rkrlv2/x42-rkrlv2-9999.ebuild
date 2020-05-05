# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# The order is important here! Both, cmake-utils and xdg define src_prepare.
# We need the one from cmake-utils
inherit cmake-utils git-r3

DESCRIPTION="Rakarrack Effects Ported to LV2 Plugins"
HOMEPAGE="https://github.com/x42/rkrlv2"
EGIT_REPO_URI="https://github.com/x42/rkrlv2.git"

LICENSE="GPL-2"
SLOT="0"

IUSE=""

RDEPEND="
	media-libs/lv2
	sci-libs/fftw
"

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	emake
}
src_install() {
	emake install PREFIX="${D}/usr"
}
