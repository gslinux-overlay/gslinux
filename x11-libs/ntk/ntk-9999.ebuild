# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )
PYTHON_REQ_USE="threads(+)"
inherit python-any-r1 waf-utils

DESCRIPTION="Fast Light ToolKit fork, adding improved graphics rendering via Cairo"
HOMEPAGE="http://non.tuxfamily.org/wiki/NTK"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.tuxfamily.org/non/fltk.git"
else
	SRC_URI="https://git.tuxfamily.org/non/fltk.git/snapshot/fltk-${PV}.tar.gz"
	KEYWORDS="amd64 x86"
	S=${WORKDIR}/fltk-${PV}
fi

RESTRICT="test"

# LICENSE="FLTK LGPL-2"
SLOT="0"

IUSE="debug +opengl png"

RDEPEND="
    media-libs/fontconfig
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libXft
	virtual/jpeg:*
	opengl? ( media-libs/glu )
	png? ( media-libs/libpng:* )
"
DEPEND="${RDEPEND}"

DOCS=( ANNOUNCEMENT CREDITS README )
PATCHES=(
	"${FILESDIR}"/noldconfig-r1.patch
	"${FILESDIR}"/nooptimize.patch
)

src_configure() {
	local mywafconfargs=(
		$(usex debug --enable-debug "")
		$(usex opengl --enable-gl "")
	)
	waf-utils_src_configure ${mywafconfargs[@]}
}

src_install() {
	DESTDIR="${D}" waf-utils_src_install
}
