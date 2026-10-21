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
--  constant  TX_CHAN_TM_INTERVAL_SIM_C   : natural := 1;   -- TM Interval in units of bunch crossing  
--  constant  TX_CHAN_CLK_RATIO_SIM_C     : natural := 8;    --Ratio of FIFO words to LHC clocks (so excludes throttled words)
--  constant  TX_CHAN_FRAME_INTERVAL_SIM_C : natural := 34;    --spacing of SOF flags in the algo streams (every X FIFO words)
--  constant  TX_CHAN_FRAME_LENGTH_SIM_C  : natural := 28;  -- Number of words in the frame (must be <= TM_INTERVAL * CLK RATIO
--  constant  TX_CHAN_THROTTLE_VECTOR_SIM_C : slv := "000000000000000001";
  constant  TX_CHAN_FRAME_INTERVAL_SIM_C : natural := 8;    --spacing of SOF flags in the algo streams (every X FIFO words)
  constant  TX_CHAN_FRAME_LENGTH_SIM_C  : natural := 8;  -- Number of payload words in the frame 
  constant  TX_CHAN_THROTTLE_VECTOR_SIM_C : slv := "00000000";



  -- 
  --constant RX_CHAN_TM_INTERVAL_SIM_C   : natural := 1;   -- TM Interval in units of bunch crossing  
  --constant RX_CHAN_CLK_RATIO_SIM_C     : natural := 8;    --Ratio of FIFO words to LHC clocks (so excludes throttled words)
  --constant RX_CHAN_FRAME_INTERVAL_SIM_C  : natural := 28;    --spacing of SOF flags in the algo data stream (every X FIFO words)
  --constant RX_CHAN_THROTTLE_VECTOR_SIM_C      : slv:=  "000000000000001111"; 
  --constant RX_CHAN_FRAME_LENGTH_SIM_C         : natural := 28 ; 
  constant RX_CHAN_FRAME_INTERVAL_SIM_C  : natural := 8;    --spacing of SOF flags in the algo data stream (every X FIFO words)
  constant RX_CHAN_FRAME_LENGTH_SIM_C         : natural := 8 ; 
  constant RX_CHAN_THROTTLE_VECTOR_SIM_C      : slv:=  "000000001"; 



 -----------------------------------------------------------------------------------------
 -- Tx config parameters 
  constant  IDLE_METHOD           : sl                := METHOD_2; 
  constant  I2F_FLAG              : sl                := '0';
  constant  RESYNC_DLY            : slv (15 downto 0) := x"00FF";
  constant  LINK_INFO_0           : slv (31 downto 0) := x"ABDC1234";
  constant  LINK_INFO_1           : slv (31 downto 0) := x"FFFF4321";
  constant  TXBUF_BC0_DELAY       : slv (15 downto 0) := x"0009";
  constant  OPW_BC0_DELAY         : slv (15 downto 0) := x"000A";

  constant  INDX_CORRECTION_BLOCK : sl                := DISABLED; 
  constant  MGT_RST_EN            : sl                := DISABLED;
  constant  AUTO_ORBIT_ALIGN      : sl                := DISABLED; 
  constant  RESYNC_DEFAULT        : sl                := ENABLED;
  --constant  RX_RESYNC_DLY         : slv (15 downto 0) := x"01FF";           --this sim measures BC0 arrival at 0x001d
  constant  RX_RESYNC_DLY         : slv (15 downto 0) := x"7c00";           --this sim measures BC0 arrival at 0x001d
  constant  RELEASE_DLY           : slv (15 downto 0) := x"0118";
  constant  RXBUF_BC0_DELAY       : slv (15 downto 0) := X"0117";
 ----------------------------------------------------------------------------------------- 

end package CSPSimulationPkg; 

