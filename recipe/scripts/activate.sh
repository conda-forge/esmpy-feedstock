#!/bin/sh

# Store existing env vars and set to this conda env
# so other installs don't pollute the environment.

if [ -n "${ESMFMKFILE:-}" ]; then
    export _CONDA_SET_ESMFMKFILE=$ESMFMKFILE
fi


if [ -f "${CONDA_PREFIX}/lib/esmf.mk" ]; then
  export ESMFMKFILE="${CONDA_PREFIX}/lib/esmf.mk"
elif [ -f "${CONDA_PREFIX}/Library/lib/esmf.mk" ]; then
  export ESMFMKFILE="${CONDA_PREFIX}/Library/lib/esmf.mk"
fi
