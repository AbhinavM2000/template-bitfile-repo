library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;

library apx_fs;
use apx_fs.ApxChPkg.all;

entity algoTopWrapper is
  generic (
    APX_CH_CFG_G     : tApxChCfgArr;
    N_INPUT_STREAMS  : integer := 124;
    N_OUTPUT_STREAMS : integer := 124
    );
  port (
    -- Algo Control/Status Signals
    algoClk   : in  sl;
    algoRst   : in  sl;
    algoStart : in  sl;
    algoDone  : out sl := '0';
    algoIdle  : out sl := '0';
    algoReady : out sl := '0';

    --LHC clock domain
    clkLHC     : in sl;
    bc0_clkLHC : in sl;

    -- AXI-Stream In/Out Ports
    axiStreamIn  : in  AxiStreamMasterArray(0 to N_INPUT_STREAMS-1);
    axiStreamOut : out AxiStreamMasterArray(0 to N_OUTPUT_STREAMS-1) := (others => AXI_STREAM_MASTER_INIT_C)
    );
end algoTopWrapper;

architecture rtl of algoTopWrapper is

CONSTANT N_INPUT_STREAMS_IP1_5x6  : NATURAL := 30;
CONSTANT N_INPUT_STREAMS_IP1_2x6  : NATURAL := 12;
CONSTANT N_OUTPUT_STREAMS_IP1     : NATURAL := 2;

CONSTANT N_INPUT_STREAMS_IP2  : NATURAL := 8;
CONSTANT N_OUTPUT_STREAMS_IP2 : NATURAL := 5;

CONSTANT N_INPUT_STREAMS_IP3  : NATURAL := 9;
CONSTANT N_IP3_OUTPUTS : NATURAL := 4; -- Number of original IP3 outputs
CONSTANT N_OUTPUTS_IP3_PLUS_DUP : NATURAL := 8; -- Total number of outputs after duplication

CONSTANT N_INPUT_STREAMS_HCAL : NATURAL := 4;

CONSTANT HCAL_LINK_INIT : NATURAL := 68;

SIGNAL algoRstD_SLR0    : std_logic := '1';
SIGNAL algoRstD1_SLR0   : std_logic := '1';
SIGNAL algoRstD2_SLR0   : std_logic := '1';
SIGNAL algoRstD3_SLR0   : std_logic := '1';
SIGNAL algoRstD4_SLR0   : std_logic := '1';
SIGNAL algoRstD5_SLR0   : std_logic := '1';

SIGNAL algoStartD_SLR0  : std_logic := '0';
SIGNAL algoStartD1_SLR0 : std_logic := '0';
SIGNAL algoStartD2_SLR0 : std_logic := '0';
SIGNAL algoStartD3_SLR0 : std_logic := '0';
SIGNAL algoStartD4_SLR0 : std_logic := '0';
SIGNAL algoStartD5_SLR0 : std_logic := '0';

SIGNAL algoRstD_SLR1    : std_logic := '1';
SIGNAL algoRstD1_SLR1   : std_logic := '1';
SIGNAL algoRstD2_SLR1   : std_logic := '1';
SIGNAL algoRstD3_SLR1   : std_logic := '1';
SIGNAL algoRstD4_SLR1   : std_logic := '1';
SIGNAL algoRstD5_SLR1   : std_logic := '1';

SIGNAL algoStartD_SLR1  : std_logic := '0';
SIGNAL algoStartD1_SLR1 : std_logic := '0';
SIGNAL algoStartD2_SLR1 : std_logic := '0';
SIGNAL algoStartD3_SLR1 : std_logic := '0';
SIGNAL algoStartD4_SLR1 : std_logic := '0';
SIGNAL algoStartD5_SLR1 : std_logic := '0';

SIGNAL algoRstD_SLR2   : std_logic := '1';
SIGNAL algoRstD1_SLR2  : std_logic := '1';
SIGNAL algoRstD2_SLR2  : std_logic := '1';
SIGNAL algoRstD3_SLR2  : std_logic := '1';
SIGNAL algoRstD4_SLR2  : std_logic := '1';
SIGNAL algoRstD5_SLR2  : std_logic := '1';

SIGNAL algoStartD_SLR2  : std_logic := '0';
SIGNAL algoStartD1_SLR2 : std_logic := '0';
SIGNAL algoStartD2_SLR2 : std_logic := '0';
SIGNAL algoStartD3_SLR2 : std_logic := '0';
SIGNAL algoStartD4_SLR2 : std_logic := '0';
SIGNAL algoStartD5_SLR2 : std_logic := '0';

SIGNAL algoRstD_SLR3    : std_logic := '1';
SIGNAL algoRstD1_SLR3   : std_logic := '1';
SIGNAL algoRstD2_SLR3   : std_logic := '1';
SIGNAL algoRstD3_SLR3   : std_logic := '1';
SIGNAL algoRstD4_SLR3   : std_logic := '1';
SIGNAL algoRstD5_SLR3   : std_logic := '1';

SIGNAL algoStartD_SLR3  : std_logic := '0';
SIGNAL algoStartD1_SLR3 : std_logic := '0';
SIGNAL algoStartD2_SLR3 : std_logic := '0';
SIGNAL algoStartD3_SLR3 : std_logic := '0';
SIGNAL algoStartD4_SLR3 : std_logic := '0';
SIGNAL algoStartD5_SLR3 : std_logic := '0';

SIGNAL algoStartIP2D0 : std_logic := '0';
SIGNAL algoStartIP2D1 : std_logic := '0';
SIGNAL algoStartIP2D2 : std_logic := '0';
SIGNAL algoStartIP2D3 : std_logic := '0';
SIGNAL algoStartIP2D4 : std_logic := '0';
SIGNAL algoStartIP2D5 : std_logic := '0';
SIGNAL algoStartIP2D6 : std_logic := '0';
SIGNAL algoStartIP2D7 : std_logic := '0';

SIGNAL algoStartIP3D0 : std_logic := '0';
SIGNAL algoStartIP3D1 : std_logic := '0';
SIGNAL algoStartIP3D2 : std_logic := '0';
SIGNAL algoStartIP3D3 : std_logic := '0';
SIGNAL algoStartIP3D4 : std_logic := '0';
SIGNAL algoStartIP3D5 : std_logic := '0';
SIGNAL algoStartIP3D6 : std_logic := '0';
SIGNAL algoStartIP3D7 : std_logic := '0';

attribute dont_touch : string;
attribute dont_touch of algoRstD_SLR0, algoRstD1_SLR0, algoRstD2_SLR0, algoRstD3_SLR0, algoRstD4_SLR0, algoRstD5_SLR0: signal is "yes";
attribute dont_touch of algoStartD_SLR0, algoStartD1_SLR0, algoStartD2_SLR0, algoStartD3_SLR0, algoStartD4_SLR0, algoStartD5_SLR0: signal is "yes";

attribute dont_touch of algoRstD_SLR1, algoRstD1_SLR1, algoRstD2_SLR1, algoRstD3_SLR1, algoRstD4_SLR1, algoRstD5_SLR1: signal is "yes";
attribute dont_touch of algoStartD_SLR1, algoStartD1_SLR1, algoStartD2_SLR1, algoStartD3_SLR1, algoStartD4_SLR1, algoStartD5_SLR1: signal is "yes";

attribute dont_touch of algoRstD_SLR2, algoRstD1_SLR2, algoRstD2_SLR2, algoRstD3_SLR2, algoRstD4_SLR2, algoRstD5_SLR2: signal is "yes";
attribute dont_touch of algoStartD_SLR2, algoStartD1_SLR2, algoStartD2_SLR2, algoStartD3_SLR2, algoStartD4_SLR2, algoStartD5_SLR2: signal is "yes";

attribute dont_touch of algoRstD_SLR3, algoRstD1_SLR3, algoRstD2_SLR3, algoRstD3_SLR3, algoRstD4_SLR3, algoRstD5_SLR3: signal is "yes";
attribute dont_touch of algoStartD_SLR3, algoStartD1_SLR3, algoStartD2_SLR3, algoStartD3_SLR3, algoStartD4_SLR3, algoStartD5_SLR3: signal is "yes";

attribute shreg_extract : string;
attribute shreg_extract of algoRstD_SLR0, algoRstD1_SLR0, algoRstD2_SLR0, algoRstD3_SLR0, algoRstD4_SLR0, algoRstD5_SLR0: signal is "no";
attribute shreg_extract of algoStartD_SLR0, algoStartD1_SLR0, algoStartD2_SLR0, algoStartD3_SLR0, algoStartD4_SLR0, algoStartD5_SLR0: signal is "no";

attribute shreg_extract of algoRstD_SLR1, algoRstD1_SLR1, algoRstD2_SLR1, algoRstD3_SLR1, algoRstD4_SLR1, algoRstD5_SLR1: signal is "no";
attribute shreg_extract of algoStartD_SLR1, algoStartD1_SLR1, algoStartD2_SLR1, algoStartD3_SLR1, algoStartD4_SLR1, algoStartD5_SLR1: signal is "no";

attribute shreg_extract of algoRstD_SLR2, algoRstD1_SLR2, algoRstD2_SLR2, algoRstD3_SLR2, algoRstD4_SLR2, algoRstD5_SLR2: signal is "no";
attribute shreg_extract of algoStartD_SLR2, algoStartD1_SLR2, algoStartD2_SLR2, algoStartD3_SLR2, algoStartD4_SLR2, algoStartD5_SLR2: signal is "no";

attribute shreg_extract of algoRstD_SLR3, algoRstD1_SLR3, algoRstD2_SLR3, algoRstD3_SLR3, algoRstD4_SLR3, algoRstD5_SLR3: signal is "no";
attribute shreg_extract of algoStartD_SLR3, algoStartD1_SLR3, algoStartD2_SLR3, algoStartD3_SLR3, algoStartD4_SLR3, algoStartD5_SLR3: signal is "no";

signal axiStreamInHCAL   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_HCAL-1);
signal axiStreamInHCALD0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_HCAL-1);

signal axiStreamInSLR3   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP1_5x6-1);
signal axiStreamInSLR3D0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP1_5x6-1);
signal axiStreamInSLR3D1 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP1_5x6-1);

signal axiStreamInSLR2   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP1_5x6-1);
signal axiStreamInSLR2D0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP1_5x6-1);
signal axiStreamInSLR2D1 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP1_5x6-1);

signal axiStreamInSLR1   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP1_5x6-1);
signal axiStreamInSLR1D0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP1_5x6-1);
signal axiStreamInSLR1D1 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP1_5x6-1);

signal axiStreamInSLR0   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP1_2x6-1);
signal axiStreamInSLR0D0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP1_2x6-1);
signal axiStreamInSLR0D1 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP1_2x6-1);

signal axiStreamOutSLR0D0   : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR0BUFF : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);

signal axiStreamOutSLR1D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR1D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR1D2 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR1D3 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR1D4 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR1D5 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR1D6 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR1D7 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR1D8 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR1D9 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);

signal axiStreamOutSLR2D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR2D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR2D2 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR2D3 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR2D4 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR2D5 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR2D6 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR2D7 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR2D8 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR2D9 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);

signal axiStreamOutSLR3D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR3D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR3D2 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR3D3 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR3D4 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR3D5 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR3D6 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR3D7 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR3D8 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);
signal axiStreamOutSLR3D9 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP1-1);

signal axiStreamInIP2 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP2-1);

signal axiStreamOutIP2   : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP2-1);
signal axiStreamOutIP2D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP2-1);
signal axiStreamOutIP2D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP2-1);

signal axiStreamInIP3    : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP3-1);
signal axiStreamOutIP3   : AxiStreamMasterArray(0 to N_IP3_OUTPUTS-1);
signal axiStreamOutIP3D0 : AxiStreamMasterArray(0 to N_IP3_OUTPUTS-1);
signal axiStreamOutIP3D1 : AxiStreamMasterArray(0 to N_IP3_OUTPUTS-1);

signal axiStreamOutD1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS-1);
signal axiStreamOutD0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS-1);


signal axiStreamOut_internal : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS-1);

attribute shreg_extract of axiStreamOutSLR1D0, axiStreamOutSLR1D1, axiStreamOutSLR1D2, axiStreamOutSLR1D3, axiStreamOutSLR1D4, axiStreamOutSLR1D5, axiStreamOutSLR1D6, axiStreamOutSLR1D7, axiStreamOutSLR1D8, axiStreamOutSLR1D9: signal is "no";
attribute shreg_extract of axiStreamOutSLR2D0, axiStreamOutSLR2D1, axiStreamOutSLR2D2, axiStreamOutSLR2D3, axiStreamOutSLR2D4, axiStreamOutSLR2D5, axiStreamOutSLR2D6, axiStreamOutSLR2D7, axiStreamOutSLR2D8, axiStreamOutSLR2D9: signal is "no";
attribute shreg_extract of axiStreamOutSLR3D0, axiStreamOutSLR3D1, axiStreamOutSLR3D2, axiStreamOutSLR3D3, axiStreamOutSLR3D4, axiStreamOutSLR3D5, axiStreamOutSLR3D6, axiStreamOutSLR3D7, axiStreamOutSLR3D8, axiStreamOutSLR3D9: signal is "no";

constant XLA_INPUT_MAP_C_SLR3 : IntegerArray(0 to N_INPUT_STREAMS_IP1_5x6-1) := (
  --sector 3
  0  => 45,
  1  => 46,
  2  => 47,
  3  => 48,
  4  => 49,
  5  => 50,
  6  => 51,
  7  => 52,
  8  => 53,
  9  => 54,
  10 => 55,
  11 => 56,
  12 => 57,
  13 => 58,
  14 => 59,

  --sector 7
  15 => 123,
  16 => 122,
  17 => 121,
  18 => 120,
  19 => 119,
  20 => 118,
  21 => 117,
  22 => 116,
  23 => 115,
  24 => 114,
  25 => 113,
  26 => 112,
  27 => 111,
  28 => 110,
  29 => 109
);

constant XLA_INPUT_MAP_C_SLR2 : IntegerArray(0 to N_INPUT_STREAMS_IP1_5x6-1) := (
  --sector 2
  0  => 29,
  1  => 30,
  2  => 31,
  3  => 32,
  4  => 33,
  5  => 34,
  6  => 35,
  7  => 36,
  8  => 37,
  9  => 38,
  10 => 39,
  11 => 40,
  12 => 41,
  13 => 42,
  14 => 43,

  --sector 6
  15 => 107,
  16 => 106,
  17 => 105,
  18 => 104,
  19 => 103,
  20 => 102,
  21 => 101,
  22 => 100,
  23 => 99,
  24 => 98,
  25 => 97,
  26 => 96,
  27 => 95,
  28 => 94,
  29 => 93
);

constant XLA_INPUT_MAP_C_SLR1 : IntegerArray(0 to N_INPUT_STREAMS_IP1_5x6-1) := (
  --sector 1
  0  => 13,
  1  => 14,
  2  => 15,
  3  => 16,
  4  => 17,
  5  => 18,
  6  => 19,
  7  => 20,
  8  => 21,
  9  => 22,
  10 => 23,
  11 => 24,
  12 => 25,
  13 => 26,
  14 => 27,
    
  --sector 5
  15 => 91,
  16 => 90,
  17 => 89,
  18 => 88,
  19 => 87,
  20 => 86,
  21 => 85,
  22 => 84,
  23 => 83,
  24 => 82,
  25 => 81,
  26 => 80,
  27 => 79,
  28 => 78,
  29 => 77
);

constant XLA_INPUT_MAP_C_SLR0 : IntegerArray(0 to N_INPUT_STREAMS_IP1_2x6-1) := (
  --sector 0
  0  => 0,
  1  => 1,
  2  => 2,
  3  => 3,
  4  => 4,
  5  => 5,
  6  => 6,
  7  => 7,
  8  => 8,
  9  => 9,
  10 => 10,
  11 => 11
);

constant XLA_OUTPUT_MAP_C_SLR0 : IntegerArray(0 to N_OUTPUTS_IP3_PLUS_DUP-1) := (
  --sector 4 org + dup
  0  => 64,
  1  => 65,
  2  => 66,
  3  => 67,
  4  => 68,
  5  => 69,
  6  => 70,
  7  => 71
);

--- calibration for IP2 ----

  signal axiAlgoRstOut : slv(24 downto 0);
  signal mAlgoAxiWriteMasters : AxiLiteWriteMasterArray(24 downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
  signal mAlgoAxiWriteSlaves  : AxiLiteWriteSlaveArray(24 downto 0)  := (others => AXI_LITE_WRITE_SLAVE_EMPTY_DECERR_C);
  signal mAlgoAxiReadMasters  : AxiLiteReadMasterArray(24 downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
  signal mAlgoAxiReadSlaves   : AxiLiteReadSlaveArray(24 downto 0)   := (others => AXI_LITE_READ_SLAVE_EMPTY_DECERR_C);

signal regsSLR0_0  : Slv32Array;
signal regsSLR0_1  : Slv32Array;
signal regsSLR0_2  : Slv32Array;
signal regsSLR0_3  : Slv32Array;
signal regsSLR0_4  : Slv32Array;
signal regsSLR0_5  : Slv32Array;
signal regsSLR0_6  : Slv32Array;
signal regsSLR0_7  : Slv32Array;
signal regsSLR0_8  : Slv32Array;
signal regsSLR0_9  : Slv32Array;
signal regsSLR0_10 : Slv32Array;
signal regsSLR0_11 : Slv32Array;
signal regsSLR0_12 : Slv32Array;
signal regsSLR0_13 : Slv32Array;
signal regsSLR0_14 : Slv32Array;
signal regsSLR0_15 : Slv32Array;
signal regsSLR0_16 : Slv32Array;
signal regsSLR0_17 : Slv32Array;
signal regsSLR0_18 : Slv32Array;
signal regsSLR0_19 : Slv32Array;
signal regsSLR0_20 : Slv32Array;
signal regsSLR0_21 : Slv32Array;
signal regsSLR0_22 : Slv32Array;
signal regsSLR0_23 : Slv32Array;
signal regsSLR0_24 : Slv32Array;

---------------------------------

begin

----------------------------------------------------------------------------
---------------------INPUT MAPPING
----------------------------------------------------------------------------

GEN_IN_LINKS_SLR3: for i in 0 to N_INPUT_STREAMS_IP1_5x6-1 generate
    axiStreamInSLR3(i) <= axiStreamIn(XLA_INPUT_MAP_C_SLR3(i));
end generate;

GEN_IN_LINKS_SLR2: for i in 0 to N_INPUT_STREAMS_IP1_5x6-1 generate
    axiStreamInSLR2(i) <= axiStreamIn(XLA_INPUT_MAP_C_SLR2(i));
end generate;

GEN_IN_LINKS_SLR1: for i in 0 to N_INPUT_STREAMS_IP1_5x6-1 generate
    axiStreamInSLR1(i) <= axiStreamIn(XLA_INPUT_MAP_C_SLR1(i));
end generate;

GEN_IN_LINKS_SLR0: for i in 0 to N_INPUT_STREAMS_IP1_2x6-1 generate
    axiStreamInSLR0(i) <= axiStreamIn(XLA_INPUT_MAP_C_SLR0(i));
end generate;

----------------------------------------------------------------------------
---------------------INPUT BUFFERING
----------------------------------------------------------------------------

axiStreamInSLR3D0 <= axiStreamInSLR3   when rising_edge(algoClk);
axiStreamInSLR3D1 <= axiStreamInSLR3D0 when rising_edge(algoClk);

axiStreamInSLR2D0 <= axiStreamInSLR2   when rising_edge(algoClk);
axiStreamInSLR2D1 <= axiStreamInSLR2D0 when rising_edge(algoClk);

axiStreamInSLR1D0 <= axiStreamInSLR1   when rising_edge(algoClk);
axiStreamInSLR1D1 <= axiStreamInSLR1D0 when rising_edge(algoClk);

axiStreamInSLR0D0 <= axiStreamInSLR0   when rising_edge(algoClk);
axiStreamInSLR0D1 <= axiStreamInSLR0D0 when rising_edge(algoClk);

----------------------------------------------------------------------------
---------------------START and RESET GENERATION
----------------------------------------------------------------------------

----------------------------------------------------------------------------
---------------------FOR SLR3
----------------------------------------------------------------------------

algoRstD_SLR3   <= algoRst         when rising_edge(algoClk);
algoRstD1_SLR3  <= algoRstD_SLR3   when rising_edge(algoClk);
algoRstD2_SLR3  <= algoRstD1_SLR3  when rising_edge(algoClk);
algoRstD3_SLR3  <= algoRstD2_SLR3  when rising_edge(algoClk);
algoRstD4_SLR3  <= algoRstD3_SLR3  when rising_edge(algoClk);
algoRstD5_SLR3  <= algoRstD4_SLR3  when rising_edge(algoClk);

algoStartD_SLR3  <= algoStart         when rising_edge(algoClk);
algoStartD1_SLR3 <= algoStartD_SLR3   when rising_edge(algoClk);
algoStartD2_SLR3 <= algoStartD1_SLR3  when rising_edge(algoClk);
algoStartD3_SLR3 <= algoStartD2_SLR3  when rising_edge(algoClk);
algoStartD4_SLR3 <= algoStartD3_SLR3  when rising_edge(algoClk);
algoStartD5_SLR3 <= algoStartD4_SLR3  when rising_edge(algoClk);

----------------------------------------------------------------------------
---------------------FOR SLR2
----------------------------------------------------------------------------

algoRstD_SLR2   <= algoRst         when rising_edge(algoClk);
algoRstD1_SLR2  <= algoRstD_SLR2   when rising_edge(algoClk);
algoRstD2_SLR2  <= algoRstD1_SLR2  when rising_edge(algoClk);
algoRstD3_SLR2  <= algoRstD2_SLR2  when rising_edge(algoClk);
algoRstD4_SLR2  <= algoRstD3_SLR2  when rising_edge(algoClk);
algoRstD5_SLR2  <= algoRstD4_SLR2  when rising_edge(algoClk);

algoStartD_SLR2  <= algoStart         when rising_edge(algoClk);
algoStartD1_SLR2 <= algoStartD_SLR2   when rising_edge(algoClk);
algoStartD2_SLR2 <= algoStartD1_SLR2  when rising_edge(algoClk);
algoStartD3_SLR2 <= algoStartD2_SLR2  when rising_edge(algoClk);
algoStartD4_SLR2 <= algoStartD3_SLR2  when rising_edge(algoClk);
algoStartD5_SLR2 <= algoStartD4_SLR2  when rising_edge(algoClk);

----------------------------------------------------------------------------
---------------------FOR SLR1
----------------------------------------------------------------------------

algoRstD_SLR1   <= algoRst         when rising_edge(algoClk);
algoRstD1_SLR1  <= algoRstD_SLR1   when rising_edge(algoClk);
algoRstD2_SLR1  <= algoRstD1_SLR1  when rising_edge(algoClk);
algoRstD3_SLR1  <= algoRstD2_SLR1  when rising_edge(algoClk);
algoRstD4_SLR1  <= algoRstD3_SLR1  when rising_edge(algoClk);
algoRstD5_SLR1  <= algoRstD4_SLR1  when rising_edge(algoClk);

algoStartD_SLR1  <= algoStart         when rising_edge(algoClk);
algoStartD1_SLR1 <= algoStartD_SLR1   when rising_edge(algoClk);
algoStartD2_SLR1 <= algoStartD1_SLR1  when rising_edge(algoClk);
algoStartD3_SLR1 <= algoStartD2_SLR1  when rising_edge(algoClk);
algoStartD4_SLR1 <= algoStartD3_SLR1  when rising_edge(algoClk);
algoStartD5_SLR1 <= algoStartD4_SLR1  when rising_edge(algoClk);

----------------------------------------------------------------------------
---------------------FOR SLR0
----------------------------------------------------------------------------

algoRstD_SLR0   <= algoRst         when rising_edge(algoClk);
algoRstD1_SLR0  <= algoRstD_SLR0   when rising_edge(algoClk);
algoRstD2_SLR0  <= algoRstD1_SLR0  when rising_edge(algoClk);
algoRstD3_SLR0  <= algoRstD2_SLR0  when rising_edge(algoClk);
algoRstD4_SLR0  <= algoRstD3_SLR0  when rising_edge(algoClk);
algoRstD5_SLR0  <= algoRstD4_SLR0  when rising_edge(algoClk);

algoStartD_SLR0  <= algoStart         when rising_edge(algoClk);
algoStartD1_SLR0 <= algoStartD_SLR0   when rising_edge(algoClk);
algoStartD2_SLR0 <= algoStartD1_SLR0  when rising_edge(algoClk);
algoStartD3_SLR0 <= algoStartD2_SLR0  when rising_edge(algoClk);
algoStartD4_SLR0 <= algoStartD3_SLR0  when rising_edge(algoClk);
algoStartD5_SLR0 <= algoStartD4_SLR0  when rising_edge(algoClk);

--------------------------CALIBRATION FOR IP2-------------------------------
U_apxAxiRegsSLR0_0 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(0),
      axiReadSlave   => mAlgoAxiReadSlaves(0),
      axiWriteMaster => mAlgoAxiWriteMasters(0),
      axiWriteSlave  => mAlgoAxiWriteSlaves(0),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(0),
      -- User Read/Write registers
      regs => regsSLR0_0
      );

U_apxAxiRegsSLR0_1 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(1),
      axiReadSlave   => mAlgoAxiReadSlaves(1),
      axiWriteMaster => mAlgoAxiWriteMasters(1),
      axiWriteSlave  => mAlgoAxiWriteSlaves(1),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(1),
      -- User Read/Write registers
      regs => regsSLR0_1
      );

U_apxAxiRegsSLR0_2 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(2),
      axiReadSlave   => mAlgoAxiReadSlaves(2),
      axiWriteMaster => mAlgoAxiWriteMasters(2),
      axiWriteSlave  => mAlgoAxiWriteSlaves(2),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(2),
      -- User Read/Write registers
      regs => regsSLR0_2
      );

U_apxAxiRegsSLR0_3 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(3),
      axiReadSlave   => mAlgoAxiReadSlaves(3),
      axiWriteMaster => mAlgoAxiWriteMasters(3),
      axiWriteSlave  => mAlgoAxiWriteSlaves(3),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(3),
      -- User Read/Write registers
      regs => regsSLR0_3
      );

U_apxAxiRegsSLR0_4 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(4),
      axiReadSlave   => mAlgoAxiReadSlaves(4),
      axiWriteMaster => mAlgoAxiWriteMasters(4),
      axiWriteSlave  => mAlgoAxiWriteSlaves(4),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(4),
      -- User Read/Write registers
      regs => regsSLR0_4
      );

U_apxAxiRegsSLR0_5 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(5),
      axiReadSlave   => mAlgoAxiReadSlaves(5),
      axiWriteMaster => mAlgoAxiWriteMasters(5),
      axiWriteSlave  => mAlgoAxiWriteSlaves(5),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(5),
      -- User Read/Write registers
      regs => regsSLR0_5
      );

U_apxAxiRegsSLR0_6 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(6),
      axiReadSlave   => mAlgoAxiReadSlaves(6),
      axiWriteMaster => mAlgoAxiWriteMasters(6),
      axiWriteSlave  => mAlgoAxiWriteSlaves(6),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(6),
      -- User Read/Write registers
      regs => regsSLR0_6
      );

U_apxAxiRegsSLR0_7 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(7),
      axiReadSlave   => mAlgoAxiReadSlaves(7),
      axiWriteMaster => mAlgoAxiWriteMasters(7),
      axiWriteSlave  => mAlgoAxiWriteSlaves(7),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(7),
      -- User Read/Write registers
      regs => regsSLR0_7
      );

U_apxAxiRegsSLR0_8 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(8),
      axiReadSlave   => mAlgoAxiReadSlaves(8),
      axiWriteMaster => mAlgoAxiWriteMasters(8),
      axiWriteSlave  => mAlgoAxiWriteSlaves(8),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(8),
      -- User Read/Write registers
      regs => regsSLR0_8
      );

U_apxAxiRegsSLR0_9 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(9),
      axiReadSlave   => mAlgoAxiReadSlaves(9),
      axiWriteMaster => mAlgoAxiWriteMasters(9),
      axiWriteSlave  => mAlgoAxiWriteSlaves(9),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(9),
      -- User Read/Write registers
      regs => regsSLR0_9
      );

U_apxAxiRegsSLR0_10 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(10),
      axiReadSlave   => mAlgoAxiReadSlaves(10),
      axiWriteMaster => mAlgoAxiWriteMasters(10),
      axiWriteSlave  => mAlgoAxiWriteSlaves(10),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(10),
      -- User Read/Write registers
      regs => regsSLR0_10
      );

U_apxAxiRegsSLR0_11 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(11),
      axiReadSlave   => mAlgoAxiReadSlaves(11),
      axiWriteMaster => mAlgoAxiWriteMasters(11),
      axiWriteSlave  => mAlgoAxiWriteSlaves(11),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(11),
      -- User Read/Write registers
      regs => regsSLR0_11
      );

U_apxAxiRegsSLR0_12 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(12),
      axiReadSlave   => mAlgoAxiReadSlaves(12),
      axiWriteMaster => mAlgoAxiWriteMasters(12),
      axiWriteSlave  => mAlgoAxiWriteSlaves(12),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(12),
      -- User Read/Write registers
      regs => regsSLR0_12
      );

U_apxAxiRegsSLR0_13 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(13),
      axiReadSlave   => mAlgoAxiReadSlaves(13),
      axiWriteMaster => mAlgoAxiWriteMasters(13),
      axiWriteSlave  => mAlgoAxiWriteSlaves(13),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(13),
      -- User Read/Write registers
      regs => regsSLR0_13
      );

U_apxAxiRegsSLR0_14 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(14),
      axiReadSlave   => mAlgoAxiReadSlaves(14),
      axiWriteMaster => mAlgoAxiWriteMasters(14),
      axiWriteSlave  => mAlgoAxiWriteSlaves(14),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(14),
      -- User Read/Write registers
      regs => regsSLR0_14
      );

U_apxAxiRegsSLR0_15 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(15),
      axiReadSlave   => mAlgoAxiReadSlaves(15),
      axiWriteMaster => mAlgoAxiWriteMasters(15),
      axiWriteSlave  => mAlgoAxiWriteSlaves(15),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(15),
      -- User Read/Write registers
      regs => regsSLR0_15
      );

U_apxAxiRegsSLR0_16 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(16),
      axiReadSlave   => mAlgoAxiReadSlaves(16),
      axiWriteMaster => mAlgoAxiWriteMasters(16),
      axiWriteSlave  => mAlgoAxiWriteSlaves(16),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(16),
      -- User Read/Write registers
      regs => regsSLR0_16
      );

U_apxAxiRegsSLR0_17 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(17),
      axiReadSlave   => mAlgoAxiReadSlaves(17),
      axiWriteMaster => mAlgoAxiWriteMasters(17),
      axiWriteSlave  => mAlgoAxiWriteSlaves(17),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(17),
      -- User Read/Write registers
      regs => regsSLR0_17
      );

U_apxAxiRegsSLR0_18 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(18),
      axiReadSlave   => mAlgoAxiReadSlaves(18),
      axiWriteMaster => mAlgoAxiWriteMasters(18),
      axiWriteSlave  => mAlgoAxiWriteSlaves(18),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(18),
      -- User Read/Write registers
      regs => regsSLR0_18
      );

U_apxAxiRegsSLR0_19 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(19),
      axiReadSlave   => mAlgoAxiReadSlaves(19),
      axiWriteMaster => mAlgoAxiWriteMasters(19),
      axiWriteSlave  => mAlgoAxiWriteSlaves(19),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(19),
      -- User Read/Write registers
      regs => regsSLR0_19
      );

U_apxAxiRegsSLR0_20 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(20),
      axiReadSlave   => mAlgoAxiReadSlaves(20),
      axiWriteMaster => mAlgoAxiWriteMasters(20),
      axiWriteSlave  => mAlgoAxiWriteSlaves(20),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(20),
      -- User Read/Write registers
      regs => regsSLR0_20
      );

U_apxAxiRegsSLR0_21 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(21),
      axiReadSlave   => mAlgoAxiReadSlaves(21),
      axiWriteMaster => mAlgoAxiWriteMasters(21),
      axiWriteSlave  => mAlgoAxiWriteSlaves(21),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(21),
      -- User Read/Write registers
      regs => regsSLR0_21
      );

U_apxAxiRegsSLR0_22 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(22),
      axiReadSlave   => mAlgoAxiReadSlaves(22),
      axiWriteMaster => mAlgoAxiWriteMasters(22),
      axiWriteSlave  => mAlgoAxiWriteSlaves(22),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(22),
      -- User Read/Write registers
      regs => regsSLR0_22
      );

U_apxAxiRegsSLR0_23 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(23),
      axiReadSlave   => mAlgoAxiReadSlaves(23),
      axiWriteMaster => mAlgoAxiWriteMasters(23),
      axiWriteSlave  => mAlgoAxiWriteSlaves(23),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(23),
      -- User Read/Write registers
      regs => regsSLR0_23
      );

U_apxAxiRegsSLR0_24 : entity apx_fs.apxAxiRegs
    generic map(
      NUM_REG_G => 1)
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAlgoAxiReadMasters(24),
      axiReadSlave   => mAlgoAxiReadSlaves(24),
      axiWriteMaster => mAlgoAxiWriteMasters(24),
      axiWriteSlave  => mAlgoAxiWriteSlaves(24),
      axiClk         => axiClk,
      axiClkRst      => axiAlgoRstOut(24),
      -- User Read/Write registers
      regs => regsSLR0_24
      );

-------------------------------------------------------


----------------------------------------------------------------------------
---------------------ALGO INSTANTIATION AND OUTPUT GEN
----------------------------------------------------------------------------

RCT5x6_ALGO_SLR3: entity work.RCT5x6TopWrapper
  generic map(
    N_INPUT_STREAMS  => N_INPUT_STREAMS_IP1_5x6,
    N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_IP1
    )
  port map(
    -- Algo Control/Status Signals
    algoClk   => algoClk,
    algoRst   => algoRstD5_SLR3,
    algoStart => algoStartD5_SLR3,
    algoDone  => open,
    algoIdle  => open,
    algoReady => open,

    -- AXI-Stream In/Out Ports
    axiStreamIn  => axiStreamInSLR3D1,
    axiStreamOut => axiStreamOutSLR3D0
);

axiStreamOutSLR3D1 <= axiStreamOutSLR3D0 when rising_edge(algoClk);
axiStreamOutSLR3D2 <= axiStreamOutSLR3D1 when rising_edge(algoClk);
axiStreamOutSLR3D3 <= axiStreamOutSLR3D2 when rising_edge(algoClk);
axiStreamOutSLR3D4 <= axiStreamOutSLR3D3 when rising_edge(algoClk);
axiStreamOutSLR3D5 <= axiStreamOutSLR3D4 when rising_edge(algoClk);
axiStreamOutSLR3D6 <= axiStreamOutSLR3D5 when rising_edge(algoClk);
axiStreamOutSLR3D7 <= axiStreamOutSLR3D6 when rising_edge(algoClk);
axiStreamOutSLR3D8 <= axiStreamOutSLR3D7 when rising_edge(algoClk);
axiStreamOutSLR3D9 <= axiStreamOutSLR3D8 when rising_edge(algoClk);

------------------------------------------------------------------------
------------------------------------------------------------------------

RCT5x6_ALGO_SLR2: entity work.RCT5x6TopWrapper
  generic map(
    N_INPUT_STREAMS  => N_INPUT_STREAMS_IP1_5x6,
    N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_IP1
    )
  port map(
    -- Algo Control/Status Signals
    algoClk   => algoClk,
    algoRst   => algoRstD5_SLR2,
    algoStart => algoStartD5_SLR2,
    algoDone  => open,
    algoIdle  => open,
    algoReady => open,

    -- AXI-Stream In/Out Ports
    axiStreamIn  => axiStreamInSLR2D1,
    axiStreamOut => axiStreamOutSLR2D0
);

axiStreamOutSLR2D1 <= axiStreamOutSLR2D0 when rising_edge(algoClk);
axiStreamOutSLR2D2 <= axiStreamOutSLR2D1 when rising_edge(algoClk);
axiStreamOutSLR2D3 <= axiStreamOutSLR2D2 when rising_edge(algoClk);
axiStreamOutSLR2D4 <= axiStreamOutSLR2D3 when rising_edge(algoClk);
axiStreamOutSLR2D5 <= axiStreamOutSLR2D4 when rising_edge(algoClk);
axiStreamOutSLR2D6 <= axiStreamOutSLR2D5 when rising_edge(algoClk);
axiStreamOutSLR2D7 <= axiStreamOutSLR2D6 when rising_edge(algoClk);
axiStreamOutSLR2D8 <= axiStreamOutSLR2D7 when rising_edge(algoClk);
axiStreamOutSLR2D9 <= axiStreamOutSLR2D8 when rising_edge(algoClk);

------------------------------------------------------------------------
------------------------------------------------------------------------

RCT5x6_ALGO_SLR1: entity work.RCT5x6TopWrapper
  generic map(
    N_INPUT_STREAMS  => N_INPUT_STREAMS_IP1_5x6,
    N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_IP1
    )
  port map(
    -- Algo Control/Status Signals
    algoClk   => algoClk,
    algoRst   => algoRstD5_SLR1,
    algoStart => algoStartD5_SLR1,
    algoDone  => open,
    algoIdle  => open,
    algoReady => open,

    -- AXI-Stream In/Out Ports
    axiStreamIn  => axiStreamInSLR1D1,
    axiStreamOut => axiStreamOutSLR1D0
);

axiStreamOutSLR1D1 <= axiStreamOutSLR1D0 when rising_edge(algoClk);
axiStreamOutSLR1D2 <= axiStreamOutSLR1D1 when rising_edge(algoClk);
axiStreamOutSLR1D3 <= axiStreamOutSLR1D2 when rising_edge(algoClk);
axiStreamOutSLR1D4 <= axiStreamOutSLR1D3 when rising_edge(algoClk);
axiStreamOutSLR1D5 <= axiStreamOutSLR1D4 when rising_edge(algoClk);
axiStreamOutSLR1D6 <= axiStreamOutSLR1D5 when rising_edge(algoClk);
axiStreamOutSLR1D7 <= axiStreamOutSLR1D6 when rising_edge(algoClk);
axiStreamOutSLR1D8 <= axiStreamOutSLR1D7 when rising_edge(algoClk);
axiStreamOutSLR1D9 <= axiStreamOutSLR1D8 when rising_edge(algoClk);

------------------------------------------------------------------------
------------------------------------------------------------------------

RCT2x6_ALGO_SLR0: entity work.RCT2x6TopWrapper
  generic map(
    N_INPUT_STREAMS  => N_INPUT_STREAMS_IP1_2x6,
    N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_IP1
    )
  port map(
    -- Algo Control/Status Signals
    algoClk   => algoClk,
    algoRst   => algoRstD5_SLR0,
    algoStart => algoStartD5_SLR0,
    algoDone  => open,
    algoIdle  => open,
    algoReady => open,

    -- AXI-Stream In/Out Ports
    axiStreamIn  => axiStreamInSLR0D1,
    axiStreamOut => axiStreamOutSLR0D0
);

RCT_2x6_SLR0_OUTPUT_BUFFERING: for idx in 0 to N_OUTPUT_STREAMS_IP1-1 generate
  BUFFERING: entity work.AxiStreamBuffer
  GENERIC MAP(
      BUFFER_DEPTH => 24
  )
  PORT MAP( 
  algoClk =>  algoClk,
  
  axiStreamBuffIn  => axiStreamOutSLR0D0(idx),
  axiStreamBuffOut => axiStreamOutSLR0BUFF(idx)
  );
end generate;

--------------------------------------------------------------------------------
---- PREPARING INPUT STREAM AND START SIGNAL FOR IP2 -- PLUS IP2 INSTANTIATION
--------------------------------------------------------------------------------

GEN_IN_LINKS_IP2: for idx in 0 to N_OUTPUT_STREAMS_IP1-1 generate
  axiStreamInIP2(idx+0*N_OUTPUT_STREAMS_IP1) <= axiStreamOutSLR3D9(idx)   when rising_edge(algoClk);
  axiStreamInIP2(idx+1*N_OUTPUT_STREAMS_IP1) <= axiStreamOutSLR2D9(idx)   when rising_edge(algoClk);
  axiStreamInIP2(idx+2*N_OUTPUT_STREAMS_IP1) <= axiStreamOutSLR1D9(idx)   when rising_edge(algoClk);
  axiStreamInIP2(idx+3*N_OUTPUT_STREAMS_IP1) <= axiStreamOutSLR0BUFF(idx) when rising_edge(algoClk);
end generate;

GEN_START_SIG_IP2: process(algoClk)
begin
  IF(rising_edge(algoClk)) THEN
      IF(axiStreamInIP2(0).tValid = '1') THEN
          algoStartIP2D0   <= '1';
          algoStartIP2D1   <= algoStartIP2D0;
          algoStartIP2D2   <= algoStartIP2D1;
          algoStartIP2D3   <= algoStartIP2D2;
          algoStartIP2D4   <= algoStartIP2D3;
          algoStartIP2D5   <= algoStartIP2D4;
          algoStartIP2D6   <= algoStartIP2D5;
          algoStartIP2D7   <= algoStartIP2D6;
      ELSE
          algoStartIP2D7     <= '0';
      END IF;
  END IF;
end process;

ALGO_IP2_SLR0: entity work.IP2TopWrapper
generic map(
  N_INPUT_STREAMS  => N_INPUT_STREAMS_IP2,
  N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_IP2
  )
port map(
  -- Algo Control/Status Signals
  algoClk   => algoClk,
  algoRst   => algoRstD5_SLR0,
  algoStart => algoStartIP2D7,
  algoDone  => open,
  algoIdle  => open,
  algoReady => open,
  ----calib map to algo_top wrapper----
  calib0 => regsSLR0_0(15 downto 0),
  calib1 => regsSLR0_1(15 downto 0),
  calib2 => regsSLR0_2(15 downto 0),
  calib3 => regsSLR0_3(15 downto 0),
  calib4 => regsSLR0_4(15 downto 0),
  calib5 => regsSLR0_5(15 downto 0),
  calib6 => regsSLR0_6(15 downto 0),
  calib7 => regsSLR0_7(15 downto 0),
  calib8 => regsSLR0_8(15 downto 0),
  calib9 => regsSLR0_9(15 downto 0),
  calib10 => regsSLR0_10(15 downto 0),
  calib11 => regsSLR0_11(15 downto 0),
  calib12 => regsSLR0_12(15 downto 0),
  calib13 => regsSLR0_13(15 downto 0),
  calib14 => regsSLR0_14(15 downto 0),
  calib15 => regsSLR0_15(15 downto 0),
  calib16 => regsSLR0_16(15 downto 0),
  calib17 => regsSLR0_17(15 downto 0),
  calib18 => regsSLR0_18(15 downto 0),
  calib19 => regsSLR0_19(15 downto 0),
  calib20 => regsSLR0_20(15 downto 0),
  calib21 => regsSLR0_21(15 downto 0),
  calib22 => regsSLR0_22(15 downto 0),
  calib23 => regsSLR0_23(15 downto 0),
  calib24 => regsSLR0_24(15 downto 0),
  
  -- AXI-Stream In/Out Ports
  axiStreamIn  => axiStreamInIP2,
  axiStreamOut => axiStreamOutIP2
);

axiStreamOutIP2D0 <= axiStreamOutIP2   when rising_edge(algoClk);
axiStreamOutIP2D1 <= axiStreamOutIP2D0 when rising_edge(algoClk);

--------------------------------------------------------------------------------
---- PREPARING INPUT STREAM AND START SIGNAL FOR IP3 -- PLUS IP3 INSTANTIATION
--------------------------------------------------------------------------------

GEN_HCAL_IN_buff: for idx in 0 to N_INPUT_STREAMS_HCAL-1 generate
process(algoClk)
begin
    if(rising_edge(algoClk)) then
            axiStreamInHCAL(idx)    <= axiStreamIn(HCAL_LINK_INIT+idx);
            axiStreamInHCALD0(idx)  <= axiStreamInHCAL(idx);
    end if; 
end process;
end generate;

gen_InputMappingIP3_0:      axiStreamInIP3(0) <= axiStreamOutIP2D1(0);
gen_InputMappingIP3_1:      axiStreamInIP3(1) <= axiStreamOutIP2D1(1);
gen_InputMappingIP3_2:      axiStreamInIP3(2) <= axiStreamOutIP2D1(2);
gen_InputMappingIP3_3:      axiStreamInIP3(3) <= axiStreamOutIP2D1(3);
gen_InputMappingIP3_4:      axiStreamInIP3(4) <= axiStreamOutIP2D1(4);
gen_InputMappingIP3_HCAL_0: axiStreamInIP3(5) <= axiStreamInHCALD0(0);
gen_InputMappingIP3_HCAL_1: axiStreamInIP3(6) <= axiStreamInHCALD0(1);
gen_InputMappingIP3_HCAL_2: axiStreamInIP3(7) <= axiStreamInHCALD0(2);
gen_InputMappingIP3_HCAL_3: axiStreamInIP3(8) <= axiStreamInHCALD0(3);

GEN_START_IP3: process(algoClk)
begin
    IF(rising_edge(algoClk)) THEN
        IF(axiStreamInIP3(0).tValid = '1') THEN
            algoStartIP3D0   <= '1';
            algoStartIP3D1   <= algoStartIP3D0;
            algoStartIP3D2   <= algoStartIP3D1;
            algoStartIP3D3   <= algoStartIP3D2;
            algoStartIP3D4   <= algoStartIP3D3;
            algoStartIP3D5   <= algoStartIP3D4;
            algoStartIP3D6   <= algoStartIP3D5;
            algoStartIP3D7   <= algoStartIP3D6;
        ELSE
            algoStartIP3D7   <= '0';
        END IF;
    END IF;
end process;

ALGO_IP3_SLR0: entity work.IP3TopWrapper
  generic map(
    N_INPUT_STREAMS  => N_INPUT_STREAMS_IP3,
    N_OUTPUT_STREAMS => N_IP3_OUTPUTS
    )
  port map(
    -- Algo Control/Status Signals
    algoClk   => algoClk,
    algoRst   => algoRstD5_SLR0,
    algoStart => algoStartIP3D7,
    algoDone  => open,
    algoIdle  => open,
    algoReady => open,

    -- AXI-Stream In/Out Ports
    axiStreamIn  => axiStreamInIP3,
    axiStreamOut => axiStreamOutIP3
);

axiStreamOutIP3D0 <= axiStreamOutIP3   when rising_edge(algoClk);
axiStreamOutIP3D1 <= axiStreamOutIP3D0 when rising_edge(algoClk);



-- Generate block for duplication with pattern a,a,b,b,c,c,d,d
GEN_OUT_LINKS_SLR0: for idx in 0 to N_OUTPUTS_IP3_PLUS_DUP-1 generate
begin
    -- Calculate the correct input index for the duplication
    axiStreamOut_internal(XLA_OUTPUT_MAP_C_SLR0(idx)) <= axiStreamOutIP3D1(idx / 2);
end generate;

-- Pipeline duplicate signal
axiStreamOutD0 <= axiStreamOut_internal when rising_edge(algoClk);
axiStreamOutD1 <= axiStreamOutD0 when rising_edge(algoClk);

-- Assign the final pipelined signal to the output port
axiStreamOut <= axiStreamOutD1;

end rtl;



