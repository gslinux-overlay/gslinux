# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# The order is important here! Both, cmake-utils and xdg define src_prepare.
# We need the one from cmake-utils
inherit git-r3

DESCRIPTION="Matrix Mixer & Trigger (Pre-Processor for Oscilloscope)"
HOMEPAGE="https://x42-plugins.com/x42/x42-mixtrix"
EGIT_REPO_URI="https://github.com/x42/mixtri.lv2.git"

LICENSE="GPL-2"
SLOT="0"

IUSE=""

RDEPEND="
	media-libs/lv2
	x11-libs/pango
	x11-libs/gtk+:2
	x11-libs/cairo
	virtual/opengl
	media-libs/libltc
	media-libs/libsamplerate
"

src_prepare() {
	default
}

src_configure() {
	true
}

src_compile() {
	emake
}
src_install() {
	emake install PREFIX="${D}/usr"
}
