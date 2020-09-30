# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/tomszilagyi/tap-plugins/archive/v${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tomszilagyi/tap-plugins.git"
fi

DESCRIPTION="Tom's Audio Processing LADSPA plugins"
HOMEPAGE="http://tap-plugins.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	emake INSTALL_PLUGINS_DIR="${D}/usr/$(get_libdir)/ladspa/" INSTALL_LRDF_DIR="${D}/usr/share/ladspa/rdf/" install
}
