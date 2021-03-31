# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

EGIT_REPO_URI="https://github.com/michaelwillis/dragonfly-reverb.git"
if [[ ${PV} != *9999* ]]; then
	EGIT_COMMIT=${PV} # The DPF submodule has no tags
	KEYWORDS="~amd64"
fi

DESCRIPTION="A set of free reverb effects"
HOMEPAGE="https://michaelwillis.github.io/dragonfly-reverb/"
LICENSE="GPL-3"
SLOT="0"
IUSE="system-freeverb3" # Enabling this breaks the build for now

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	system-freeverb3? ( media-libs/freeverb3 )
	system-freeverb3? ( media-libs/libsamplerate )
	virtual/jack
	x11-libs/libX11
"

src_compile() {
	export SKIP_STRIPPING=true
	if use system-freeverb3; then
		export SYSTEM_FREEVERB3=true
	fi
	default_src_compile
}

src_install() {
	dobin bin/DragonflyEarlyReflections
	dobin bin/DragonflyPlateReverb
	dobin bin/DragonflyHallReverb
	dobin bin/DragonflyRoomReverb
	dodir /usr/$(get_libdir)/vst
	cp "${S}/bin/DragonflyEarlyReflections-vst.so" "${D}/usr/$(get_libdir)/vst"
	cp "${S}/bin/DragonflyPlateReverb-vst.so" "${D}/usr/$(get_libdir)/vst"
	cp "${S}/bin/DragonflyHallReverb-vst.so" "${D}/usr/$(get_libdir)/vst"
	cp "${S}/bin/DragonflyRoomReverb-vst.so" "${D}/usr/$(get_libdir)/vst"
	dodir /usr/$(get_libdir)/lv2
	cp -r "${S}/bin/DragonflyEarlyReflections.lv2" "${D}/usr/$(get_libdir)/lv2"
	cp -r "${S}/bin/DragonflyPlateReverb.lv2" "${D}/usr/$(get_libdir)/lv2"
	cp -r "${S}/bin/DragonflyHallReverb.lv2" "${D}/usr/$(get_libdir)/lv2"
	cp -r "${S}/bin/DragonflyRoomReverb.lv2" "${D}/usr/$(get_libdir)/lv2"
}
