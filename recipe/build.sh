#!/bin/bash

export ESMFMKFILE=${PREFIX}/lib/esmf.mk

cd ${SRC_DIR}/src/addon/esmpy

# this is an unused dumping grounds and causes disconcerting warnings
rm -rf src/esmpy/fragments


${PYTHON} -m pip install . -vv --no-deps --no-build-isolation

if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
    export ESMF_MPIRUN=${SRC_DIR}/src/Infrastructure/stubs/mpiuni/mpirun
    export ESMPY_DATA_NEW_DIR=${SRC_DIR}/test_data
    make test_serial
fi

for shell in sh csh fish
do
  for act_deact in activate deactivate
  do
    act_deact_dir=${PREFIX}/etc/conda/${act_deact}.d
    mkdir -p ${act_deact_dir}
    cp ${RECIPE_DIR}/scripts/${act_deact}.${shell} ${act_deact_dir}/esmpy-${act_deact}.${shell}
  done
done
