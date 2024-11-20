cd $AP_FW_BASE_DIR/

source /opt/Xilinx/Vivado/2023.1/settings64.sh

git clone --branch rct-latest --recurse-submodules ssh://git@gitlab.cern.ch:7999/amohan/rct-17-x-6-abnv-calibration.git


cd rct-17-x-6-abnv-calibration
mkdir build

cd rct-17-x-6-abnv-calibration/submodules/cms-tcds2-firmware/components/tcds2_interface/firmware/hdl/

rm -rf tcds2_interface_pkg.vhd

cp /afs/hep.wisc.edu/home/piyushkumar/Public/TCDS/tcds2_interface_pkg.vhd ./

cd rct-17-x-6-abnv-calibration/targets/xF13P/

make

This will create the bitfile for the entire project 

In any case a rebuild is required: use the following command

make clean

make





To test the bitfile, please copy the following directory in your area (the scratch area of the beck machine is preferable as it is directly accessible from the Falcon's ELM)

/afs/hep.wisc.edu/home/piyushkumar/Public/APxFTestFiles/apx-pattern-testing-xF

The folder inside this directory named "RCT17x6_ALL_IPs" contains Rx, Tx config files, input test vector (for one LHC event). Please copy your bitfile in this area. 

Login to a falcon machine with -2 VU13P FPGA: I have tested it on falcon5-linux (In any case ping Ales before such that the test can be performed without any collision with someone else test)

Following are the instructions for testing the bitfile on falcon5-linux machine

ssh falcon5-linux

cd $AP_FW_BASE_DIR/apx-pattern-testing-xF (in your scratch area)

bitfile="$AP_FW_BASE_DIR/apx-pattern-testing-xF/RCT17x6_ALL_IPs/xF13P_top.bit"

apx-prime -H localhost -c config.ini -s "device fpga.bitfile=$bitfile" 

sh pattern_test.sh falcon5-linux RCT17x6_ALL_IPs/buf_cfg_rx_playback_RCT17x6.txt RCT17x6_ALL_IPs/buf_cfg_tx_capture_RCT17x6.txt RCT17x6_ALL_IPs/RCT17x6_TV_1BX_RTL.txt RCT17x6_ALL_IPs/RCT17x6_OUT.txt 2 9

RCT17x6_OUT.txt is the output test vector printed. You can compare the values of this file with reference output file "RCT17x6_REFOUT1BX.txt". This refernece output is captured and verified at the following level:

HLS == RTL == bitfile



