# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="git://anongit.freedesktop.org/git/libreoffice/libcdr/"
[[ ${PV} == 9999 ]] && inherit autotools git-r3

DESCRIPTION="Library parsing the Corel cdr documents"
HOMEPAGE="https://wiki.documentfoundation.org/DLP/Libraries/libcdr"
[[ ${PV} == 9999 ]] || SRC_URI="http://dev-www.libreoffice.org/src/${PN}/${P}.tar.xz"

LICENSE="MPL-2.0"
SLOT="0"
[[ ${PV} == 9999 ]] || \
KEYWORDS="amd64 ~arm ~hppa ~ppc ppc64 x86"
IUSE="doc static-libs test"

RDEPEND="
	dev-libs/icu:=
	dev-libs/librevenge
	media-libs/lcms:2
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	dev-libs/boost
	sys-devel/libtool
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
	test? ( dev-util/cppunit )
"

src_prepare() {
	default
	[[ -d m4 ]] || mkdir "m4"
	[[ ${PV} == 9999 ]] && eautoreconf
}

src_configure() {
	econf \
		--disable-werror \
		$(use_with doc docs) \
		$(use_enable static-libs static) \
		$(use_enable test tests)
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
