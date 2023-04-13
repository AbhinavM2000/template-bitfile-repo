library IEEE;
use IEEE.STD_LOGIC_1164.all;

library surf;
use surf.StdRtlPkg.all;

library apx_fs;
use apx_fs.MgtPkg.all;
use apx_fs.ApxChPkg.all;

use apx_fs.apd1ChassisPkg.all;

package PrjSpecPkg is

  constant PRJ_SPEC_PKG_FORMAT_VER_C : integer := 1;

  -- chassis type
  constant CHASSIS_TYPE_C : string := "APd1";

 constant FABRIC_ID_BOARD_C : string := "APd1";
 constant FABRIC_ID_NUMBER_C : integer := 1;

  --clk 40 source
  constant CLK_40_SOURCE_LOCAL_C   : integer := 1;
  constant CLK_40_SOURCE_TCDS_C    : integer := 2;
  constant CLK_40_SOURCE_DYNAMIC_C : integer := 3;


  -- user constants
  -- Must begin with "USER_" and must be parsable as a string or number.
  constant USER_STRING_C : string           := "Project description. abcdef 123 !!@#$";  -- up to 64 character long, parser will throw an error if longer
  constant USER_NUM1_C   : slv(31 downto 0) := x"00000000";
  constant USER_NUM2_C   : slv(31 downto 0) := x"11111111";
  constant USER_NUM3_C   : slv(31 downto 0) := x"ABCD1234";
  constant USER_NUM4_C   : slv(31 downto 0) := x"87654321";

  constant PRJ_VER_MAJOR_C    : integer := 0;
  constant PRJ_VER_MINOR_C    : integer := 1;
  constant PRJ_VER_REVISION_C : integer := 0;

  -- firmware shell algo clock to LHC BC clock multiplier
  constant FS_TO_LHC_CLK_FACTOR_C : natural range 1 to 12 := 9;
  constant SHELL_ALGO_FREQ_MHZ_C : natural 1 to 1000000:= 360720;

  constant SECTOR_ENABLED_C : BooleanArray(0 to SECTOR_CNT_C-1) := (
    0 => true,
    1 => true,
    2 => true,
    3 => true,
    4 => true,
    5 => true  
    );


  -- tRefClkCfgArr declaration in apx-fs/mgt/rtl/MgtPkg.vhd
  constant REFCLK_CFG_C : tRefClkCfgArr(0 to REFCLK_CNT_C-1) := (
    0  => (enabled => "11", sector => 0, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    1  => (enabled => "11", sector => 0, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    2  => (enabled => "11", sector => 1, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    3  => (enabled => "00", sector => 1, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    4  => (enabled => "11", sector => 1, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    5  => (enabled => "11", sector => 2, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    6  => (enabled => "11", sector => 2, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    7  => (enabled => "11", sector => 2, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    8  => (enabled => "11", sector => 3, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    9  => (enabled => "11", sector => 3, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    10 => (enabled => "11", sector => 4, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    11 => (enabled => "11", sector => 4, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    12 => (enabled => "11", sector => 4, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    13 => (enabled => "11", sector => 5, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    14 => (enabled => "11", sector => 5, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz"),
    15 => (enabled => "11", sector => 5, refclk0_freq => "515.625MHz", refclk1_freq => "515.625MHz")

    );

  -- tQpllCfgArr declaration in apx-fs/mgt/rtl/MgtPkg.vhd
  constant QPLL_CFG_C : tQpllCfgArr(0 to QPLL_CNT_C-1) := (
    0  => (enabled => "1", sector => 0, qpllCore => gty_qpll_25g, refclk0 => 0, refclk1 => 0),
    1  => (enabled => "1", sector => 0, qpllCore => gty_qpll_25g, refclk0 => 0, refclk1 => 0),
    2  => (enabled => "1", sector => 0, qpllCore => gty_qpll_25g, refclk0 => 1, refclk1 => 1),
    3  => (enabled => "1", sector => 1, qpllCore => gty_qpll_25g, refclk0 => 2, refclk1 => 2),
    4  => (enabled => "1", sector => 1, qpllCore => gty_qpll_25g, refclk0 => 2, refclk1 => 2),
    5  => (enabled => "1", sector => 1, qpllCore => gty_qpll_25g, refclk0 => 4, refclk1 => 4),
    6  => (enabled => "1", sector => 1, qpllCore => gty_qpll_25g, refclk0 => 4, refclk1 => 4),
    7  => (enabled => "1", sector => 2, qpllCore => gty_qpll_25g, refclk0 => 5, refclk1 => 5),
    8  => (enabled => "1", sector => 2, qpllCore => gty_qpll_25g, refclk0 => 5, refclk1 => 5),
    9  => (enabled => "1", sector => 2, qpllCore => gty_qpll_25g, refclk0 => 6, refclk1 => 6),
    10 => (enabled => "1", sector => 2, qpllCore => gty_qpll_25g, refclk0 => 7, refclk1 => 7),
    11 => (enabled => "1", sector => 2, qpllCore => gty_qpll_25g, refclk0 => 7, refclk1 => 7),
    12 => (enabled => "1", sector => 3, qpllCore => gty_qpll_25g, refclk0 => 8, refclk1 => 8),
    13 => (enabled => "1", sector => 3, qpllCore => gty_qpll_25g, refclk0 => 8, refclk1 => 8),
    14 => (enabled => "1", sector => 3, qpllCore => gty_qpll_25g, refclk0 => 9, refclk1 => 9),
    15 => (enabled => "1", sector => 4, qpllCore => gty_qpll_25g, refclk0 => 10, refclk1 => 10),
    16 => (enabled => "1", sector => 4, qpllCore => gty_qpll_25g, refclk0 => 10, refclk1 => 10),
    17 => (enabled => "1", sector => 4, qpllCore => gty_qpll_25g, refclk0 => 11, refclk1 => 11),
    18 => (enabled => "1", sector => 4, qpllCore => gty_qpll_25g, refclk0 => 12, refclk1 => 12),
    19 => (enabled => "1", sector => 4, qpllCore => gty_qpll_25g, refclk0 => 12, refclk1 => 12),
    20 => (enabled => "1", sector => 5, qpllCore => gty_qpll_25g, refclk0 => 13, refclk1 => 13),
    21 => (enabled => "1", sector => 5, qpllCore => gty_qpll_25g, refclk0 => 13, refclk1 => 13),
    22 => (enabled => "1", sector => 5, qpllCore => gty_qpll_25g, refclk0 => 14, refclk1 => 14),
    23 => (enabled => "1", sector => 5, qpllCore => gty_qpll_25g, refclk0 => 15, refclk1 => 15),
    24 => (enabled => "1", sector => 5, qpllCore => gty_qpll_25g, refclk0 => 15, refclk1 => 15)

    );

  constant MGT_SYM_25G_6467 : tMgtCfg := (mgtCore => gty4_25g_sym, mgtCoreType => "gty4", rxLineRate => "25.78125Gbps", rxEncoding => "64b67b", txLineRate => "25.78125Gbps", txEncoding => "64b67b");

  --constant PROTO_CSP_TM_18_CR_9_FL_162_TV_0 : tCSPProtoCfg := (ProtocolType  => CSP, CSPTMInterval => 18, CSPClkRatio => 9, CSPFrameLength => 162, CSPThrottleVector => "000000000", lpGBTParam1 => 0, lpGBTParam2 => '0', lpGBTParam3 => "0000");


  --TM18, 360 AXI Clock, 162-word packets, no throttle
  constant CSP_TM18_PL162 : tCSPProtoCfg := (ProtocolType => CSP, CSPFrameInterval => 164, CSPFrameLength => 162, CSPThrottleVector => "000000000", lpGBTParam1 => 0, lpGBTParam2 => '0', lpGBTParam3 => "0000");

  --TM18, 360 AXI Clock, 150-word packets, no throttle
  constant CSP_TM18_PL150 : tCSPProtoCfg := (ProtocolType => CSP, CSPFrameInterval => 164, CSPFrameLength => 150, CSPThrottleVector => "000000000", lpGBTParam1 => 0, lpGBTParam2 => '0', lpGBTParam3 => "0000");

  --TM6, 360 AXI Clock, 54-word packets, no throttle
  constant CSP_TM6_PL54 : tCSPProtoCfg := (ProtocolType => CSP, CSPFrameInterval => 54, CSPFrameLength => 54, CSPThrottleVector => "000000000", lpGBTParam1 => 0, lpGBTParam2 => '0', lpGBTParam3 => "0000");

  --TM6, 360 AXI Clock, 47-word packets, no throttle
  constant CSP_TM6_PL47 : tCSPProtoCfg := (ProtocolType => CSP, CSPFrameInterval => 54, CSPFrameLength => 47, CSPThrottleVector => "000000000", lpGBTParam1 => 0, lpGBTParam2 => '0', lpGBTParam3 => "0000");

  --TM2, 360 AXI Clock, 18-word packets, no throttle (meant for full-length TM1 packets, CRC every other Bx)
  constant CSP_TM2_PL18 : tCSPProtoCfg := (ProtocolType => CSP, CSPFrameInterval => 18, CSPFrameLength => 18, CSPThrottleVector => "000000000", lpGBTParam1 => 0, lpGBTParam2 => '0', lpGBTParam3 => "0000");

  --TM1, 360 AXI Clock, 8-word packets, 5th of 9 clocks throttled (no FIFO operation)
  constant CSP_TM1_PL8_TV4 : tCSPProtoCfg := (ProtocolType => CSP, CSPFrameInterval => 9, CSPFrameLength => 8, CSPThrottleVector => "000010000", lpGBTParam1 => 0, lpGBTParam2 => '0', lpGBTParam3 => "0000");

  --TM1, 360 AXI Clock, 8-word packets, 9th of 9 clocks throttled (no FIFO operation)
  constant CSP_TM1_PL8_TV8 : tCSPProtoCfg := (ProtocolType => CSP, CSPFrameInterval => 9, CSPFrameLength => 8, CSPThrottleVector => "000000001", lpGBTParam1 => 0, lpGBTParam2 => '0', lpGBTParam3 => "0000");

  -- tApxChCfgArr declaration in apx-fs/apxSector/rtl/apxChPkg.vhd
  -- channel configurations for APx Validation Tests
  -- NOTE:  enable order, L->R, is  "TxBuf TxProt MGT RxProt RxBuf"   1=enabled, 0=disabled
  constant APX_CH_CFG_C : tApxChCfgArr(0 to MGT_CNT_C-1) := (
    0 => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    1 => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    2 => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    3 => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    4 => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    5 => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    6 => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    7 => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    8  => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    9  => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    10 => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    11 => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    12 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    13 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    14 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    15 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    16 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    17 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    18 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    19 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    20 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    21 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    22 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    23 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    24 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    25 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    26 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    27 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    28 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    29 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    30 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    31 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    32 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    33 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    34 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    35 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    36 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    37 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    38 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    39 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    40 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    41 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    42 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    43 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    --no links below this line have any enables
    44 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    45 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    46 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    47 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    48 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    49 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    50 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    51 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    52 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    53 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    54 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    55 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    56 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    57 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    58 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    59 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    60 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    61 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    62 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    63 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    64 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    65 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    66 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    67 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    68 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    69 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    70 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    71 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    72 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    73 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    74 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    75 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    76 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    77 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    78 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    79 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),

    80 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    81 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    82 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    83 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    84 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    85 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    86 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    87 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    88 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    89 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    90 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    91 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    92 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    93 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    94 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    95 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    96 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    97 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    98 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162),
    99 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => CSP_TM18_PL162, RxProtocolCfg => CSP_TM18_PL162)

    );

end package PrjSpecPkg;

