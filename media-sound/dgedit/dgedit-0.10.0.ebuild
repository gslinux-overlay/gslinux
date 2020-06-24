# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="DGEdit, the DrumGizmo drumkit editor"
HOMEPAGE="http://drumgizmo.org"

if [[ ${PV} == *9999* ]]; then
	inherit autotools git-r3
	EGIT_REPO_URI="http://git.drumgizmo.org/${PN}.git"
else
	SRC_URI="http://www.drumgizmo.org/releases/${P}/${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"

src_configure()
{
if [[ ${PV} == *9999* ]]; then
    eautoreconf
fi
	econf --prefix=/usr
}
