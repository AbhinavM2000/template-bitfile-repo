source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load SURF files 
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/base/sync/rtl/Synchronizer.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/base/sync/rtl/RstSync.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/base/general/rtl/Scrambler.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/base/general/rtl/PwrUpRst.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/base/sync/rtl/SynchronizerEdge.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/xilinx/UltraScale+/clocking/rtl/ClockManagerUltraScale.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/axi/bridge/rtl/AxiLiteToDrp.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/axi/axi-lite/rtl/AxiLiteAsync.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/base/ram/inferred/SimpleDualPortRam.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/base/fifo/rtl/inferred/FifoRdFsm.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/base/fifo/rtl/inferred/FifoAsync.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/base/fifo/rtl/inferred/FifoWrFsm.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/base/fifo/rtl/FifoOutputPipeline.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/base/sync/rtl/SynchronizerVector.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/axi/axi-lite/rtl/AxiLitePkg.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/xilinx/general/tb/MmcmEmulation.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/base/general/rtl/StdRtlPkg.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/axi/axi-stream/rtl/AxiStreamPkg.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/axi/axi-stream/rtl/AxiStreamPipeline.vhd"
loadSource -lib surf  -path "$::env(TOP_DIR)/submodules/surf/protocols/pgp/pgp3/core/rtl/Pgp3RxGearboxAligner.vhd"

# Load SURF Simulation Files 
loadSource -lib surf -sim_only -path "$::env(TOP_DIR)/submodules/surf/base/sync/rtl/SynchronizerOneShot.vhd"
loadSource -lib surf -sim_only -path "$::env(TOP_DIR)/submodules/surf/base/general/rtl/TextUtilPkg.vhd"
loadSource -lib surf -sim_only -path "$::env(TOP_DIR)/submodules/surf/base/general/tb/ClkRst.vhd"


#load From CMS-TCDS2 -- moved to Local 
loadSource -lib work -sim_only -path "$::DIR_PATH/rtl/tcds2_bx_and_orbit_pkg.vhd"
loadSource -lib work -sim_only -path "$::DIR_PATH/rtl/orbit_strobe_generator.vhd"


# Load APx-FS  files
#load From Iridis
loadSource -lib apx_fs -path "$::env(TOP_DIR)/submodules/apx-fs/iridisSF/rtl/IridisCSPPkg.vhd"
loadSource -lib apx_fs -path "$::env(TOP_DIR)/submodules/apx-fs/iridisSF/rtl/TCDStoAlgoEvent.vhd"
loadSource -lib apx_fs -path "$::env(TOP_DIR)/submodules/apx-fs/iridisSF/rtl/IridisCSPTx.vhd"
loadSource -lib apx_fs -path "$::env(TOP_DIR)/submodules/apx-fs/iridisSF/rtl/IridisIndexCorrector.vhd"
loadSource -lib apx_fs -path "$::env(TOP_DIR)/submodules/apx-fs/iridisSF/rtl/crc16isf_TGmod.vhd"
loadSource -lib apx_fs -path "$::env(TOP_DIR)/submodules/apx-fs/iridisSF/rtl/CSPRulesPkg.vhd"
loadSource -lib apx_fs -path "$::env(TOP_DIR)/submodules/apx-fs/iridisSF/rtl/IridisCSPRx.vhd"
loadSource -lib apx_fs -path "$::env(TOP_DIR)/submodules/apx-fs/iridisSF/rtl/RxLinkResyncCtrl.vhd"
loadSource -lib apx_fs -path "$::env(TOP_DIR)/submodules/apx-fs/iridisSF/rtl/throttle.vhd"
loadSource -lib apx_fs -path "$::env(TOP_DIR)/submodules/apx-fs/iridisSF/rtl/SideBandGen.vhd"

loadSource -lib apx_fs -path "$::env(TOP_DIR)/submodules/apx-fs/linkBuf/rtl/APxLinkBufferPkg.vhd"
loadSource -lib apx_fs -path "$::env(TOP_DIR)/submodules/apx-fs/linkBuf/rtl/APxLinkBuffer.vhd"

loadIpCore  -path "$::env(TOP_DIR)/submodules/apx-fs/linkBuf/ip/capPbRAM.xci"
loadIpCore  -path "$::env(TOP_DIR)/submodules/apx-fs/iridisSF/ip/fifoTx.xci"
loadIpCore  -path "$::env(TOP_DIR)/submodules/apx-fs/iridisSF/ip/fifoRx.xci"

#loadRuckusTcl $::env(TOP_DIR)/submodules/apx-fs

# Load local source Code and constraints
#loadSource -lib surf -sim_only -path "$::DIR_PATH/rtl/AxiStreamPipelineTb.vhd"
#loadSource -lib work  -path "$::DIR_PATH/rtl/serdes_ideal.vhd"
loadSource -lib work -sim_only -path "$::DIR_PATH/rtl/CSPSimuCtrlPkg.vhd"
loadSource -lib work -sim_only -path "$::DIR_PATH/rtl/CSPSimPkg.vhd"
loadSource -lib work -sim_only -path "$::DIR_PATH/rtl/CSPSimTypePkg.vhd"
loadSource -lib work -sim_only -path "$::DIR_PATH/rtl/IridisCSPTb.vhd"
#loadSource      -dir "$::DIR_PATH/cfg/"
#loadConstraints -dir "$::DIR_PATH/constraints/"


# Set TOP module 
set_property top IridisCSPTx [current_fileset]
update_compile_order -fileset sim_1

# Launch Simulation. 
#launch_simulation

#Define a proper time precision 
set_property -name {xsim.elaborate.xelab.more_options} -value {-timescale 1fs/1fs  -override_timeprecision} -objects [get_filesets sim_1]

#Predefined Time simulation 
set_property -name {xsim.simulate.runtime} -value {500us} -objects [get_filesets sim_1]

# Predefined Wave 
#set Wave $::TOP_DIR/common/SimAPxFS/Wave/
#set Wave_filename  $Wave/IridisSfTb_behav.wcfg
#set_property xsim.view ${Wave_filename} -objects [get_filesets sim_1]
#set_property -name {xsim.simulate.wdb} -value ${Wave_filename} -objects [get_filesets sim_1]
#update_compile_order -fileset sim_1

