#!/bin/bash
set -x
export CFLAGS="$CFLAGS -Wno-incompatible-pointer-types"
export CFLAGS="$CFLAGS -D_GNU_SOURCE"

if [[ $target_platform == osx-* ]]; then
    export PATH="${RECIPE_DIR}/fake-bin:$PATH"
    export FFLAGS="$FFLAGS -isysroot $CONDA_BUILD_SYSROOT"
fi

mkdir -p build
cd build
cmake .. \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo

make

make install
