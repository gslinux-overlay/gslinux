# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# The order is important here! Both, cmake-utils and xdg define src_prepare.
# We need the one from cmake-utils
inherit git-r3

DESCRIPTION="Audio Level Meters"
HOMEPAGE="https://x42-plugins.com/x42/x42-repitch"
EGIT_REPO_URI="https://github.com/x42/repitch.lv2.git"

LICENSE="GPL-2"
SLOT="0"

IUSE=""

RDEPEND="
	media-libs/lv2
"

src_compile() {
	emake
}
src_install() {
	emake install PREFIX="${D}/usr"
}
