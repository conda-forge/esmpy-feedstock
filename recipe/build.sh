#!/bin/bash

export ESMFMKFILE=${PREFIX}/lib/esmf.mk

cd ${SRC_DIR}/src/addon/ESMPy


${PYTHON} setup.py build --ESMFMKFILE=${ESMFMKFILE}
${PYTHON} setup.py test
${PYTHON} setup.py install --record record.txt
