# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
inherit eutils

DESCRIPTION="Vietnamese Input Method Engine for IBUS using Unikey IME"
HOMEPAGE="https://code.google.com/p/ibus-unikey/"
SRC_URI="https://ibus-unikey.googlecode.com/files/${P}.tar.gz
	https://dev.gentoo.org/~dlan/distfiles/${P}-gcc6.patch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3"

RDEPEND="gtk3? ( >app-i18n/ibus-1.4.0[gtk]
		x11-libs/gtk+:3 )
	!gtk3? ( >=app-i18n/ibus-1.4.0[gtk2]
		>=x11-libs/gtk+-2.12:2 )
	x11-libs/libX11"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool
	>=sys-devel/gettext-0.17"

src_prepare() {
	epatch "${DISTDIR}"/${P}-gcc6.patch
}

src_configure() {
	use gtk3 && myconf="--with-gtk-version=3" || myconf=""
	econf ${myconf}
}
