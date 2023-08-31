#!/usr/bin/env csh

# Store existing env vars and set to this conda env
# so other installs don't pollute the environment.

if ( $?ESMFMKFILE ) then
  setenv _CONDA_SET_ESMFMKFILE "$ESMFMKFILE"
endif

if ( -f "${CONDA_PREFIX}/lib/esmf.mk" ) then
  setenv ESMFMKFILE "${CONDA_PREFIX}/lib/esmf.mk"
else if ( -f "${CONDA_PREFIX}/Library/lib/esmf.mk" ) then
  setenv ESMFMKFILE "${CONDA_PREFIX}/Library/lib/esmf.mk"
endif
