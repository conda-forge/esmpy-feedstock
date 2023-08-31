:: Store existing env vars and set to this conda env
:: so other installs don't pollute the environment.

@if defined ESMFMKFILE (
    set "_CONDA_SET_ESMFMKFILE=%ESMFMKFILE%"
)
@set "ESMFMKFILE=%CONDA_PREFIX%\Library\lib\esmf.mk"
