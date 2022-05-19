# Load RUCKUS environment and library
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

# Load SURF ruckus.tcl file
#loadRuckusTcl $::env(TOP_DIR)/submodules/surf
loadRuckusTcl $::env(TOP_DIR)/submodules/surf/base
loadRuckusTcl $::env(TOP_DIR)/submodules/surf/axi/axi-lite
loadRuckusTcl $::env(TOP_DIR)/submodules/surf/axi/axi-stream
loadRuckusTcl $::env(TOP_DIR)/submodules/surf/axi/bridge
loadRuckusTcl $::env(TOP_DIR)/submodules/surf/xilinx
loadRuckusTcl $::env(TOP_DIR)/submodules/surf/protocols/i2c
loadRuckusTcl $::env(TOP_DIR)/submodules/surf/protocols/pgp/pgp3/core


# Load APx-FS ruckus.tcl file
loadRuckusTcl $::env(TOP_DIR)/submodules/apx-fs

# Load local source Code and constraints
loadSource      -dir "$::DIR_PATH/rtl/"
loadSource      -dir "$::DIR_PATH/cfg/"
loadConstraints -dir "$::DIR_PATH/constraints/"

# Area constraints used in the implementation  only
set_property used_in_synthesis false [get_files  $::DIR_PATH/constraints/floorplan.tcl]
