# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# The order is important here! Both, cmake-utils and xdg define src_prepare.
# We need the one from cmake-utils
inherit xdg cmake-utils

DESCRIPTION="The Linux (midi) MUSic Editor (a sequencer)"
HOMEPAGE="http://muse-sequencer.org/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/muse-sequencer/muse.git"
	S="${WORKDIR}/muse/src"
	PATCHES=("${FILESDIR}"/museseq-cmake-rpath-${PV}.patch)
else
    SRC_URI="https://github.com/muse-sequencer/muse/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/muse-${PV}/src"
	PATCHES=("${FILESDIR}"/museseq-cmake-rpath.patch)
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="alsa dssi fluidsynth ladspa lash lv2 osc python realtime -static vst"

COMMON_DEPEND="
	media-libs/alsa-lib
	>=media-libs/libsamplerate-0.1.8
	>=media-libs/libsndfile-1.0.11
	virtual/jack
	virtual/pkgconfig
	dev-qt/designer:5
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtxml:5
	dev-qt/qtgui:5
	dev-qt/qthelp:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtquickcontrols2:5
	>=dev-qt/qtsingleapplication-2.6.1_p20171024[X]
	dev-qt/qtsvg:5
	dev-qt/qtxmlpatterns:5
	python? ( ${PYTHON_DEPS} )
	dssi? ( >=media-libs/dssi-0.9.0 )
	lash? ( >=media-sound/lash-0.4.0 )
	ladspa? ( media-libs/liblrdf )
	osc? ( >=media-libs/liblo-0.23 )
	lv2? (
		media-libs/lv2
		x11-libs/gtk+:2
		dev-cpp/gtkmm:2.4 )
	fluidsynth? ( media-sound/fluidsynth )
	realtime? ( media-libs/rtaudio )
"
BDEPEND="
	dev-qt/linguist-tools:5
"

PATCHES=("${FILESDIR}"/museseq-cmake-rpath.patch)

src_configure() {
	local mycmakeargs+=(
		-DCMAKE_INSTALL_PREFIX:PATH=/usr
		-DCMAKE_BUILD_TYPE=release
		-DENABLE_LRDF=$(usex ladspa ON OFF)
		-DENABLE_ALSA=$(usex alsa ON OFF)
		-DENABLE_LASH=$(usex lash ON OFF)
		-DENABLE_DSSI=$(usex dssi ON OFF)
		-DENABLE_LV2=$(usex lv2 ON OFF)
		-DENABLE_LV2_GTK2=OFF
		-DENABLE_OSC=$(usex osc ON OFF)
		-DENABLE_PYTHON=$(usex python ON OFF)
		-DENABLE_RTAUDIO=$(usex realtime ON OFF)
		-DMODULES_BUILD_STATIC=$(usex static ON OFF)
		-DENABLE_VST=OFF
		-DENABLE_VST_VESTIGE=OFF
		-DENABLE_VST_NATIVE=$(usex vst ON OFF)
		-DENABLE_FLUID=$(usex fluidsynth ON OFF)
	)
	cmake-utils_src_configure
}
