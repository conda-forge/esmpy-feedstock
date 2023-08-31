#!/usr/bin/env csh

# Restore previous env vars if they were set.
unsetenv ESMFMKFILE

if ( $?_CONDA_SET_ESMFMKFILE ) then
    setenv ESMFMKFILE "$_CONDA_SET_ESMFMKFILE"
    unsetenv _CONDA_SET_ESMFMKFILE
endif
