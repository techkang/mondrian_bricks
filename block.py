import pycuda.autoinit
import pycuda.driver as drv
from pycuda import gpuarray
from pycuda.compiler import SourceModule
import numpy as np
from sympy import Rational

with open('source.cu') as f:
    code = f.read()
ker = SourceModule(no_extern_c=True ,source=code)



pi_ker = ker.get_function("auto_player")

threads_per_block = 1024
blocks_per_grid = 2**8 * 10 ** 8 // threads_per_block
# threads_per_block = 1
# blocks_per_grid = 1

total_threads = threads_per_block * blocks_per_grid


print('start auto player')
pi_ker(grid=(blocks_per_grid,1,1), block=(threads_per_block,1,1))
print('auto player finished')