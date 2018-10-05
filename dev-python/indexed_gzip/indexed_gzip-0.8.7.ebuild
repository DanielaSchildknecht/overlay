# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1 virtualx

DESCRIPTION="Fast random access of gzip files in Python"
HOMEPAGE="https://github.com/pauldmccarthy/indexed_gzip"
SRC_URI="https://github.com/pauldmccarthy/indexed_gzip/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
	)
	"
RDEPEND=""

src_compile() {
	if use test; then
		export INDEXED_GZIP_TESTING=1
	fi
	distutils-r1_src_compile
}

python_test() {
	cp conftest.py "${BUILD_DIR}"
	cd "${BUILD_DIR}" || die
	pytest -v -s || die
}