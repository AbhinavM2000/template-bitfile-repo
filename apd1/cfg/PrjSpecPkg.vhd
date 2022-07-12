
library IEEE;
use IEEE.STD_LOGIC_1164.all;

Library surf;
use surf.StdRtlPkg.all;

Library apx_fs;
use apx_fs.MgtPkg.all;
use apx_fs.ApxSectorPkg.all;
use apx_fs.ApxL1TPkg.all;




package PrjSpecPkg is

  constant I2C_C2C_PHY_ADDR_C : integer range 0 to 1023 := 85;

  constant    FS_TO_LHC_CLK_FACTOR_C : natural range 1 to 12 := 9;

  constant SECTOR_CNT_C : integer := 6;
  constant SLR_CNT_C    : integer := 3;

  constant  CHASSIS_TYPE_C : string  := "APD1_FABRIC0";


  constant SECTOR_0_BASE_ADDR_C : slv(31 downto 0) := x"6F10_0000";
  constant SECTOR_1_BASE_ADDR_C : slv(31 downto 0) := x"6F00_0000";
  constant SECTOR_2_BASE_ADDR_C : slv(31 downto 0) := x"6F08_0000";
  constant SECTOR_3_BASE_ADDR_C : slv(31 downto 0) := x"6F18_0000";
  constant SECTOR_4_BASE_ADDR_C : slv(31 downto 0) := x"6F20_0000";
  constant SECTOR_5_BASE_ADDR_C : slv(31 downto 0) := x"6F28_0000";
  constant TCDS_CTRL_BASE_ADDR_C: slv(31 downto 0) := x"6F40_0000";   -- Comment: by Lpm Temporal, hbd
  constant APX_TCDS_MON_BASE_ADDR_C:  slv(31 downto 0) := x"6F60_0000";   -- Comment: by Lpm Temporal, hbd
  
  
  constant APX_INFO_BASE_ADDR_C        : slv(31 downto 0) := x"6ff0_0000";
  constant APX_SECTOR_CTRL_BASE_ADDR_C : slv(31 downto 0) := SECTOR_1_BASE_ADDR_C;


 constant L1T_IN_STREAM_CNT_C  : integer := 100;
  constant L1T_OUT_STREAM_CNT_C : integer := 100;



  constant QPLL_CNT_C   : integer := 25;
  constant REFCLK_CNT_C : integer := 16;
  constant MGT_CNT_C    : integer := 100;

 constant RefClk0CfgImpl_C : tRefClkCfgArr(0 to REFCLK_CNT_C-1) := (
    0      => (enabled => true, sector => 0),
    1      => (enabled => true, sector => 0),
    2      => (enabled => true, sector => 1),
--  3      => (enabled => true, sector => 1),
    4      => (enabled => true, sector => 1),
    5      => (enabled => true, sector => 2),
    6      => (enabled => true, sector => 2),
    7      => (enabled => true, sector => 2),
    8      => (enabled => true, sector => 3),
    9      => (enabled => true, sector => 3),
    10     => (enabled => true, sector => 4),
    11     => (enabled => true, sector => 4),
    12     => (enabled => true, sector => 4),
    13     => (enabled => true, sector => 5),
    14     => (enabled => true, sector => 5),
    15     => (enabled => true, sector => 5),
    others => RefClkCfgOff_C
    );

  constant RefClk1CfgImpl_C : tRefClkCfgArr(0 to REFCLK_CNT_C-1) := (
    0      => (enabled => true, sector => 0),
    1      => (enabled => true, sector => 0),
    2      => (enabled => true, sector => 1),
--  3      => (enabled => true, sector => 1),
    4      => (enabled => true, sector => 1),
    5      => (enabled => true, sector => 2),
    6      => (enabled => true, sector => 2),
    7      => (enabled => true, sector => 2),
    8      => (enabled => true, sector => 3),
    9      => (enabled => true, sector => 3),
    10     => (enabled => true, sector => 4),
    11     => (enabled => true, sector => 4),
    12     => (enabled => true, sector => 4),
    13     => (enabled => true, sector => 5),
    14     => (enabled => true, sector => 5),
    15     => (enabled => true, sector => 5),
    others => RefClkCfgOff_C
        );

  constant QpllCfgImpl_C : tQpllCfgArr(0 to QPLL_CNT_C-1) := (
    0      => (kind => gty_qpll_25g, enabled => true, refclk0 => 0, refclk1 => 0, sector => 0),
    1      => (kind => gty_qpll_25g, enabled => true, refclk0 => 0, refclk1 => 0, sector => 0),
    2      => (kind => gty_qpll_25g, enabled => true, refclk0 => 1, refclk1 => 1, sector => 0),
    3      => (kind => gty_qpll_25g, enabled => true, refclk0 => 2, refclk1 => 2, sector => 1),
    4      => (kind => gty_qpll_25g, enabled => true, refclk0 => 2, refclk1 => 2, sector => 1),
    5      => (kind => gty_qpll_25g, enabled => true, refclk0 => 4, refclk1 => 4, sector => 1),
    6      => (kind => gty_qpll_25g, enabled => true, refclk0 => 4, refclk1 => 4, sector => 1),
    7      => (kind => gty_qpll_25g, enabled => true, refclk0 => 5, refclk1 => 5, sector => 2),
    8      => (kind => gty_qpll_25g, enabled => true, refclk0 => 5, refclk1 => 5, sector => 2),
    9      => (kind => gty_qpll_25g, enabled => true, refclk0 => 6, refclk1 => 6, sector => 2),
    10     => (kind => gty_qpll_25g, enabled => true, refclk0 => 7, refclk1 => 7, sector => 2),
    11     => (kind => gty_qpll_25g, enabled => true, refclk0 => 7, refclk1 => 7, sector => 2),
    12     => (kind => gty_qpll_25g, enabled => true, refclk0 => 8, refclk1 => 8, sector => 3),
    13     => (kind => gty_qpll_25g, enabled => true, refclk0 => 8, refclk1 => 8, sector => 3),
    14     => (kind => gty_qpll_25g, enabled => true, refclk0 => 9, refclk1 => 9, sector => 3),
    15     => (kind => gty_qpll_25g, enabled => true, refclk0 => 10, refclk1 => 10, sector => 4),
    16     => (kind => gty_qpll_25g, enabled => true, refclk0 => 10, refclk1 => 10, sector => 4),
    17     => (kind => gty_qpll_25g, enabled => true, refclk0 => 11, refclk1 => 11, sector => 4),
    18     => (kind => gty_qpll_25g, enabled => true, refclk0 => 12, refclk1 => 12, sector => 4),
    19     => (kind => gty_qpll_25g, enabled => true, refclk0 => 12, refclk1 => 12, sector => 4),
    20     => (kind => gty_qpll_25g, enabled => true, refclk0 => 13, refclk1 => 13, sector => 5),
    21     => (kind => gty_qpll_25g, enabled => true, refclk0 => 13, refclk1 => 13, sector => 5),
    22     => (kind => gty_qpll_25g, enabled => true, refclk0 => 14, refclk1 => 14, sector => 5),
    23     => (kind => gty_qpll_25g, enabled => true, refclk0 => 15, refclk1 => 15, sector => 5),
    24     => (kind => gty_qpll_25g, enabled => true, refclk0 => 15, refclk1 => 15, sector => 5),
    others => QpllCfgOff_C
    );


constant MgtCfgImplNone_C : tMgtCfgArr(0 to MGT_CNT_C-1) := (
    others => MgtCfgOff_C
    );


constant MgtCfgImpl67_C : tMgtCfgArr(0 to MGT_CNT_C-1) := (
    --0  => (kind => gty_sym_25p78125, sector => 0, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    --1  => (kind => gty_sym_25p78125, sector => 0, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    --2  => (kind => gty_sym_25p78125, sector => 0, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    --3  => (kind => gty_sym_25p78125, sector => 0, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    --4  => (kind => gty_sym_25p78125, sector => 0, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    --5  => (kind => gty_sym_25p78125, sector => 0, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    --6  => (kind => gty_sym_25p78125, sector => 0, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    --7  => (kind => gty_sym_25p78125, sector => 0, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    8  => (kind => gty_sym_25p78125, sector => 0, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    9  => (kind => gty_sym_25p78125, sector => 0, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    10 => (kind => gty_sym_25p78125, sector => 0, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    11 => (kind => gty_sym_25p78125, sector => 0, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),

    12 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    13 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    14 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    15 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    16 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    17 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    18 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    19 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),

    20 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    21 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    22 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    23 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    24 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    25 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    26 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    27 => (kind => gty_sym_25p78125, sector => 1, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),

    28 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    29 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    30 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    31 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    32 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    33 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    34 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    35 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    36 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    37 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    38 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    39 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    40 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    41 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    42 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    43 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    44 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    45 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    46 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    47 => (kind => gty_sym_25p78125, sector => 2, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),

    48 => (kind => gty_sym_25p78125, sector => 3, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    49 => (kind => gty_sym_25p78125, sector => 3, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    50 => (kind => gty_sym_25p78125, sector => 3, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    51 => (kind => gty_sym_25p78125, sector => 3, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    52 => (kind => gty_sym_25p78125, sector => 3, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    53 => (kind => gty_sym_25p78125, sector => 3, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    54 => (kind => gty_sym_25p78125, sector => 3, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    55 => (kind => gty_sym_25p78125, sector => 3, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    56 => (kind => gty_sym_25p78125, sector => 3, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    57 => (kind => gty_sym_25p78125, sector => 3, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    58 => (kind => gty_sym_25p78125, sector => 3, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    59 => (kind => gty_sym_25p78125, sector => 3, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),

    60 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    61 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    62 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    63 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    64 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    65 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    66 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    67 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    68 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    69 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    70 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    71 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    72 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    73 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    74 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    75 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    76 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    77 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    78 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    79 => (kind => gty_sym_25p78125, sector => 4, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),

    80 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    81 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    82 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    83 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    84 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    85 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    86 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    87 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    88 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    89 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    90 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    91 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    92 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    93 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    94 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    95 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    96 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '1'),
    97 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '0', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '1'),
    98 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),
    99 => (kind => gty_sym_25p78125, sector => 5, rxLineRate => 25871250, rx_enc => enc_64b66b, rx_polarity => '1', txLineRate => 25871250, tx_enc => enc_64b66b, tx_polarity => '0'),

    others => MgtCfgOff_C
    );
    

constant apxL1TCfgArrImpl : tApxL1TCfgArr(0 to L1T_IN_STREAM_CNT_C-1) := (
    --0  => (sector => 0, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    --1  => (sector => 0, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    --2  => (sector => 0, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    --3  => (sector => 0, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    --4  => (sector => 0, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    --5  => (sector => 0, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    --6  => (sector => 0, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    --7  => (sector => 0, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    8  => (sector => 0, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    9  => (sector => 0, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    10 => (sector => 0, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    11 => (sector => 0, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    12 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    13 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    14 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    15 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    16 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    17 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    18 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    19 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    20 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    21 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    22 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    23 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    24 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    25 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    26 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    27 => (sector => 1, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    28 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    29 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    30 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    31 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    32 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    33 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    34 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    35 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    36 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    37 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    38 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    39 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    40 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    41 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    42 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    43 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    44 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    45 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    46 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    47 => (sector => 2, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    48 => (sector => 3, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    49 => (sector => 3, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    50 => (sector => 3, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    51 => (sector => 3, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    52 => (sector => 3, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    53 => (sector => 3, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    54 => (sector => 3, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    55 => (sector => 3, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    56 => (sector => 3, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    57 => (sector => 3, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    58 => (sector => 3, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    59 => (sector => 3, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    60 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    61 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    62 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    63 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    64 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    65 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    66 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    67 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    68 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    69 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    70 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    71 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    72 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    73 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    74 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    75 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    76 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    77 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    78 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    79 => (sector => 4, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    80 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    81 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    82 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    83 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    84 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    85 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    86 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    87 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    88 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    89 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    90 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    91 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    92 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    93 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    94 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    95 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    96 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    97 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    98 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    99 => (sector => 5, linkBufKindRx => buf_72b, linkBufKindTx => buf_72b, RxChanTMInterval => 18, RxChanClkRatio => 9, RxChanFrameLength => 162, RxChanThrottleVector => "0", TxChanTMInterval => 18, TxChanClkRatio => 9, TxChanFrameLength => 162, TxChanThrottleVector => "0"),
    others => ApxL1TCfgOff_C
  
    );




end package PrjSpecPkg;
