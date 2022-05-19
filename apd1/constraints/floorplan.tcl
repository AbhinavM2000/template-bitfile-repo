
# -----------------------------------------------------------------------------
# --  AXI infrastructure                                                   ---
# -----------------------------------------------------------------------------
create_pblock axi_if
add_cells_to_pblock [get_pblocks axi_if] [get_cells -quiet [list U_XBAR U_axiInfra]]
resize_pblock [get_pblocks axi_if] -add {CLOCKREGION_X0Y7:CLOCKREGION_X0Y7}
# -----------------------------------------------------------------------------
# --  APx Sectors                                                           ---
# -----------------------------------------------------------------------------
