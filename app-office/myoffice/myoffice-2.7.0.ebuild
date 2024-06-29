# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg unpacker

DESCRIPTION="office"
HOMEPAGE="https://myoffice.ru/products/standard-home-edition/"
SRC_URI="https://preset.myoffice-app.ru/myoffice-standard-home-edition_${PV}_amd64.deb"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# needs full qt stack
RDEPEND="dev-qt/qtwidgets:5"

S=${WORKDIR}

src_unpack() {
	unpack_deb ${A}
}

src_compile() { :; }

src_install() {
	dodir /opt
	cp -pPR "${S}/*" "${D}/" || die
}

