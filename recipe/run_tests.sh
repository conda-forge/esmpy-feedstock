 #!/usr/bin/env sh

 export ESMPY_DATA_DIR=${SRC_DIR}/test_data
 mpiexec -np 1 python -m pytest -vs
 mpiexec -np 2 python -m pytest -vs
 mpiexec -np 2 python src/addon/esmpy/examples/test_examples.py
