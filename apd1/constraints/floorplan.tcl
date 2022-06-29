
# -----------------------------------------------------------------------------
# --  AXI infrastructure                                                   ---
# -----------------------------------------------------------------------------
create_pblock axi_if
add_cells_to_pblock [get_pblocks axi_if] [get_cells -quiet [list U_XBAR U_axiInfra U_ApxTcds2 ]]
resize_pblock [get_pblocks axi_if] -add {CLOCKREGION_X0Y7:CLOCKREGION_X1Y7}
# -----------------------------------------------------------------------------
# --  APx Sectors                                                           ---
# -----------------------------------------------------------------------------


# APx Sectors 0
create_pblock Sec_0
#add_cells_to_pblock Sec_0 [get_cells [list {gen_sector[0].U_APxAxiTestIp} ]] 
add_cells_to_pblock Sec_0 [get_cells [list {gen_sector[0].U_ApxL1TSector} ]] 
add_cells_to_pblock Sec_0 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_XBAR_Sec0]] 
resize_pblock [get_pblocks Sec_0] -add {CLOCKREGION_X0Y0:CLOCKREGION_X0Y4}


# APx Sectors 1
create_pblock Sec_1
add_cells_to_pblock Sec_1 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_XBAR_Sec1]] 
add_cells_to_pblock Sec_1 [get_cells [list {gen_sector[1].U_ApxL1TSector}]] 
resize_pblock [get_pblocks Sec_1] -add {CLOCKREGION_X0Y5:CLOCKREGION_X0Y9} 


# APx Sectors 2
create_pblock Sec_2
add_cells_to_pblock Sec_2 [get_cells [list {gen_sector[2].U_ApxL1TSector} ]] 
resize_pblock [get_pblocks Sec_2] -add {CLOCKREGION_X00Y10:CLOCKREGION_X0Y14}

# APx Sectors 3
create_pblock Sec_3
add_cells_to_pblock Sec_3 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_XBAR_Sec3]] 
add_cells_to_pblock Sec_3 [get_cells [list {gen_sector[3].U_ApxL1TSector}]] 
resize_pblock [get_pblocks Sec_3] -add {CLOCKREGION_X5Y0:CLOCKREGION_X5Y4}

# APx Sectors 4
create_pblock Sec_4
add_cells_to_pblock Sec_4 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_XBAR_Sec4]] 
add_cells_to_pblock Sec_4 [get_cells [list {gen_sector[4].U_ApxL1TSector} ]] 
resize_pblock [get_pblocks Sec_4] -add {CLOCKREGION_X5Y5:CLOCKREGION_X5Y9}

# APx Sectors 5
create_pblock Sec_5
add_cells_to_pblock Sec_5 [get_cells [list {gen_sector[5].U_ApxL1TSector}]] 
resize_pblock [get_pblocks Sec_5] -add {CLOCKREGION_X5Y10:CLOCKREGION_X5Y14}


create_pblock AxiRs0_Sec0
add_cells_to_pblock AxiRs0_Sec0 get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_Axi_RegSlice_0_Sec0]
resize_pblock [get_pblocks AxiRs0_Sec0] -add {CLOCKREGION_X0Y4:CLOCKREGION_X0Y4}

create_pblock AxiRs1_Sec0
add_cells_to_pblock AxiRs1_Sec0 get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_Axi_RegSlice_1_Sec0]
#resize_pblock [get_pblocks AxiRs1_Sec0] -add {CLOCKREGION_X0Y0:CLOCKREGION_X0Y0}
resize_pblock AxiRs1_Sec0 -add SLICE_X0Y0:SLICE_X11Y29 -locs keep_all -replace

create_pblock AxiRs_Sec2
add_cells_to_pblock AxiRs_Sec2 get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_Axi_RegSlice_Sec2]
resize_pblock [get_pblocks AxiRs_Sec2] -add {CLOCKREGION_X0Y10:CLOCKREGION_X0Y10}

create_pblock AxiRs_Sec3
add_cells_to_pblock AxiRs_Sec3 get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_Axi_RegSlice_Sec3]
resize_pblock [get_pblocks AxiRs_Sec3] -add {CLOCKREGION_X5Y0:CLOCKREGION_X5Y0}


create_pblock AxiRs_Sec4
add_cells_to_pblock AxiRs_Sec4 get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_Axi_RegSlice_Sec4]
#resize_pblock [get_pblocks AxiRs_Sec4] -add {CLOCKREGION_X5Y5:CLOCKREGION_X5Y5}
resize_pblock AxiRs_Sec4 -add SLICE_X157Y300:SLICE_X168Y329 -locs keep_all -replace

create_pblock AxiRs_Sec5
add_cells_to_pblock AxiRs_Sec5 get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_Axi_RegSlice_Sec5]
resize_pblock [get_pblocks AxiRs_Sec5] -add {CLOCKREGION_X5Y10:CLOCKREGION_X5Y10}


add_cells_to_pblock Sec_0 [get_cells [list {U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/axiRstSec_reg[0]}]] 
add_cells_to_pblock Sec_1 [get_cells [list {U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/axiRstSec_reg[1]}]] 
add_cells_to_pblock Sec_2 [get_cells [list {U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/axiRstSec_reg[2]}]]
add_cells_to_pblock Sec_3 [get_cells [list {U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/axiRstSec_reg[3]}]] 
add_cells_to_pblock Sec_4 [get_cells [list {U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/axiRstSec_reg[4]}]] 
add_cells_to_pblock Sec_5 [get_cells [list {U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/axiRstSec_reg[5]}]] 
