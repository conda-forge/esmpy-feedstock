#!/bin/bash

export ESMFMKFILE=${PREFIX}/lib/esmf.mk

cd ${SRC_DIR}/src/addon/esmpy

# this is an unused dumping grounds and causes disconcerting warnings
rm -rf src/esmpy/fragments


${PYTHON} -m pip install .

if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
    export ESMF_MPIRUN=${SRC_DIR}/src/Infrastructure/stubs/mpiuni/mpirun
    make test_serial
fi

