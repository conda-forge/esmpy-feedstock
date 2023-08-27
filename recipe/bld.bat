set "ESMFMKFILE=%PREFIX%/lib/esmf.mk"

cd %SRC_DIR%\src\addon\esmpy

rem rd /s "src\esmpy\fragments"


%PYTHON% -m pip install .

if errorlevel 1 exit 1

