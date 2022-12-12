#!/bin/bash

export ESMFMKFILE=${PREFIX}/lib/esmf.mk

cd ${SRC_DIR}/src/addon/ESMPy


${PYTHON} setup.py build --ESMFMKFILE=${ESMFMKFILE}
if [[ $(uname) != Darwin ]]; then
    ${PYTHON} setup.py test
fi
${PYTHON} setup.py install --record record.txt
