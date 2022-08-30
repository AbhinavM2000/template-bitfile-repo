
# -----------------------------------------------------------------------------
# --  AXI infrastructure                                                   ---
# -----------------------------------------------------------------------------
#delete_pblocks -quiet [get_pblocks -quiet axi_ifr]
#delete_pblocks -quiet [get_pblocks -quiet Sec_0]
#delete_pblocks -quiet [get_pblocks -quiet Sec_1]
#delete_pblocks -quiet [get_pblocks -quiet Sec_2]
#delete_pblocks -quiet [get_pblocks -quiet Sec_3]
#delete_pblocks -quiet [get_pblocks -quiet Sec_4]
#delete_pblocks -quiet [get_pblocks -quiet Sec_5]

#delete_pblocks -quiet [get_pblocks -quiet AxiRs0_Sec0]
#delete_pblocks -quiet [get_pblocks -quiet AxiRs1_Sec0]
#delete_pblocks -quiet [get_pblocks -quiet AxiRs_Sec2]
#delete_pblocks -quiet [get_pblocks -quiet AxiRs_Sec3]
#delete_pblocks -quiet [get_pblocks -quiet AxiRs_Sec4]
#delete_pblocks -quiet [get_pblocks -quiet AxiRs_Sec5]

   create_pblock Sec_0
   add_cells_to_pblock Sec_0 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_XBAR_Sec0]] 
   resize_pblock [get_pblocks Sec_0] -add {CLOCKREGION_X0Y0:CLOCKREGION_X0Y4}


# APx Sectors 1
   create_pblock Sec_1
   add_cells_to_pblock Sec_1 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_XBAR_Sec1]] 
   resize_pblock [get_pblocks Sec_1] -add {CLOCKREGION_X0Y5:CLOCKREGION_X0Y9} 


# APx Sectors 2
   create_pblock Sec_2
   resize_pblock [get_pblocks Sec_2] -add {CLOCKREGION_X00Y10:CLOCKREGION_X0Y14}

# APx Sectors 3
   create_pblock Sec_3
   add_cells_to_pblock Sec_3 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_XBAR_Sec3]] 
   resize_pblock [get_pblocks Sec_3] -add {CLOCKREGION_X5Y0:CLOCKREGION_X5Y4}

# APx Sectors 4
   create_pblock Sec_4
   add_cells_to_pblock Sec_4 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_XBAR_Sec4]] 
  resize_pblock [get_pblocks Sec_4] -add {CLOCKREGION_X5Y5:CLOCKREGION_X5Y9}

# APx Sectors 5
  create_pblock Sec_5
  resize_pblock [get_pblocks Sec_5] -add {CLOCKREGION_X5Y10:CLOCKREGION_X5Y14}


   create_pblock AxiRs0_Sec0
   add_cells_to_pblock AxiRs0_Sec0 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_Axi_RegSlice_0_Sec0]]
   resize_pblock [get_pblocks AxiRs0_Sec0] -add {CLOCKREGION_X0Y4:CLOCKREGION_X0Y4}

   create_pblock AxiRs1_Sec0
   add_cells_to_pblock AxiRs1_Sec0 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_Axi_RegSlice_1_Sec0]]
   #resize_pblock [get_pblocks AxiRs1_Sec0] -add {CLOCKREGION_X0Y0:CLOCKREGION_X0Y0}
   resize_pblock AxiRs1_Sec0 -add SLICE_X0Y0:SLICE_X11Y29 -locs keep_all -replace

   create_pblock AxiRs_Sec2
   add_cells_to_pblock AxiRs_Sec2 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_Axi_RegSlice_Sec2]]
   resize_pblock [get_pblocks AxiRs_Sec2] -add {CLOCKREGION_X0Y10:CLOCKREGION_X0Y10}

   create_pblock AxiRs_Sec3
   add_cells_to_pblock AxiRs_Sec3 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_Axi_RegSlice_Sec3]]
   resize_pblock [get_pblocks AxiRs_Sec3] -add {CLOCKREGION_X5Y0:CLOCKREGION_X5Y0}


  create_pblock AxiRs_Sec4
  add_cells_to_pblock AxiRs_Sec4 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_Axi_RegSlice_Sec4]]
  #resize_pblock [get_pblocks AxiRs_Sec4] -add {CLOCKREGION_X5Y5:CLOCKREGION_X5Y5}
  resize_pblock AxiRs_Sec4 -add SLICE_X157Y300:SLICE_X168Y329 -locs keep_all -replace

   create_pblock AxiRs_Sec5
   add_cells_to_pblock AxiRs_Sec5 [get_cells [list U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/U_Axi_RegSlice_Sec5]]
   resize_pblock [get_pblocks AxiRs_Sec5] -add {CLOCKREGION_X5Y10:CLOCKREGION_X5Y10}


   add_cells_to_pblock Sec_0 [get_cells [list {U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/axiRstSec_reg[0]}]] 
   add_cells_to_pblock Sec_1 [get_cells [list {U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/axiRstSec_reg[1]}]] 
   add_cells_to_pblock Sec_2 [get_cells [list {U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/axiRstSec_reg[2]}]]
   add_cells_to_pblock Sec_3 [get_cells [list {U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/axiRstSec_reg[3]}]] 
  add_cells_to_pblock Sec_4 [get_cells [list {U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/axiRstSec_reg[4]}]] 
  add_cells_to_pblock Sec_5 [get_cells [list {U_ApxSectorChassisWrapper/genApd1Fabric0.U_ChassisApd1Fabric0/axiRstSec_reg[5]}]] 


create_pblock axi_ifr
add_cells_to_pblock [get_pblocks axi_ifr] [get_cells -quiet [list U_XBAR U_axiInfra U_ApxTcds2]]
resize_pblock [get_pblocks axi_ifr] -add {CLOCKREGION_X0Y7:CLOCKREGION_X1Y7}
remove_cells_from_pblock axi_ifr [get_cells [list U_axiInfra/gen_osc_300.U_clk_gen_300/inst/*]]

# -----------------------------------------------------------------------------
# --  APx Sectors                                                           ---
# -----------------------------------------------------------------------------
# --       Define Boundaries  per SLR  0                                --
# -----------------------------------------------------------------------------
   set uCntrQuad 0 
   set uSlr 0
   set lLeftQuadWidth 780
   set lRightQuadWidth 600

   set lSlr [get_slr]
   set UserSlr [lindex ${lSlr} $uSlr]
   set lUserClkRegions [get_clock_regions -of_objects $UserSlr]
   puts "Clock region User defined ${lUserClkRegions}"

   set lClkBounds [get_XY_bounds [get_clock_regions  $lUserClkRegions]]
   puts "Clock region boundaries ${lClkBounds}"
   # Cleanup the old pblocks
   delete_pblocks -quiet [get_pblocks -quiet quad_*]
# ----------------------------------------------------------------------------
# --        Create Pblocks per SLR .                                        --
# -----------------------------------------------------------------------------
   lassign [create_quad_pblocks $lLeftQuadWidth $lRightQuadWidth $lUserClkRegions $uCntrQuad] lNumQuads lLeftBoundary lRightBoundary
    puts "Created $lNumQuads quads"
    puts "Left  $lLeftBoundary boundary"
    puts "Right $lRightBoundary boundary"

# -----------------------------------------------------------------------------
# --        Parameters Defined by User  "Left side"                          --
# -----------------------------------------------------------------------------  
    set NumbersQuad 3 
    set OffsetQuad 1 
    set InitialLink 0
    set SectorNumber 0      
      
  fill_quad_pblock $NumbersQuad $OffsetQuad $InitialLink "quad_L" $SectorNumber
  
# -----------------------------------------------------------------------------
# --        Parameters Defined by User  "Right side"                         --
# -----------------------------------------------------------------------------  
    set NumbersQuad 3
    set OffsetQuad 2 
    set InitialLink 48
    set SectorNumber 3     
  

  fill_quad_pblock $NumbersQuad $OffsetQuad $InitialLink "quad_R" $SectorNumber
# -----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# --       Define Boundaries  per SLR   1                                    --
# -----------------------------------------------------------------------------
   set uSlr 1
   set uCntrQuad 5 
   set lLeftQuadWidth 780
   set lRightQuadWidth 600

   set lSlr [get_slr]
   set UserSlr [lindex ${lSlr} $uSlr]
   set lUserClkRegions [get_clock_regions -of_objects $UserSlr]
   puts "Clock region User defined ${lUserClkRegions}"

   set lClkBounds [get_XY_bounds [get_clock_regions  $lUserClkRegions]]
   puts "Clock region boundaries ${lClkBounds}"
  
# ----------------------------------------------------------------------------
# --        Create Pblocks per SLR .                                        --
# -----------------------------------------------------------------------------
   lassign [create_quad_pblocks $lLeftQuadWidth $lRightQuadWidth $lUserClkRegions $uCntrQuad] lNumQuads lLeftBoundary lRightBoundary
    puts "Created $lNumQuads quads"
    puts "Left  $lLeftBoundary boundary"
    puts "Right $lRightBoundary boundary"
   
    # Delete pblock for AxiInfra
    delete_pblocks -quiet quad_L7
   
# -----------------------------------------------------------------------------
# --        Parameters Defined by User  "Left side"                          --
# -----------------------------------------------------------------------------  
    set NumbersQuad 2
    set OffsetQuad 5
    set InitialLink 12
    set SectorNumber 1     
     
  fill_quad_pblock $NumbersQuad $OffsetQuad $InitialLink "quad_L" $SectorNumber
 
# -----------------------------------------------------------------------------
# --        Parameters Defined by User  "Left side"                          --
# -----------------------------------------------------------------------------  
    set NumbersQuad 2
    set OffsetQuad 8
    set InitialLink 20
    set SectorNumber 1     
     
  fill_quad_pblock $NumbersQuad $OffsetQuad $InitialLink "quad_L" $SectorNumber

# -----------------------------------------------------------------------------
# --        Parameters Defined by User  "Right side"                         --
# -----------------------------------------------------------------------------  
    set NumbersQuad 5 
    set OffsetQuad 5
    set InitialLink 60
    set SectorNumber 4     
 
  fill_quad_pblock $NumbersQuad $OffsetQuad $InitialLink "quad_R" $SectorNumber  
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# --       Define Boundaries  per SLR  2                                       --
# -----------------------------------------------------------------------------
   set uSlr 2
   set uCntrQuad 10 
   set lLeftQuadWidth 780
   set lRightQuadWidth 600

   set lSlr [get_slr]
   set UserSlr [lindex ${lSlr} $uSlr]
   set lUserClkRegions [get_clock_regions -of_objects $UserSlr]
   puts "Clock region User defined ${lUserClkRegions}"

   set lClkBounds [get_XY_bounds [get_clock_regions  $lUserClkRegions]]
   puts "Clock region boundaries ${lClkBounds}"
  
# ----------------------------------------------------------------------------
# --        Create Pblocks per SLR .                                        --
# -----------------------------------------------------------------------------
   lassign [create_quad_pblocks $lLeftQuadWidth $lRightQuadWidth $lUserClkRegions $uCntrQuad] lNumQuads lLeftBoundary lRightBoundary
    puts "Created $lNumQuads quads"
    puts "Left  $lLeftBoundary boundary"
    puts "Right $lRightBoundary boundary"
   
# -----------------------------------------------------------------------------
# --        Parameters Defined by User  "Left side"                          --
# -----------------------------------------------------------------------------  
    set NumbersQuad 5
    set OffsetQuad 10
    set InitialLink 28
    set SectorNumber 2    
     
 fill_quad_pblock $NumbersQuad $OffsetQuad $InitialLink "quad_L" $SectorNumber
# -----------------------------------------------------------------------------
# --        Parameters Defined by User  "Right side"                         --
# -----------------------------------------------------------------------------  
    set NumbersQuad 5 
    set OffsetQuad 10
    set InitialLink 80
    set SectorNumber 5    
    
     
 fill_quad_pblock $NumbersQuad $OffsetQuad $InitialLink "quad_R" $SectorNumber 