#!/usr/bin/env fish

if set -q ESMFMKFILE
  set -gx _CONDA_SET_ESMFMKFILE "$ESMFMKFILE"
end

if test -f "$CONDA_PREFIX/lib/esmf.mk"
  set -gx ESMFMKFILE "$CONDA_PREFIX/lib/esmf.mk"
else if test -f "$CONDA_PREFIX/Library/lib/esmf.mk"
  set -gx ESMFMKFILE "$CONDA_PREFIX/Library/lib/esmf.mk"
end
