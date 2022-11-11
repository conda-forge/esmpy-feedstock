:: Restore previous GDAL env vars if they were set.

@set "ESMFMKFILE="
@if defined _CONDA_SET_ESMFMKFILE (
  set "ESMFMKFILE=%_CONDA_SET_ESMFMKFILE%"
  set "_CONDA_SET_ESMFMKFILE="
)
