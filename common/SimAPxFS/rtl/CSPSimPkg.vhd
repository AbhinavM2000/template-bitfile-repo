library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


Library surf;
use surf.StdRtlPkg.all;

use work.CSPSimTypePkg.all; 

package CSPSimulationPkg is 

  -----------------------------------------------------------------------------------
  -----------------------------------------------------------------------------------
  --
  -----  User Defined  parameters. 
  -----------------------------------------------------------------------------------
  -----------------------------------------------------------------------------------
  constant  TX_CHAN_TM_INTERVAL_SIM_C   : natural := 6;   -- TM Interval in units of bunch crossing  
  constant  TX_CHAN_CLK_RATIO_SIM_C     : natural := 9;    -- Ratio of algo clocks to LHC clocks 
  constant  TX_CHAN_FRAME_LENGTH_SIM_C  : natural := 54;  -- Number of words in the frame (must be <= TM_INTERVAL * CLK RATIO
  constant  TX_CHAN_FIFO_WORDS_PER_FRAME_SIM_C : natural := 54; --number of FIFO words read, including frame data + idle ***DOES NOT INCLUDE THROTTLED CLOCK CYCLES
  constant  TX_CHAN_THROTTLE_VECTOR_SIM_C : slv := "000000000";

  -- 
  constant RX_CHAN_TM_INTERVAL_SIM_C   : natural := 6;   -- TM Interval in units of bunch crossing  
  constant RX_CHAN_CLK_RATIO_SIM_C     : natural := 9;
  constant RX_CHAN_THROTTLE_VECTOR_SIM_C      : slv:=  "000000000"; 
  constant RX_CHAN_FRAME_LENGTH_SIM_C         : natural := 54 ; 



 ----------------------------------------------------------------------------------------- 
  constant  IDLE_METHOD           : sl                := METHOD_2; 
  constant  RESYNC_DLY            : slv (15 downto 0) := x"0050";
  constant  LINK_INFO_0           : slv (31 downto 0) := x"ABDC1234";
  constant  LINK_INFO_1           : slv (31 downto 0) := x"FFFF4321";

  constant  INDX_CORRECTION_BLOCK : sl                := DISABLED; 
  constant  MGT_RST_EN            : sl                := DISABLED;
  constant  AUTO_ORBIT_ALIGN      : sl                := DISABLED; 
  constant  RESYNC_DEFAULT        : sl                := ENABLED;
  constant  RX_RESYNC_DLY         : slv (15 downto 0) := x"0000";
  constant  RELEASE_DLY           : slv (15 downto 0) := x"0150";
 ----------------------------------------------------------------------------------------- 

end package CSPSimulationPkg; 

