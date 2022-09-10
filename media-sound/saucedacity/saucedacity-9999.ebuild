# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
WX_GTK_VER="3.0-gtk3"
PYTHON_COMPAT=( python3_{8..11} )

inherit cmake flag-o-matic python-single-r1 wxwidgets xdg

DESCRIPTION="Audacity fork without any telemetry"
HOMEPAGE="https://github.com/${PN}/${PN}"

if [[ "${PV}" != 9999 ]] ; then
	SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	         $SRC_URI"
	S="${WORKDIR}/${P}"
    KEYWORDS="~amd64 ~arm64 ~mips ~ppc ~ppc64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}"
	CMAKE_BUILD_TYPE="Release"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="alsa ffmpeg +flac id3tag jack +ladspa +lv2 mad ogg oss
	portmidi +portmixer portsmf sbsms twolame vamp +vorbis +vst"

RESTRICT="test"

RDEPEND="
	${PYTHON_DEPS}
	virtual/opengl
	sys-libs/zlib
	dev-libs/expat
	media-libs/libsndfile
	media-libs/libsoundtouch
	media-libs/portaudio[alsa?]
	media-libs/soxr
	>=media-sound/lame-3.100-r3
	x11-libs/wxGTK[X]
	alsa? ( media-libs/alsa-lib )
	ffmpeg? ( media-video/ffmpeg:= )
	flac? ( media-libs/flac[cxx] )
	id3tag? ( media-libs/libid3tag )
	jack? ( virtual/jack )
	lv2? (
		dev-libs/serd
		dev-libs/sord
		>=media-libs/lilv-0.24.6-r2
		media-libs/lv2
		media-libs/sratom
		media-libs/suil
	)
	mad? ( >=media-libs/libmad-0.15.1b )
	ogg? ( media-libs/libogg )
	portmidi? ( media-libs/portmidi )
	sbsms? ( media-libs/libsbsms )
	twolame? ( media-sound/twolame )
	vamp? ( media-libs/vamp-plugin-sdk )
	vorbis? ( media-libs/libvorbis )
"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip
	sys-devel/gettext
	virtual/pkgconfig
"

REQUIRED_USE="portmidi? ( portsmf )"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	setup-wxwidgets
	append-cxxflags -std=gnu++14

	# * always use system libraries if possible
	# * options listed in the order that cmake-gui lists them
	local mycmakeargs=(
#		--disable-dynamic-loading
		-Dsaucedacity_conan_enabled=Off
		-Dsaucedacity_lib_preference=system
		-Dsaucedacity_use_expat=system
		-Dsaucedacity_use_ffmpeg=$(usex ffmpeg loaded off)
		-Dsaucedacity_use_flac=$(usex flac system off)
		-Dsaucedacity_use_id3tag=$(usex id3tag system off)
		-Dsaucedacity_use_ladspa=$(usex ladspa)
		-Dsaucedacity_use_lame=system
		-Dsaucedacity_use_lv2=$(usex lv2 system off)
		-Dsaucedacity_use_mad=$(usex mad system off)
		-Dsaucedacity_use_midi=$(usex portmidi system off)
		-Dsaucedacity_use_nyquist=local
		-Dsaucedacity_use_ogg=$(usex ogg system off)
		-Dsaucedacity_use_pa_alsa=$(usex alsa)
		-Dsaucedacity_use_pa_jack=$(usex jack linked off)
		-Dsaucedacity_use_pa_oss=$(usex oss)
		#-Dsaucedacity_use_pch leaving it to the default behavior
		-Dsaucedacity_use_portaudio=local # only 'local' option is present
		-Dsaucedacity_use_portmixer=$(usex portmixer local off)
		-Dsaucedacity_use_portsmf=$(usex portsmf local off)
		-Dsaucedacity_use_sbsms=$(usex sbsms local off) # no 'system' option in configuration?
		-Dsaucedacity_use_sndfile=system
		-Dsaucedacity_use_soundtouch=system
		-Dsaucedacity_use_soxr=system
		-Dsaucedacity_use_twolame=$(usex twolame system off)
		-Dsaucedacity_use_vamp=$(usex vamp system off)
		-Dsaucedacity_use_vorbis=$(usex vorbis system off)
		-Dsaucedacity_use_vst=$(usex vst)
		-Dsaucedacity_use_wxwidgets=system # required, saucedacity needs wx >=3.1, Gentoo ships up to 3.0.5 currently
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
}
