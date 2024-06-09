#include "algo_top.h"
#include <cstdlib>

int main(){

ap_uint<576> link_in[N_INPUT_LINKS] ;
ap_uint<576> link_out[N_OUTPUT_LINKS] ;

for(int i=0; i<N_INPUT_LINKS; i++){
	link_in[i] = 0;
}

link_in[0]  = "0x0000100012C0F000000010000C80F000000010000640F000000010000C803D000000100006403D000000100000003D000000100012C03D0000001000064000000000100000000000";
link_in[1]  = "0x0000000004C07814000064191BC0641900008C237B80002300008C237B808C2310009425A300D8250000C83219C000320000C83219C0C8320001906400019064100320C8280578C8";
link_in[2]  = "0x0000000004C07814000064191BC0641900008C237B80002300008C237B808C2310009425A300D8250000C83219C000320000C83219C0C8320001906400019064100320C8280578C8";
link_in[3]  = "0x0000000004C07814000064191BC0641900008C237B80002300008C237B808C2310009425A300D8250000C83219C000320000C83219C0C8320001906400019064100320C8280578C8";
link_in[4]  = "0x0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C83219C0C8320001906400019064100320C8280578C8";
link_in[5]  = 0;
link_in[6]  = 0;
link_in[7]  = 0;
link_in[8]  = 0;

for(int i=0; i<N_INPUT_LINKS; i++){
	cout << hex << "link_in[" << i << "]: " << link_in[i] << endl;
}

cout << endl;

algo_top(link_in, link_out);

for(int i=0; i<N_OUTPUT_LINKS; i++){
	cout << hex << "link_out[" << i << "]: " << link_out[i] << endl;
}

cout << endl;

/*        rctecalcluster rctcluster;

for(loop i = 0; i <9; i++){
	ap_uint<10> start = i*64;
    ap_uint<10> end = start+63;
    rctcluster.fillrctecalcluster(((ap_uint<64>) link_out[0].range(end, start))) ;
    cout << " cluster Seed " << rctcluster.seedEnergy << " energy " << rctcluster.energy
         << " eta " << rctcluster.eta
         << " phi " << rctcluster.phi << endl ;
}*/

return 0;
}
