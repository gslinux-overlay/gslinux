# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.77.0
QTMIN=5.15.0
ECM_TEST=forceoptional
inherit ecm

DESCRIPTION="Mastodon client for Plasma and Plasma Mobile"
HOMEPAGE="https://invent.kde.org/network/tokodon"
# SRC_URI="mirror://kde/stable/${PN}/${P}.tar.xz"
SRC_URI="https://invent.kde.org/network/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"


LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64"
S=${PN}-v${PV}
DEPEND="
	>=dev-libs/kirigami-addons-0.6:5
	dev-libs/qtkeychain[qt5(+)]
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtmultimedia-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
	>=dev-qt/qtwebsockets-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kconfigwidgets-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kdbusaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/kitemmodels-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
	>=kde-frameworks/kwindowsystem-${KFMIN}:5
	>=kde-frameworks/qqc2-desktop-style-${KFMIN}:5
	>=kde-frameworks/sonnet-${KFMIN}:5
"
RDEPEND="${DEPEND}"

src_test() {
	local -x QT_QPA_PLATFORM=offscreen
	ecm_src_test
}
