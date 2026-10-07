#include "bubl_sorter.h"
#include "algo_top.h"

void bubl_sorter(ecalcluster in[N], ecalcluster out[N]) {
#pragma HLS pipeline II=9
#pragma HLS array_partition variable=in dim=1
#pragma HLS array_partition variable=out dim=1

    ecalcluster temp; // Temporary variable for swapping entire objects

    for (int i = 0; i < N - 1; ++i) {
//#pragma HLS UNROLL factor=4
        for (int j = 0; j < N - i - 1; ++j) {
            if (in[j].energy < in[j + 1].energy) {
                // Swap the entire ecalcluster objects
                temp = in[j];
                in[j] = in[j + 1];
                in[j + 1] = temp;
            }
        }
    }
    for (int i = 0; i < N; ++i) {
        out[i] = in[i];
    }
}
