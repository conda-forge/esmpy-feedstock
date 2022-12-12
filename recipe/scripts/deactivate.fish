#!/usr/bin/env fish

# Restore previous env vars if they were set.
set -e ESMFMKFILE

if set -q _CONDA_SET_ESMFMKFILE
    set -gx  ESMFMKFILE "$_CONDA_SET_ESMFMKFILE"
    set -e _CONDA_SET_ESMFMKFILE
end
