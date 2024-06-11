cd $AP_FW_BASE_DIR/

source /opt/Xilinx/Vivado/2021.1/settings64.sh

git clone --recursive ssh://git@gitlab.cern.ch:7999/rct17x6/rct-17x6.git

cd $AP_FW_BASE_DIR/rct-17x6

mkdir build

cd $AP_FW_BASE_DIR/rct-17x6/submodules/cms-tcds2-firmware/components/tcds2_interface/firmware/hdl/

rm -rf tcds2_interface_pkg.vhd

cp /afs/hep.wisc.edu/home/piyushkumar/Public/TCDS/tcds2_interface_pkg.vhd ./

cd $AP_FW_BASE_DIR/vu13p-algo-starter-kit/targets/xF13P/

make

