#include "oe.h"
#include "algo_top.h"

void minimal_bubble_sort(ecalcluster in[N], ecalcluster out[N]) {
#pragma HLS pipeline II=9
#pragma HLS INLINE
#pragma HLS array_partition variable=in dim=1
#pragma HLS array_partition variable=out dim=1

    for (int i = 0; i < N - 1; ++i) {
        for (int j = 0; j < N - i - 1; ++j) {
            if (in[j].energy > in[j + 1].energy) {
                in[j].energy ^= in[j + 1].energy;
                in[j + 1].energy ^= in[j].energy;
                in[j].energy ^= in[j + 1].energy;
            }
        }
    }
    for (int i = 0; i < N; ++i) {
        out[i] = in[i];
    }
}
