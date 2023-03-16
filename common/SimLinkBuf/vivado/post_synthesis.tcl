###############################
## Get variables and procedures
###############################
source -quiet $::env(RUCKUS_DIR)/vivado_env_var.tcl
source -quiet $::env(RUCKUS_DIR)/vivado_proc.tcl

## Bypass the debug chipscope generation
return

#############################
### Open the synthesis design
#############################
open_run synth_1

################################
### Set the name of the ILA core
################################
set ilaName U_IridisRxSf_4

###################
### Create the core
###################
CreateDebugCore ${ilaName}

########################
### Set the record depth
########################
set_property C_DATA_DEPTH 1024 [get_debug_cores ${ilaName}]
#
##################################
### Set the clock for the ILA core
##################################
########################

## ConfigProbe ${ilaName} {U_App/GEN_ETH.U_EthPortMapping/U_SRPv3/axisMaster[tValid]}
## ConfigProbe ${ilaName} {U_App/GEN_ETH.U_EthPortMapping/U_SRPv3/axisMaster[tLast]}
## ConfigProbe ${ilaName} {U_App/GEN_ETH.U_EthPortMapping/U_SRPv3/axisMaster[tUser][1]}
## ConfigProbe ${ilaName} {U_App/GEN_ETH.U_EthPortMapping/U_SRPv3/axisMaster[tKeep][*]}
## ConfigProbe ${ilaName} {U_App/GEN_ETH.U_EthPortMapping/U_SRPv3/axisSlave[tReady]}

###########################
### Write the port map file
###########################
WriteDebugProbes ${ilaName} 
