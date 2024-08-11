#include "algo_top.h"
#include "bitonicSort32.h"

void processOutLinks(ecalcluster ECALClustersOut[N_CLUSTERS],
                     ecaltower ECALTowersSLR0[TOWERS_IN_ETA2*TOWERS_IN_PHI],
                     ecaltower ECALTowersSLR1[TOWERS_IN_ETA2*TOWERS_IN_PHI],
                     ecaltower ECALTowersSLR2[TOWERS_IN_ETA2*TOWERS_IN_PHI],
                     ecaltower ECALTowersSLR3[TOWERS_IN_ETA2*TOWERS_IN_PHI],
                     ap_uint<576> link_out[N_OUTPUT_LINKS]){
#pragma HLS ARRAY_PARTITION variable=ECALClustersOut complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR0 complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR1 complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR2 complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR3 complete dim=0
#pragma HLS ARRAY_PARTITION variable=link_out complete dim=0
#pragma HLS PIPELINE II=9
#pragma HLS LATENCY min=9

        ap_uint<10> start ;
        ap_uint<10> end ;

	rctecalcluster RCTECALClusters[N_CLUSTERS_OUT] ;
	#pragma HLS ARRAY_PARTITION variable=RCTECALClusters complete dim=0

	for(loop i=0 ; i<N_CLUSTERS_OUT; i++)
          {
    #pragma HLS UNROLL
		ap_uint<7> slr =  ECALClustersOut[i+23].spare ;
        	ap_uint<7> etatmp = ECALClustersOut[i+23].eta ;
        	ap_uint<7> rctEta = etatmp + ((ap_uint<7>)slr<<4) + ((ap_uint<7>)slr<<3) + slr ;
		RCTECALClusters[i].fillrctecalcluster2(ECALClustersOut[i+23],rctEta) ;
	  }

        for(loop i=0 ; i<N_CLUSTERS_OUT; i++)
          {
    #pragma HLS UNROLL
		start=i*64 ; end=start+63;
		link_out[0].range(end, start) = RCTECALClusters[i].getrctecalcluster() ;
	  }

        for(loop i=0; i<TOWERS_IN_ETA5*TOWERS_IN_PHI; i++)
          {
    #pragma HLS UNROLL
		start=i*18 ; end=start+17;
		link_out[1].range(end, start) = ECALTowersSLR3[i].getecaltower() ;
		link_out[2].range(end, start) = ECALTowersSLR2[i].getecaltower() ;
		link_out[3].range(end, start) = ECALTowersSLR1[i].getecaltower() ;
	  }

        for(loop i=0; i<TOWERS_IN_ETA2*TOWERS_IN_PHI; i++)
          {
    #pragma HLS UNROLL
		start=i*18 ; end=start+17;
		link_out[4].range(end, start) = ECALTowersSLR0[i].getecaltower() ;
          }

}

void processInputLinks(ap_uint<576> link_in[N_INPUT_LINKS], ecaltower ECALTowersSLR3[TOWERS_IN_ETA5*TOWERS_IN_PHI], ecaltower ECALTowersSLR2[TOWERS_IN_ETA5*TOWERS_IN_PHI], ecaltower ECALTowersSLR1[TOWERS_IN_ETA5*TOWERS_IN_PHI], ecaltower ECALTowersSLR0[TOWERS_IN_ETA2*TOWERS_IN_PHI], ecalcluster ECALClustersSLR3[N_CLUSTERS_5x6], ecalcluster ECALClustersSLR2[N_CLUSTERS_5x6], ecalcluster ECALClustersSLR1[N_CLUSTERS_5x6], ecalcluster ECALClustersSLR0[N_CLUSTERS_2x6]){
	#pragma HLS ARRAY_PARTITION variable=link_in complete dim=0
	#pragma HLS ARRAY_PARTITION variable=ECALClustersSLR3 complete dim=0
	#pragma HLS ARRAY_PARTITION variable=ECALClustersSLR2 complete dim=0
	#pragma HLS ARRAY_PARTITION variable=ECALClustersSLR1 complete dim=0
	#pragma HLS ARRAY_PARTITION variable=ECALClustersSLR0 complete dim=0
	#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR3 complete dim=0
	#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR2 complete dim=0
	#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR1 complete dim=0
	#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR0 complete dim=0
//#pragma HLS latency min=9

for(loop i=0; i<TOWERS_IN_ETA5*TOWERS_IN_PHI; i++){
    #pragma HLS UNROLL
    ap_uint<10> start   = i*18;
    ap_uint<10> end = start + 17;
    ECALTowersSLR3[i].fillecaltower(link_in[0].range(end, start));
  }
for(loop i=0; i<TOWERS_IN_ETA5*TOWERS_IN_PHI; i++){
    #pragma HLS UNROLL
    ap_uint<10> start   = i*18;
    ap_uint<10> end = start + 17;
    ECALTowersSLR2[i].fillecaltower(link_in[2].range(end, start));
  }
for(loop i=0; i<TOWERS_IN_ETA5*TOWERS_IN_PHI; i++){
    #pragma HLS UNROLL
    ap_uint<10> start   = i*18;
    ap_uint<10> end = start + 17;
    ECALTowersSLR1[i].fillecaltower(link_in[4].range(end, start));
  }

for(loop i=0; i<TOWERS_IN_ETA2*TOWERS_IN_PHI; i++){
    #pragma HLS UNROLL
    ap_uint<10> start   = i*18;
    ap_uint<10> end = start + 17;
    ECALTowersSLR0[i].fillecaltower(link_in[6].range(end, start));
  }

for(loop i=0; i<N_CLUSTERS_5x6; i++){
    #pragma HLS UNROLL
    ap_uint<10> start   = i*64;
    ap_uint<10> end = start + 63;
    ECALClustersSLR3[i].fillecalcluster(link_in[1].range(end, start));
  }
for(loop i=0; i<N_CLUSTERS_5x6; i++){
    #pragma HLS UNROLL
    ap_uint<10> start   = i*64;
    ap_uint<10> end = start + 63;
    ECALClustersSLR2[i].fillecalcluster(link_in[3].range(end, start));
  }
for(loop i=0; i<N_CLUSTERS_5x6; i++){
    #pragma HLS UNROLL
    ap_uint<10> start   = i*64;
    ap_uint<10> end = start + 63;
    ECALClustersSLR1[i].fillecalcluster(link_in[5].range(end, start));
  }

for(loop i=0; i<N_CLUSTERS_2x6; i++){
    #pragma HLS UNROLL
    ap_uint<10> start   = i*64;
    ap_uint<10> end = start + 63;
    ECALClustersSLR0[i].fillecalcluster(link_in[7].range(end, start));
  }

}

void getSums(ecalcluster low, ecalcluster high, ap_uint<12> &EnergySum, ap_uint<10> &EnergySum5x5, ap_uint<10> &EnergySum2x5){

ap_uint<12> EnergyH = high.energy ;
ap_uint<10> EnergyH5x5 = high.et5x5 ;
ap_uint<10> EnergyH2x5 = high.et2x5 ;

ap_uint<12> EnergyL = low.energy ;
ap_uint<10> EnergyL5x5 = low.et5x5 ;
ap_uint<10> EnergyL2x5 = low.et2x5 ;

EnergySum = EnergyH + EnergyL ;
EnergySum5x5 = EnergyH5x5 + EnergyL5x5 ;
EnergySum2x5 = EnergyH2x5 + EnergyL2x5 ;

}

void stitchClusters2x6(ecalcluster ECALClustersLowEta[N_CLUSTERS_5x6], ecalcluster ECALClustersHighEta[N_CLUSTERS_2x6]){
#pragma HLS ARRAY_PARTITION variable=ECALClustersLowEta complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALClustersHighEta complete dim=0

/* low Eta we use last 3 clusters, high Eta first 3, we match those clusters that
are at eta=24 Low with eta=0 High if the dPhi<=2 */


for(loop j=6; j<9; j++){  /* low Eta */
    #pragma HLS UNROLL
for(loop i=0; i<3; i++){  /* high Eta */
    #pragma HLS UNROLL

bool etaH = (ECALClustersHighEta[i].eta == 0) ? true : false ;
bool etaL = (ECALClustersLowEta[j].eta == 24) ? true : false ;

ap_uint<5> PhiH = ECALClustersHighEta[i].phi ;
ap_uint<5> PhiL = ECALClustersLowEta[j].phi ;

ap_uint<5> dPhi = (PhiL > PhiH) ? (PhiL-PhiH) : (PhiH-PhiL) ;
bool dphi = (dPhi <= 2) ? true : false ;

bool stitch = etaL && etaH && dphi ;

ap_uint<12> EnergyH = ECALClustersHighEta[i].energy ;
ap_uint<12> EnergyL = ECALClustersLowEta[j].energy ;

ap_uint<12> EnergySum ;
ap_uint<10> EnergySum5x5 ;
ap_uint<10> EnergySum2x5 ;
 
getSums(ECALClustersLowEta[j], ECALClustersHighEta[i], EnergySum, EnergySum5x5, EnergySum2x5) ;

if(stitch)
{
	if(EnergyH > EnergyL){
	ECALClustersHighEta[i].energy = EnergySum ;
	ECALClustersHighEta[i].et5x5 = EnergySum5x5 ;
	ECALClustersHighEta[i].et2x5 = EnergySum2x5 ;
	ECALClustersLowEta[j].energy = 0 ;
	}
	else {
	ECALClustersHighEta[i].energy = 0 ;
	ECALClustersLowEta[j].energy = EnergySum ;
	ECALClustersLowEta[j].et5x5 = EnergySum5x5 ;
	ECALClustersLowEta[j].et2x5 = EnergySum2x5 ;
	}
}

}}

}

void stitchClusters(ecalcluster ECALClustersLowEta[N_CLUSTERS_5x6], ecalcluster ECALClustersHighEta[N_CLUSTERS_5x6]){
#pragma HLS ARRAY_PARTITION variable=ECALClustersLowEta complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALClustersHighEta complete dim=0

/* low Eta we use last 3 clusters, high Eta first 3, we match those clusters that
are at eta=24 Low with eta=0 High if the dPhi<=2 */


for(loop j=6; j<9; j++){  /* low Eta */
    #pragma HLS UNROLL
for(loop i=0; i<3; i++){  /* high Eta */
    #pragma HLS UNROLL

bool etaH = (ECALClustersHighEta[i].eta == 0) ? true : false ;
bool etaL = (ECALClustersLowEta[j].eta == 24) ? true : false ;

ap_uint<5> PhiH = ECALClustersHighEta[i].phi ;
ap_uint<5> PhiL = ECALClustersLowEta[j].phi ;

ap_uint<5> dPhi = (PhiL > PhiH) ? (PhiL-PhiH) : (PhiH-PhiL) ;
bool dphi = (dPhi <= 2) ? true : false ;

bool stitch = etaL && etaH && dphi ;

ap_uint<12> EnergyH = ECALClustersHighEta[i].energy ;
ap_uint<12> EnergyL = ECALClustersLowEta[j].energy ;

ap_uint<12> EnergySum ;
ap_uint<10> EnergySum5x5 ;
ap_uint<10> EnergySum2x5 ;
 
getSums(ECALClustersLowEta[j], ECALClustersHighEta[i], EnergySum, EnergySum5x5, EnergySum2x5) ;

if(stitch)
{
	if(EnergyH > EnergyL){
	ECALClustersHighEta[i].energy = EnergySum ;
	ECALClustersHighEta[i].et5x5 = EnergySum5x5 ;
	ECALClustersHighEta[i].et2x5 = EnergySum2x5 ;
	ECALClustersLowEta[j].energy = 0 ;
	}
	else {
	ECALClustersHighEta[i].energy = 0 ;
	ECALClustersLowEta[j].energy = EnergySum ;
	ECALClustersLowEta[j].et5x5 = EnergySum5x5 ;
	ECALClustersLowEta[j].et2x5 = EnergySum2x5 ;
	}
}

}}

}

void putbackintower2x6(ecalcluster ECALCluster, ecaltower ECALTowers[TOWERS_IN_ETA2*TOWERS_IN_PHI]){
#pragma HLS ARRAY_PARTITION variable=ECALTowers complete dim=0
#pragma HLS INLINE
	loop id = (ECALCluster.eta/5)*6 + ECALCluster.phi ;

for(loop i=0; i<TOWERS_IN_ETA2*TOWERS_IN_PHI; i++){
    #pragma HLS UNROLL
		ap_uint<12> sum = ECALTowers[i].energy + ECALCluster.energy ;
		if( id == i){
		ECALTowers[i].energy = sum ;
		}
	}
}

void putbackintower(ecalcluster ECALCluster, ecaltower ECALTowers[TOWERS_IN_ETA5*TOWERS_IN_PHI]){
#pragma HLS ARRAY_PARTITION variable=ECALTowers complete dim=0
#pragma HLS INLINE

	loop id = (ECALCluster.eta/5)*6 + ECALCluster.phi ; 

for(loop i=0; i<TOWERS_IN_ETA5*TOWERS_IN_PHI; i++){
	#pragma HLS UNROLL
		ap_uint<12> sum = ECALTowers[i].energy + ECALCluster.energy ;
		if( id == i){
		ECALTowers[i].energy = sum ;
		}
	}

}

void algo_top(ap_uint<576> link_in[N_INPUT_LINKS], ap_uint<576> link_out[N_OUTPUT_LINKS]){
#pragma HLS ARRAY_PARTITION variable=link_in complete dim=0
#pragma HLS ARRAY_PARTITION variable=link_out complete dim=0
#pragma HLS PIPELINE II=9
#pragma HLS INTERFACE ap_ctrl_hs port=return
//#pragma HLS latency min=145

ecalcluster ECALClusters[N_CLUSTERS] ;
ecalcluster ECALClustersOut[N_CLUSTERS] ;
ecalcluster ECALClustersSLR3[N_CLUSTERS_5x6] ;
ecalcluster ECALClustersSLR2[N_CLUSTERS_5x6] ;
ecalcluster ECALClustersSLR1[N_CLUSTERS_5x6] ;
ecalcluster ECALClustersSLR0[N_CLUSTERS_2x6] ;

#pragma HLS ARRAY_PARTITION variable=ECALClusters complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALClustersOut complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALClustersSLR3 complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALClustersSLR2 complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALClustersSLR1 complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALClustersSLR0 complete dim=0

ecaltower ECALTowersSLR3[TOWERS_IN_ETA5*TOWERS_IN_PHI];
ecaltower ECALTowersSLR2[TOWERS_IN_ETA5*TOWERS_IN_PHI];
ecaltower ECALTowersSLR1[TOWERS_IN_ETA5*TOWERS_IN_PHI];
ecaltower ECALTowersSLR0[TOWERS_IN_ETA2*TOWERS_IN_PHI];
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR3 complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR2 complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR1 complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR0 complete dim=0

//reading clusters and towers

processInputLinks(link_in, ECALTowersSLR3, ECALTowersSLR2, ECALTowersSLR1, ECALTowersSLR0, ECALClustersSLR3, ECALClustersSLR2, ECALClustersSLR1, ECALClustersSLR0) ;

stitchClusters(ECALClustersSLR3, ECALClustersSLR2) ;         
stitchClusters2x6(ECALClustersSLR1, ECALClustersSLR0) ;         
stitchClusters(ECALClustersSLR2, ECALClustersSLR1) ;         

for(loop i=0; i<N_CLUSTERS_5x6; i++){
    #pragma HLS UNROLL
ECALClusters[i] = ECALClustersSLR3[i] ;
ECALClusters[i].spare = 3 ;
}
for(loop i=0; i<N_CLUSTERS_5x6; i++){
    #pragma HLS UNROLL
ECALClusters[N_CLUSTERS_5x6+i] = ECALClustersSLR2[i] ;
ECALClusters[N_CLUSTERS_5x6+i].spare = 2 ;
}
for(loop i=0; i<N_CLUSTERS_5x6; i++){
    #pragma HLS UNROLL
ECALClusters[2*N_CLUSTERS_5x6+i] = ECALClustersSLR1[i] ;
ECALClusters[2*N_CLUSTERS_5x6+i].spare = 1 ;
}
for(loop i=0; i<N_CLUSTERS_2x6; i++){
    #pragma HLS UNROLL
ECALClusters[3*N_CLUSTERS_5x6+i] = ECALClustersSLR0[i] ;
ECALClusters[3*N_CLUSTERS_5x6+i].spare = 0 ;
}

 bitonicSort32(ECALClusters, ECALClustersOut);

ecaltower ECALTowersSLR3C[TOWERS_IN_ETA5*TOWERS_IN_PHI];
ecaltower ECALTowersSLR2C[TOWERS_IN_ETA5*TOWERS_IN_PHI];
ecaltower ECALTowersSLR1C[TOWERS_IN_ETA5*TOWERS_IN_PHI];
ecaltower ECALTowersSLR0C[TOWERS_IN_ETA2*TOWERS_IN_PHI];
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR3C complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR2C complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR1C complete dim=0
#pragma HLS ARRAY_PARTITION variable=ECALTowersSLR0C complete dim=0

for(loop i=2; i<23; i++){
    #pragma HLS UNROLL
	if(ECALClustersOut[i].spare == 0) putbackintower2x6(ECALClustersOut[i], ECALTowersSLR0C) ;
	if(ECALClustersOut[i].spare == 1) putbackintower(ECALClustersOut[i], ECALTowersSLR1C) ;
	if(ECALClustersOut[i].spare == 2) putbackintower(ECALClustersOut[i], ECALTowersSLR2C) ;
	if(ECALClustersOut[i].spare == 3) putbackintower(ECALClustersOut[i], ECALTowersSLR3C) ;
//	else {  } ;
//	ECALClustersOut[i].energy = 0 ;
}

for(loop i=0; i<TOWERS_IN_ETA5*TOWERS_IN_PHI; i++){
    #pragma HLS UNROLL
    ap_uint<12> energy3 = ECALTowersSLR3[i].energy + ECALTowersSLR3C[i].energy ;
    ECALTowersSLR3[i].energy = energy3 ;
    ap_uint<12> energy2 = ECALTowersSLR2[i].energy + ECALTowersSLR2C[i].energy ;
    ECALTowersSLR2[i].energy = energy2 ;
    ap_uint<12> energy1 = ECALTowersSLR1[i].energy + ECALTowersSLR1C[i].energy ;
    ECALTowersSLR1[i].energy = energy1 ;
  }

for(loop i=0; i<TOWERS_IN_ETA2*TOWERS_IN_PHI; i++){
    #pragma HLS UNROLL
    ap_uint<12> energy = ECALTowersSLR0[i].energy + ECALTowersSLR0C[i].energy ;
    ECALTowersSLR0[i].energy = energy ;
  }


/*---------------------------------link 0------------------------------------*/
        
link_out[0] = 0;
link_out[1] = 0;
link_out[2] = 0;
link_out[3] = 0;
link_out[4] = 0;

processOutLinks(ECALClustersOut, ECALTowersSLR0, ECALTowersSLR1, ECALTowersSLR2, ECALTowersSLR3, link_out);

}

