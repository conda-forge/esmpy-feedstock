#!/bin/sh

# Restore previous env vars if they were set.
unset ESMFMKFILE

if [ -n "${_CONDA_SET_ESMFMKFILE:-}" ]; then
    export ESMFMKFILE="${_CONDA_SET_ESMFMKFILE}"
    unset _CONDA_SET_ESMFMKFILE
fi
