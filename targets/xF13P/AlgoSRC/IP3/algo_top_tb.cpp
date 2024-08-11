#include "algo_top.h"
#include <cstdlib>

int main(){

ap_uint<576> link_in[N_INPUT_LINKS] ;
ap_uint<576> link_out[N_OUTPUT_LINKS] ;

for(int i=0; i<N_INPUT_LINKS; i++){
	link_in[i] = 0;
}

link_in[0]  ="0x09201C40007800820028119012D280010028119006528001002811900C928001060019000E1001700600190007D0017006001900145001700000100412C4F001000010040C84F001";
link_in[1]  ="0x0000000003C0003210047E103C47AC3C10078708ADCC40641003F57C83C66C3210047D613C40003C08054A84930894460800E847E9C11C121001F89A9282451A0802711FE9443946";
link_in[2]  ="0x0000000003C0003210047E103C47AC3C10078708ADCC40641003F57C83C66C3210047D613C40003C08054A84930894460800E847E9C11C121001F89A9282451A0802711FE9443946";
link_in[3]  ="0x0000000003C0003210047E103C47AC3C10078708ADCC40641003F57C83C66C3210047D613C40003C08054A84930894460800E847E9C11C121001F89A9282451A0802711FE9443A82";
link_in[4]  ="0x000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100330F05186043110047E104108143C080787087A11DC64";
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
