#!/bin/bash

export ESMFMKFILE=${PREFIX}/lib/esmf.mk

ESMPY_SRC=${SRC_DIR}/src/addon/ESMPy
cd ${ESMPY_SRC}


${PYTHON} setup.py build --ESMFMKFILE=${ESMFMKFILE}
${PYTHON} setup.py install --record record.txt
${PYTHON} setup.py test || exit 1
