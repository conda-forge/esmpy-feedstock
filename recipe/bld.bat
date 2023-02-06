set "ESMFMKFILE=%PREFIX%/lib/esmf.mk"

cd %SRC_DIR%\src\addon\esmpy

rem rmdir /s src\esmpy\fragments


%PYTHON% -m pip install .

for act_deact in activate deactivate
do
  act_deact_dir=${PREFIX}/etc/conda/${act_deact}.d
  mkdir -p ${act_deact_dir}
  cp ${RECIPE_DIR}/scripts/${act_deact}.bat ${act_deact_dir}/esmpy-${act_deact}.bat
done
