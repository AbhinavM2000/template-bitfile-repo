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

  -- user constants
  constant USER_STRING_C : string           := "Project description. abcdef 123 !!@#$";  -- up to 64 character long, parser will throw an error if longer
  constant USER_NUM1_C   : slv(31 downto 0) := x"00000000";
  constant USER_NUM2_C   : slv(31 downto 0) := x"11111111";
  constant USER_NUM3_C   : slv(31 downto 0) := x"ABCD1234";
  constant USER_NUM4_C   : slv(31 downto 0) := x"87654321";
  
  constant PRJ_VER_MAJOR_C   : std_logic_vector(7 downto 0) := x"00";
  constant PRJ_VER_MINOR_C   : std_logic_vector(7 downto 0) := x"01";
  constant PRJ_VER_REVISON_C : std_logic_vector(7 downto 0) := x"00";  

  -- firmware shell algo clock to LHC BC clock multiplier
  constant FS_TO_LHC_CLK_FACTOR_C : natural range 1 to 12 := 9; 

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

  constant MGT_SYM_25G_6467           : tMgtCfg     := (mgtCore   => gty4_25g_sym,  mgtCoreType => "gty4", rxLineRate => "25.78125Gbps", rxEncoding => "64b67b", txLineRate => "25.78125Gbps", txEncoding => "64b67b");

  constant PROTO_CSP_TM_18_CR_9_FL_162_TV_0 : tCSPProtoCfg := (ProtocolType  => CSP, CSPTMInterval => 18, CSPClkRatio => 9, CSPFrameLength => 162, CSPThrottleVector => "000000000", lpGBTParam1 => 0, lpGBTParam2 => '0', lpGBTParam3 => "0000");

  -- tApxChCfgArr declaration in apx-fs/apxSector/rtl/apxChPkg.vhd
  constant APX_CH_CFG_C : tApxChCfgArr(0 to MGT_CNT_C-1) := (
    0  => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    1  => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    2  => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    3  => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    4  => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    5  => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    6  => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    7  => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    8  => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    9  => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    10 => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    11 => (enabled => "11111", sector => 0, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),

    12 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    13 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    14 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    15 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    16 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    17 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    18 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    19 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    20 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    21 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    22 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    23 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    24 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    25 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    26 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    27 => (enabled => "11111", sector => 1, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),

    28 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    29 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    30 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    31 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    32 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    33 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    34 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    35 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    36 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    37 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    38 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    39 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    40 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    41 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    42 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    43 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    44 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    45 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    46 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    47 => (enabled => "11111", sector => 2, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),

    48 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    49 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    50 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    51 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    52 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    53 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    54 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    55 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    56 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    57 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    58 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    59 => (enabled => "11111", sector => 3, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),

    60 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    61 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    62 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    63 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    64 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    65 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    66 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    67 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    68 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    69 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    70 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    71 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    72 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    73 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    74 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    75 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    76 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    77 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    78 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    79 => (enabled => "11111", sector => 4, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),

    80 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    81 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    82 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    83 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    84 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    85 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    86 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    87 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    88 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    89 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    90 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    91 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    92 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    93 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    94 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    95 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    96 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    97 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    98 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0),
    99 => (enabled => "11111", sector => 5, MgtCfg => MGT_SYM_25G_6467, TxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0, RxProtocolCfg => PROTO_CSP_TM_18_CR_9_FL_162_TV_0)
    );

end package PrjSpecPkg;
