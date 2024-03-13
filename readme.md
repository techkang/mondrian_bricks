# 蒙德里安逻辑方块暴力解法
本仓库通过 cuda 编程，实现了对蒙德里安逻辑方块的暴力求解。
## 用法
1. 在 source.cu 147～149 行中，设定初始的三个方块的位置。
2. 执行 python block.py
## 输出及解读
```shell
start auto player
auto player finished  # 异步执行，所以这一print可能出现较早。
tid: 1, rotate: 1, blockIdx.x: 0, blockDim.x: 1024, threadIdx.x: 1
tid: 9477543487, rotate: 63, blockIdx.x: 9255413, blockDim.x: 1024, threadIdx.x: 575
# 找到解，此处发现 4 个解，是因为 2*2的方块和 3*3 的方块旋转具有不变性
find a solution with tid: 37021654, x rotate: 43, blockIdx.x: 9255413, blockDim.x: 1024, threadIdx.x: 555
find a solution with tid: 37021654, x rotate: 47, blockIdx.x: 9255413, blockDim.x: 1024, threadIdx.x: 559
find a solution with tid: 37021654, x rotate: 59, blockIdx.x: 9255413, blockDim.x: 1024, threadIdx.x: 571
find a solution with tid: 37021654, x rotate: 63, blockIdx.x: 9255413, blockDim.x: 1024, threadIdx.x: 575
# 具体路径
digit: 4, rotate: 1, put block(4, 2) at (1, 1), the board is 18446497498512817404
digit: 4, rotate: 1, put block(4, 2) at (1, 1), the board is 18446497498512817404
digit: 4, rotate: 1, put block(4, 2) at (1, 1), the board is 18446497498512817404
digit: 4, rotate: 1, put block(4, 2) at (1, 1), the board is 18446497498512817404
digit: 5, rotate: 1, put block(5, 2) at (1, 3), the board is 18446497446771093744
digit: 5, rotate: 1, put block(5, 2) at (1, 3), the board is 18446497446771093744
digit: 5, rotate: 1, put block(5, 2) at (1, 3), the board is 18446497446771093744
digit: 5, rotate: 1, put block(5, 2) at (1, 3), the board is 18446497446771093744
# 3*3 块的两种方法
digit: 6, rotate: 0, put block(3, 3) at (1, 5), the board is 18446497446763724928
digit: 6, rotate: 1, put block(3, 3) at (1, 5), the board is 18446497446763724928
digit: 6, rotate: 0, put block(3, 3) at (1, 5), the board is 18446497446763724928
digit: 6, rotate: 1, put block(3, 3) at (1, 5), the board is 18446497446763724928
digit: 1, rotate: 1, put block(5, 1) at (1, 8), the board is 18446496894852005888
digit: 1, rotate: 1, put block(5, 1) at (1, 8), the board is 18446496894852005888
digit: 1, rotate: 1, put block(5, 1) at (1, 8), the board is 18446496894852005888
digit: 1, rotate: 1, put block(5, 1) at (1, 8), the board is 18446496894852005888
# 2*2 块的两种方法
digit: 2, rotate: 0, put block(2, 2) at (4, 5), the board is 18446496687888269312
digit: 2, rotate: 0, put block(2, 2) at (4, 5), the board is 18446496687888269312
digit: 2, rotate: 1, put block(2, 2) at (4, 5), the board is 18446496687888269312
digit: 2, rotate: 1, put block(2, 2) at (4, 5), the board is 18446496687888269312
digit: 0, rotate: 1, put block(4, 1) at (5, 1), the board is 18374156515067035648
digit: 0, rotate: 1, put block(4, 1) at (5, 1), the board is 18374156515067035648
digit: 0, rotate: 1, put block(4, 1) at (5, 1), the board is 18374156515067035648
digit: 0, rotate: 1, put block(4, 1) at (5, 1), the board is 18374156515067035648
digit: 7, rotate: 0, put block(3, 4) at (6, 2), the board is 16203951459279044608
digit: 7, rotate: 0, put block(3, 4) at (6, 2), the board is 16203951459279044608
digit: 7, rotate: 0, put block(3, 4) at (6, 2), the board is 16203951459279044608
digit: 7, rotate: 0, put block(3, 4) at (6, 2), the board is 16203951459279044608
digit: 3, rotate: 0, put block(2, 3) at (7, 6), the board is 0
digit: 3, rotate: 0, put block(2, 3) at (7, 6), the board is 0
digit: 3, rotate: 0, put block(2, 3) at (7, 6), the board is 0
digit: 3, rotate: 0, put block(2, 3) at (7, 6), the board is 0
```