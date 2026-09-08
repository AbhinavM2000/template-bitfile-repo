#include "algo_top.h"

void processOutLinks(rctecalcluster RCTECALClusters[N_CLUSTERS],
                     rcttower RCTTowersPHI[N_TOWERS_IN_PHI][N_TOWERS_IN_ETA],
                     ap_uint<576> link_out[N_OUTPUT_LINKS]){
#pragma HLS ARRAY_PARTITION variable=RCTECALClusters cyclic factor=3 dim=1
#pragma HLS ARRAY_PARTITION variable=RCTTowersPHI cyclic factor=6 dim=1
#pragma HLS ARRAY_PARTITION variable=RCTTowersPHI cyclic factor=5 dim=2
#pragma HLS ARRAY_PARTITION variable=link_out complete dim=1
//#pragma HLS PIPELINE II=9
#pragma HLS LATENCY min=9

ap_uint<10> start ;
ap_uint<10> end ;
ap_uint<10> start1 ;
ap_uint<10> end1 ;

for(loop i=0 ; i<N_CLUSTERS; i++){
    #pragma HLS UNROLL factor=3
	start=i*64 ; end=start+63;
	link_out[0].range(end, start) = RCTECALClusters[i].getrctecalcluster() ;
}

for(loop i=0; i<N_TOWERS_IN_ETA; i++){
    #pragma HLS UNROLL factor=5
	start=i*16 ; end=start+15;
	start1=start+272 ; end1=start1+15;
	link_out[1].range(end, start) = RCTTowersPHI[0][i].getrcttower() ;
	link_out[1].range(end1, start1) = RCTTowersPHI[1][i].getrcttower() ;
	link_out[2].range(end, start) = RCTTowersPHI[2][i].getrcttower() ;
	link_out[2].range(end1, start1) = RCTTowersPHI[3][i].getrcttower() ;
	link_out[3].range(end, start) = RCTTowersPHI[4][i].getrcttower() ;
	link_out[3].range(end1, start1) = RCTTowersPHI[5][i].getrcttower() ;
	 //cout << hex <<link_out[3]<<endl;
	 //cout<<"link out 3 ";
}

}

void getECAL(ap_uint<576> link_in[N_INPUT_LINKS],ecaltower ECALTowersSLR3[N_TOWERS_IN_ETA5*N_TOWERS_IN_PHI],ecaltower ECALTowersSLR2[N_TOWERS_IN_ETA5*N_TOWERS_IN_PHI],ecaltower ECALTowersSLR1[N_TOWERS_IN_ETA5*N_TOWERS_IN_PHI],ecaltower ECALTowersSLR0[N_TOWERS_IN_ETA2*N_TOWERS_IN_PHI]){
#pragma HLS ARRAY_PARTITION variable=link_in complete dim=1
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR3 cyclic factor=6 dim=1
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR2 cyclic factor=6 dim=1
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR1 cyclic factor=6 dim=1
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR0 cyclic factor=6 dim=1

for(loop i=0; i<N_TOWERS_IN_ETA5*N_TOWERS_IN_PHI; i++){
    #pragma HLS UNROLL factor=6
    ap_uint<10> start   = i*18;
    ap_uint<10> end = start + 17;
    ECALTowersSLR3[i].fillecaltower(link_in[1].range(end, start));
    //cout << hex << link_in[1]<<endl;
    //cout <<"tower link 1"<<endl;


  }
for(loop i=0; i<N_TOWERS_IN_ETA5*N_TOWERS_IN_PHI; i++){
    #pragma HLS UNROLL factor=6
    ap_uint<10> start   = i*18;
    ap_uint<10> end = start + 17;
    ECALTowersSLR2[i].fillecaltower(link_in[2].range(end, start));
   // cout << hex << link_in[2]<<endl;
    //cout <<"tower link 2"<<endl;

  }
for(loop i=0; i<N_TOWERS_IN_ETA5*N_TOWERS_IN_PHI; i++){
    #pragma HLS UNROLL factor=6
    ap_uint<10> start   = i*18;
    ap_uint<10> end = start + 17;
    ECALTowersSLR1[i].fillecaltower(link_in[3].range(end, start));
    //cout << hex << link_in[3]<<endl;
    //cout <<"tower link 3"<<endl;

  }
for(loop i=0; i<N_TOWERS_IN_ETA2*N_TOWERS_IN_PHI; i++){
    #pragma HLS UNROLL factor=6
    ap_uint<10> start   = i*18;
    ap_uint<10> end = start + 17;
    ECALTowersSLR0[i].fillecaltower(link_in[4].range(end, start));
   // cout << hex << link_in[4];
   // cout <<"tower link 4"<<endl;


  }
//cout<<ECALTowersSLR0[0].energy<<endl;
  // cout<<"zero zero en";
}

void processInputLinks(ap_uint<576> link_in[N_INPUT_LINKS], rctecalcluster RCTECALClusters[N_CLUSTERS], rcttower RCTTowersPHI[N_TOWERS_IN_PHI][N_TOWERS_IN_ETA]){
	#pragma HLS ARRAY_PARTITION variable=link_in complete dim=1
	#pragma HLS ARRAY_PARTITION variable=RCTECALClusters cyclic factor=3 dim=1
	#pragma HLS ARRAY_PARTITION variable=RCTTowersPHI cyclic factor=6 dim=1
	#pragma HLS ARRAY_PARTITION variable=RCTTowersPHI cyclic factor=5 dim=2
#pragma HLS latency min=9

ecaltower ECALTowersSLR3[N_TOWERS_IN_ETA5*N_TOWERS_IN_PHI];
ecaltower ECALTowersSLR2[N_TOWERS_IN_ETA5*N_TOWERS_IN_PHI];
ecaltower ECALTowersSLR1[N_TOWERS_IN_ETA5*N_TOWERS_IN_PHI];
ecaltower ECALTowersSLR0[N_TOWERS_IN_ETA2*N_TOWERS_IN_PHI];
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR3 cyclic factor=6 dim=1
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR2 cyclic factor=6 dim=1
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR1 cyclic factor=6 dim=1
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR0 cyclic factor=6 dim=1


hcaltower HCALTowersR0[N_TOWERS_IN_HCAL_REGION];
hcaltower HCALTowersR1[N_TOWERS_IN_HCAL_REGION];
hcaltower HCALTowersR2[N_TOWERS_IN_HCAL_REGION];
#pragma HLS ARRAY_PARTITION variable=HCALTowersR0 cyclic factor=2 dim=1
#pragma HLS ARRAY_PARTITION variable=HCALTowersR1 cyclic factor=2 dim=1
#pragma HLS ARRAY_PARTITION variable=HCALTowersR2 cyclic factor=2 dim=1

for(loop i=0; i<N_CLUSTERS; i++){
    #pragma HLS UNROLL factor=3
    ap_uint<10> start   = i*64;
    ap_uint<10> end = start + 63;
    RCTECALClusters[i].fillrctecalcluster(link_in[0].range(end, start));

  }



getECAL(link_in,ECALTowersSLR3, ECALTowersSLR2, ECALTowersSLR1, ECALTowersSLR0);

//cout<<"ECALTowersSLR0[0].energy :";
//cout<<ECALTowersSLR0[0].energy<<endl;


//cout<<"eta::";
//cout<<RCTECALClusters[0].eta<<endl;

for(loop i=0; i<N_TOWERS_IN_HCAL_REGION; i++){
    #pragma HLS UNROLL factor=2
    ap_uint<10> start   = i*16;
    ap_uint<10> end = start + 15;
    HCALTowersR0[i].fillhcaltower(link_in[5].range(end, start));
  }
for(loop i=0; i<N_TOWERS_IN_HCAL_REGION; i++){
    #pragma HLS UNROLL factor=2
    ap_uint<10> start   = i*16;
    ap_uint<10> end = start + 15;
    HCALTowersR1[i].fillhcaltower(link_in[6].range(end, start));
  }
for(loop i=0; i<N_TOWERS_IN_HCAL_REGION; i++){
    #pragma HLS UNROLL factor=2
    ap_uint<10> start   = i*16;
    ap_uint<10> end = start + 15;
    HCALTowersR2[i].fillhcaltower(link_in[7].range(end, start));
  }

for(loop j=0; j<N_TOWERS_IN_PHI; j++){
    #pragma HLS UNROLL
for(loop i=0; i<N_TOWERS_IN_ETA5; i++){
    #pragma HLS UNROLL
RCTTowersPHI[j][i+0].uploadECAL(ECALTowersSLR3[i*6+j]) ;
}}
for(loop j=0; j<N_TOWERS_IN_PHI; j++){
    #pragma HLS UNROLL
for(loop i=0; i<N_TOWERS_IN_ETA5; i++){
    #pragma HLS UNROLL
RCTTowersPHI[j][i+5].uploadECAL(ECALTowersSLR2[i*6+j]) ;
}}
for(loop j=0; j<N_TOWERS_IN_PHI; j++){
    #pragma HLS UNROLL
for(loop i=0; i<N_TOWERS_IN_ETA5; i++){
    #pragma HLS UNROLL
RCTTowersPHI[j][i+10].uploadECAL(ECALTowersSLR1[i*6+j]) ;
}}

for(loop j=0; j<N_TOWERS_IN_PHI; j++){
    #pragma HLS UNROLL
for(loop i=0; i<N_TOWERS_IN_ETA2; i++){
    #pragma HLS UNROLL
RCTTowersPHI[j][i+15].uploadECAL(ECALTowersSLR0[i*6+j]) ;
}}

/* Each HCAL fiber is one 16x2 BCP region
 * slot = phi*N_TOWERS_HCAL_IN_ETA + eta  (0:0, 1:0, ... 15:0, 0:1, ... 15:1)
 * Three fibers cover the RCT card at phi offsets 0, 2, 4.
 */
for(loop j=0; j<N_TOWERS_HCAL_IN_PHI; j++){
    #pragma HLS UNROLL
for(loop i=0; i<N_TOWERS_HCAL_IN_ETA; i++){
    #pragma HLS UNROLL
RCTTowersPHI[j+0][i].uploadHCAL(HCALTowersR0[j*N_TOWERS_HCAL_IN_ETA+i]) ;
}}

for(loop j=0; j<N_TOWERS_HCAL_IN_PHI; j++){
    #pragma HLS UNROLL
for(loop i=0; i<N_TOWERS_HCAL_IN_ETA; i++){
    #pragma HLS UNROLL
RCTTowersPHI[j+2][i].uploadHCAL(HCALTowersR1[j*N_TOWERS_HCAL_IN_ETA+i]) ;
}}

for(loop j=0; j<N_TOWERS_HCAL_IN_PHI; j++){
    #pragma HLS UNROLL
for(loop i=0; i<N_TOWERS_HCAL_IN_ETA; i++){
    #pragma HLS UNROLL
RCTTowersPHI[j+4][i].uploadHCAL(HCALTowersR2[j*N_TOWERS_HCAL_IN_ETA+i]) ;
}}

}

void algo_top(ap_uint<576> link_in[N_INPUT_LINKS], ap_uint<576> link_out[N_OUTPUT_LINKS]){
#pragma HLS ARRAY_PARTITION variable=link_in complete dim=1
#pragma HLS ARRAY_PARTITION variable=link_out complete dim=1
#pragma HLS PIPELINE II=9
#pragma HLS INTERFACE ap_ctrl_hs port=return
//#pragma HLS latency min=145

rctecalcluster RCTECALClusters[N_CLUSTERS] ;
#pragma HLS ARRAY_PARTITION variable=RCTECALClusters cyclic factor=3 dim=1

rcttower RCTTowersPHI[N_TOWERS_IN_PHI][N_TOWERS_IN_ETA];
#pragma HLS ARRAY_PARTITION variable=RCTTowersPHI cyclic factor=6 dim=1
#pragma HLS ARRAY_PARTITION variable=RCTTowersPHI cyclic factor=5 dim=2

//reading clusters and towers
// order of HCAL tower

processInputLinks(link_in, RCTECALClusters, RCTTowersPHI) ;
//out<< RCTTowersPHI[0][0].energy<<endl;
//cout<<"RCTTowersPHI[0][0]";
//cout<< RCTTowersPHI[5][0].energy<<endl;
//cout<<"RCTTowersPHI[5][0]";
/*---------------------------------link 0------------------------------------*/
        
link_out[0] = 0;
link_out[1] = 0;
link_out[2] = 0;
link_out[3] = 0;

processOutLinks(RCTECALClusters, RCTTowersPHI, link_out);

}
