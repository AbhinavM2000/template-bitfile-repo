
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.StdRtlPkg.all;

package PrjSpecPkg is

  constant SECTOR_CNT_C : integer := 6;
  constant SLR_CNT_C    : integer := 3;

  constant  CHASSIS_TYPE_C : string  := "APD1_FABRIC0";


  constant SECTOR_0_BASE_ADDR_C : slv(31 downto 0) := x"6010_0000";
  constant SECTOR_1_BASE_ADDR_C : slv(31 downto 0) := x"6000_0000";
  constant SECTOR_2_BASE_ADDR_C : slv(31 downto 0) := x"6008_0000";
  constant SECTOR_3_BASE_ADDR_C : slv(31 downto 0) := x"6018_0000";
  constant SECTOR_4_BASE_ADDR_C : slv(31 downto 0) := x"6020_0000";
  constant SECTOR_5_BASE_ADDR_C : slv(31 downto 0) := x"6028_0000";

  constant APX_INFO_BASE_ADDR_C        : slv(31 downto 0) := x"6A00_0000";
  constant APX_SECTOR_CTRL_BASE_ADDR_C : slv(31 downto 0) := SECTOR_1_BASE_ADDR_C;

end package PrjSpecPkg;
