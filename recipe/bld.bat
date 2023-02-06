set "ESMFMKFILE=%PREFIX%/lib/esmf.mk"

cd %SRC_DIR%/src/addon/esmpy

rmdir src/esmpy/fragments


%PYTHON% -m pip install .

rem for shell in sh csh fish
rem do
rem   for act_deact in activate deactivate
rem   do
rem     act_deact_dir=${PREFIX}/etc/conda/${act_deact}.d
rem     mkdir -p ${act_deact_dir}
rem     cp ${RECIPE_DIR}/scripts/${act_deact}.${shell} ${act_deact_dir}/esmpy-${act_deact}.${shell}
rem   done
rem done
