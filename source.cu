#include <curand_kernel.h>
#include <stdio.h>
#define _PYTHAG(a, b) (a * a + b * b)
#define ULL unsigned long long

extern "C"
{

    __device__ bool check_valid(unsigned long long data)
    {
        int check_dim = 8;
        // printf("?>??? data is: %d\n", data);
        if (data < pow(10, check_dim - 2))
        {
            return false;
        }
        bool res = true;
        int all_visited = 0;
        int digit = 0, count = 0;
        if (data <= pow(10, check_dim - 1))
        {
            all_visited++;
            count++;
        }
        while (data > 0 && count < 10)
        {
            count += 1;
            digit = data % 10;
            data = data / 10;
            all_visited += 1 << digit;
        }
        return all_visited == (1 << check_dim) - 1;
    }

    __device__ void store_data(int row, int col, int h, int w, int dim, ULL & visited){
        ULL mask;
        for (int i=0; i<h;i++){
            for (int j=0;j<w;j++){
                if (row + i >= dim || col + j >= dim){
                    break;
                }
                // 将visited第i位置为0
                mask = ~(1ULL << ((row + i) * dim + col + j));
                visited &= mask;
                // if (row==5 and col==1){
                //     printf("row:%d col:%d i:%d j:%d board: %llu\n", row, col, i, j, visited);
                // }
            }
        }
        return;
    }

    __device__ void find_h_w(int index, int rotate, int& h, int& w){
        int temp = 0;
        switch (index)
        {
        case 0:
            h = 1; w = 4;
            break;
        case 1:
            h = 1; w = 5;
            break;
        case 2:
            h = 2; w = 2;
            break;
        case 3:
            h = 2; w = 3;
            break;
        case 4:
            h = 2; w = 4;
            break;
        case 5:
            h = 2; w = 5;
            break;
        case 6:
            h = 3; w = 3;
            break;
        case 7:
            h = 3; w = 4;
            break;
        default:
            // printf("error");
            h = -1; w = -1;
        }
        if (rotate != 0){
            temp = h;
            h = w;
            w = temp;
        }
        return;
    }

    __device__ bool solve(unsigned long long tid, int rotate, unsigned long long visited, bool print=false){
        unsigned long long temp;
        int digit, h, w, rc_index, row, col;
        for (int i = 0; i < 8; i++)
        {
            digit = tid % 10;
            tid = tid / 10;
            h = 0;
            w = 0;
            find_h_w(digit, rotate % 2, h, w);
            if (h < 0 or w < 0)
            {
                break;
            }
            rc_index = 0;
            temp = visited;
            while (temp && ((temp & 1ULL) == 0))
            {
                temp /= 2;
                rc_index++;
            }
            row = rc_index / 8;
            col = rc_index % 8;
            store_data(row, col, h, w, 8, visited);
            if (print){
                printf("digit: %d, rotate: %d, put block(%d, %d) at (%d, %d), the board is %llu\n", digit, rotate%2, h, w, row+1, col+1, visited);
            }
            rotate /= 2;
        };
        return visited == 0;
    }

    __global__ void auto_player()
    {
        // 1,4 1,5, 2,2 2,3 2,4 2,5 3,3 3,4
        unsigned long long tid = (unsigned long long)blockIdx.x * (unsigned long long)blockDim.x + (unsigned long long)threadIdx.x;
        unsigned long long ori_tid = tid;
        int rotate = tid & ((1 << 9) - 1);
        // unsigned long long tid = 37021654;
        // int rotate = 0b00111111;
        // tid = tid << 8;
        if (tid == 9477543487ULL || tid == 1ULL){
            printf("tid: %llu, rotate: %d, blockIdx.x: %d, blockDim.x: %d, threadIdx.x: %d\n", tid, rotate, blockIdx.x, blockDim.x, threadIdx.x);
        }
        tid = tid >> 8;
        if (!check_valid(tid)){
            return;
        }
        unsigned long long visited=-1, temp;

        // set init state
        store_data(4, 1, 1, 1, 8, visited);
        store_data(3, 6, 2, 1, 8, visited);
        store_data(5, 5, 1, 3, 8, visited);
        // store_data(0, 0, 1, 1, 8, visited);
        // store_data(0, 1, 1, 2, 8, visited);
        // store_data(1, 0, 1, 3, 8, visited);
        // printf("init board: %llu\n", visited);

        bool res = solve(tid, rotate, visited);

        if (res){
            printf("find a solution with tid: %llu, x rotate: %d, blockIdx.x: %d, blockDim.x: %d, threadIdx.x: %d\n", tid, rotate, blockIdx.x, blockDim.x, threadIdx.x);
            solve(tid, rotate, visited, true);
        }
    }

} // (End of 'extern "C"' here)