
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.StdRtlPkg.all;

package PrjSpecPkg is

  constant I2C_C2C_PHY_ADDR_C : integer range 0 to 1023 := 85;


  constant SECTOR_CNT_C : integer := 6;
  constant SLR_CNT_C    : integer := 3;

  constant  CHASSIS_TYPE_C : string  := "APD1_FABRIC0";


  constant SECTOR_0_BASE_ADDR_C : slv(31 downto 0) := x"6F10_0000";
  constant SECTOR_1_BASE_ADDR_C : slv(31 downto 0) := x"6F00_0000";
  constant SECTOR_2_BASE_ADDR_C : slv(31 downto 0) := x"6F08_0000";
  constant SECTOR_3_BASE_ADDR_C : slv(31 downto 0) := x"6F18_0000";
  constant SECTOR_4_BASE_ADDR_C : slv(31 downto 0) := x"6F20_0000";
  constant SECTOR_5_BASE_ADDR_C : slv(31 downto 0) := x"6F28_0000";

  constant APX_INFO_BASE_ADDR_C        : slv(31 downto 0) := x"6ff0_0000";
  constant APX_SECTOR_CTRL_BASE_ADDR_C : slv(31 downto 0) := SECTOR_1_BASE_ADDR_C;

end package PrjSpecPkg;
