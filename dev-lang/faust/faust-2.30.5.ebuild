# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Functional programming language for signal processing and sound synthesis"
HOMEPAGE="https://faust.grame.fr/"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/grame-cncm/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/grame-cncm/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
LICENSE="GPL-2"
SLOT="0"

RDEPEND=""
DEPEND="sys-apps/sed"

src_configure() {
	sed -i 's/\/usr\/local/\/usr/' Makefile
}
