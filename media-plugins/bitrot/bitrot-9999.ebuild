# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )
PYTHON_REQ_USE="threads(+)"
inherit git-r3 python-any-r1 waf-utils

DESCRIPTION="Audio effect plugins (LV2, VST2, LADSPA) for glitch effects"
HOMEPAGE="https://github.com/grejppi/bitrot"
EGIT_REPO_URI="https://github.com/grejppi/bitrot.git"
SLOT="0"

IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_configure() {
	local mywafconfargs=(
		--platform linux64
	)
	waf-utils_src_configure ${mywafconfargs[@]}
}

src_install() {
	DESTDIR="${D}" waf-utils_src_install
}
