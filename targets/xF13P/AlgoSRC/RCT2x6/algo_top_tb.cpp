#include "algo_top.h"
#include <cstdlib>

int main(){

  srand((unsigned)time(0));

ap_uint<576> link_in[N_INPUT_LINKS] ;
ap_uint<576> link_out[N_OUTPUT_LINKS] ;
ap_uint<16> crystal[5][6][25] = {0} ;
//ap_uint<16> crystal[3][6][25] = {0} ;

        for(loop i=0; i<N_INPUT_LINKS; i=i+6){
          for(loop k=0; k<6; k++){
                for(loop j=0; j<25; j++){
          crystal[i/6][k][j] = 0 ;
          if(i==0 && k==0 && j==0) crystal[i/6][k][j] = 100 ;
          if(i==0 && k==1 && j==0) crystal[i/6][k][j] = 200 ;
          if(i==0 && k==2 && j==0) crystal[i/6][k][j] = 150 ;
          if(i==0 && k==4 && j==20) crystal[i/6][k][j] = 45 ;
          if(i==0 && k==4 && j==9) crystal[i/6][k][j] = 16 ;
          if(i==6 && k==0 && j==13) crystal[i/6][k][j] = 50 ;
          if(i==12 && k==3 && j==20) crystal[i/6][k][j] = 35 ;
          if(i==12 && k==4 && j==10) crystal[i/6][k][j] = 37 ;
          if(i==12 && k==5 && j==10) crystal[i/6][k][j] = 17 ;
          if(i==18 && k==0 && j==3) crystal[i/6][k][j] = 25 ;
          if(i==18 && k==0 && j==24) crystal[i/6][k][j] = 20 ;
          if(i==18 && k==2 && j==20) crystal[i/6][k][j] = 10 ;
          if(i==18 && k==4 && j==12) crystal[i/6][k][j] = 15 ;
        }}}


        for(loop j=0; j<N_INPUT_LINKS; j=j+6){
        for(loop i=0; i<6; i++){
        ap_uint<10> start = 0;
        ap_uint<10> end = 571;
          link_in[i+j].range(end, start) = 0 ;
          for(loop k=0; k<25; k++){
          start = k*16;
          link_in[i+j].range(start+15, start) = crystal[j/6][i][k] ;
        }}}


        for(int i=0; i<N_INPUT_LINKS; i++){
                cout << hex << "link_in[" << i << "]: " << link_in[i] << endl;
        }

        cout << endl;

        algo_top(link_in, link_out);

        for(int i=0; i<N_OUTPUT_LINKS; i++){
                cout << hex << "link_out[" << i << "]: " << link_out[i] << endl;
        }

        ecalcluster cluster;

        for(loop i = 0; i <9; i++){
        ap_uint<10> start = i*64;
        ap_uint<10> end = start+63;
        cluster.fillecalcluster(((ap_uint<64>) link_out[0].range(end, start))) ;
        cout << " cluster Seed " << cluster.seedEnergy
         << " energy " << cluster.energy
         << " eta " << cluster.eta
         << " phi " << cluster.phi << endl ;
        }

        for(loop i = 0; i <30; i++){
        ap_uint<10> start = i*18;
        ap_uint<10> end = start + 17;
        cout << " tower " << i << " energy " <<  link_out[1].range(end, start) << endl ;
        }

  return 0;
}
