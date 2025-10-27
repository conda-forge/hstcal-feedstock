#!/bin/bash
set -x
export CFLAGS="$CFLAGS -Wno-incompatible-pointer-types"
export CFLAGS="$CFLAGS -D_GNU_SOURCE"

if [[ $target_platform == osx-* ]]; then
    export PATH="${RECIPE_DIR}/fake-bin:$PATH"
    export FFLAGS="$FFLAGS -isysroot $CONDA_BUILD_SYSROOT"
fi

patch -p0 < ${RECIPE_DIR}/no_sizeof.patch
./waf configure --prefix=${PREFIX} --release-with-symbols
./waf build
./waf install

