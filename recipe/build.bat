set "ESMFMKFILE=%PREFIX%/lib/esmf.mk"

cd %SRC_DIR%\src\addon\esmpy

rem rd /s "src\esmpy\fragments"


%PYTHON% -m pip install . -vv --no-deps --no-build-isolation

if errorlevel 1 exit 1

set "ACTIVATE_DIR=%PREFIX%\etc\conda\activate.d"
set "DEACTIVATE_DIR=%PREFIX%\etc\conda\deactivate.d"

mkdir %ACTIVATE_DIR%
mkdir %DEACTIVATE_DIR%

copy %RECIPE_DIR%\scripts\activate.bat %ACTIVATE_DIR%\esmpy-activate.bat
if errorlevel 1 exit 1

copy %RECIPE_DIR%\scripts\deactivate.bat %DEACTIVATE_DIR%\esmpy-deactivate.bat
if errorlevel 1 exit 1
