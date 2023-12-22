cd $AP_FW_BASE_DIR/

source /opt/Xilinx/Vivado/2021.1/settings64.sh

git clone --recursive ssh://git@gitlab.cern.ch:7999/vu13palgostarterkit/vu13p-algo-starter-kit.git

cd $AP_FW_BASE_DIR/vu13p-algo-starter-kit

mkdir build

cd $AP_FW_BASE_DIR/apx-fs-prj-r2-algo-starter-kit/submodules/cms-tcds2-firmware/components/tcds2_interface/firmware/hdl/

rm -rf tcds2_interface_pkg.vhd

cp /afs/hep.wisc.edu/home/piyushkumar/Public/TCDS/tcds2_interface_pkg.vhd ./

cd $AP_FW_BASE_DIR/vu13p-algo-starter-kit/targets/xF13P/rtl/AlgoRTL

Move the RTL file created during the export IP phase of the Vivado-HLS compilation.

cd $AP_FW_BASE_DIR/vu13p-algo-starter-kit/targets/xF13P/

make

