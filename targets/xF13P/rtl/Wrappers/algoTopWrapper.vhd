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

CONSTANT N_INPUT_STREAMS_ALGO_5x6  : INTEGER := 30;
CONSTANT N_INPUT_STREAMS_ALGO_2x6  : INTEGER := 12;
CONSTANT N_OUTPUT_STREAMS_ALGO     : INTEGER := 2;
CONSTANT N_OUTPUT_STREAMS_TOTAL    : INTEGER := 8;

SIGNAL algoRstD_SLR0    : std_logic := '1';
SIGNAL algoRstD1_SLR0   : std_logic := '1';
SIGNAL algoRstD2_SLR0   : std_logic := '1';
SIGNAL algoRstD3_SLR0   : std_logic := '1';
SIGNAL algoRstD4_SLR0   : std_logic := '1';
SIGNAL algoRstD5_SLR0   : std_logic := '1';
SIGNAL algoRstD6_SLR0   : std_logic := '1';

SIGNAL algoStartD_SLR0  : std_logic := '0';
SIGNAL algoStartD1_SLR0 : std_logic := '0';
SIGNAL algoStartD2_SLR0 : std_logic := '0';
SIGNAL algoStartD3_SLR0 : std_logic := '0';
SIGNAL algoStartD4_SLR0 : std_logic := '0';
SIGNAL algoStartD5_SLR0 : std_logic := '0';
SIGNAL algoStartD6_SLR0 : std_logic := '0';

SIGNAL algoRstD_SLR1    : std_logic := '1';
SIGNAL algoRstD1_SLR1   : std_logic := '1';
SIGNAL algoRstD2_SLR1   : std_logic := '1';
SIGNAL algoRstD3_SLR1   : std_logic := '1';
SIGNAL algoRstD4_SLR1   : std_logic := '1';
SIGNAL algoRstD5_SLR1   : std_logic := '1';
SIGNAL algoRstD6_SLR1   : std_logic := '1';

SIGNAL algoStartD_SLR1  : std_logic := '0';
SIGNAL algoStartD1_SLR1 : std_logic := '0';
SIGNAL algoStartD2_SLR1 : std_logic := '0';
SIGNAL algoStartD3_SLR1 : std_logic := '0';
SIGNAL algoStartD4_SLR1 : std_logic := '0';
SIGNAL algoStartD5_SLR1 : std_logic := '0';
SIGNAL algoStartD6_SLR1 : std_logic := '0';

SIGNAL algoRstD_SLR2   : std_logic := '1';
SIGNAL algoRstD1_SLR2  : std_logic := '1';
SIGNAL algoRstD2_SLR2  : std_logic := '1';
SIGNAL algoRstD3_SLR2  : std_logic := '1';
SIGNAL algoRstD4_SLR2  : std_logic := '1';
SIGNAL algoRstD5_SLR2  : std_logic := '1';
SIGNAL algoRstD6_SLR2  : std_logic := '1';

SIGNAL algoStartD_SLR2  : std_logic := '0';
SIGNAL algoStartD1_SLR2 : std_logic := '0';
SIGNAL algoStartD2_SLR2 : std_logic := '0';
SIGNAL algoStartD3_SLR2 : std_logic := '0';
SIGNAL algoStartD4_SLR2 : std_logic := '0';
SIGNAL algoStartD5_SLR2 : std_logic := '0';
SIGNAL algoStartD6_SLR2 : std_logic := '0';

SIGNAL algoRstD_SLR3    : std_logic := '1';
SIGNAL algoRstD1_SLR3   : std_logic := '1';
SIGNAL algoRstD2_SLR3   : std_logic := '1';
SIGNAL algoRstD3_SLR3   : std_logic := '1';
SIGNAL algoRstD4_SLR3   : std_logic := '1';
SIGNAL algoRstD5_SLR3   : std_logic := '1';
SIGNAL algoRstD6_SLR3   : std_logic := '1';

SIGNAL algoStartD_SLR3  : std_logic := '0';
SIGNAL algoStartD1_SLR3 : std_logic := '0';
SIGNAL algoStartD2_SLR3 : std_logic := '0';
SIGNAL algoStartD3_SLR3 : std_logic := '0';
SIGNAL algoStartD4_SLR3 : std_logic := '0';
SIGNAL algoStartD5_SLR3 : std_logic := '0';
SIGNAL algoStartD6_SLR3 : std_logic := '0';

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

signal axiStreamInSLR3   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR3D0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR3D1 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);

signal axiStreamInSLR2   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR2D0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR2D1 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);

signal axiStreamInSLR1   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR1D0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR1D1 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);

signal axiStreamInSLR0   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_2x6-1);
signal axiStreamInSLR0D0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_2x6-1);
signal axiStreamInSLR0D1 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_2x6-1);

signal axiStreamOutSLR0D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR0D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR0D2 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);

signal axiStreamOutSLR1D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR1D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR1D2 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);

signal axiStreamOutSLR2D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR2D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR2D2 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);

signal axiStreamOutSLR3D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR3D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR3D2 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);

constant XLA_INPUT_MAP_C_SLR3 : IntegerArray(0 to N_INPUT_STREAMS_ALGO_5x6-1) := (
   0  => 44,
   1  => 45,
   2  => 46,
   3  => 47,
   4  => 48,
   5  => 49,
   6  => 50,
   7  => 51,
   8  => 52,
   9  => 53,
   10 => 54,
   11 => 55,
   12 => 56,
   13 => 57,
   14 => 58,

   15 => 122,
   16 => 121,
   17 => 120,
   18 => 119,
   19 => 118,
   20 => 117,
   21 => 116,
   22 => 115,
   23 => 114,
   24 => 113,
   25 => 112,
   26 => 111,
   27 => 110,
   28 => 109,
   29 => 108
);

constant XLA_INPUT_MAP_C_SLR2 : IntegerArray(0 to N_INPUT_STREAMS_ALGO_5x6-1) := (
    --sector 2
    0  => 28,
    1  => 29,
    2  => 30,
    3  => 31,
    4  => 32,
    5  => 33,
    6  => 34,
    7  => 35,
    8  => 36,
    9  => 37,
    10 => 38,
    11 => 39,
    12 => 40,
    13 => 41,
    14 => 42,

    15 => 106,
    16 => 105,
    17 => 104,
    18 => 103,
    19 => 102,
    20 => 101,
    21 => 100,
    22 => 99,
    23 => 98,
    24 => 97,
    25 => 96,
    26 => 95,
    27 => 94,
    28 => 93,
    29 => 92
);

constant XLA_INPUT_MAP_C_SLR1 : IntegerArray(0 to N_INPUT_STREAMS_ALGO_5x6-1) := (
    --sector 1
    0  => 12,
    1  => 13,
    2  => 14,
    3  => 15,
    4  => 16,
    5  => 17,
    6  => 18,
    7  => 19,
    8  => 20,
    9  => 21,
    10 => 22,
    11 => 23,
    12 => 24,
    13 => 25,
    14 => 26,
    
    15 => 90,
    16 => 89,
    17 => 88,
    18 => 87,
    19 => 86,
    20 => 85,
    21 => 84,
    22 => 83,
    23 => 82,
    24 => 81,
    25 => 80,
    26 => 79,
    27 => 78,
    28 => 77,
    29 => 76
);

constant XLA_INPUT_MAP_C_SLR0 : IntegerArray(0 to N_INPUT_STREAMS_ALGO_2x6-1) := (
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

constant XLA_OUTPUT_MAP_C_SLR3 : IntegerArray(0 to N_OUTPUT_STREAMS_ALGO-1) := (
    --sector 3
    0  => 115,
    1  => 116
);

constant XLA_OUTPUT_MAP_C_SLR2 : IntegerArray(0 to N_OUTPUT_STREAMS_ALGO-1) := (
    --sector 2
    0  => 99,
    1  => 100
);

constant XLA_OUTPUT_MAP_C_SLR1 : IntegerArray(0 to N_OUTPUT_STREAMS_ALGO-1) := (
    --sector 1
    0  => 83,
    1  => 84
);

constant XLA_OUTPUT_MAP_C_SLR0 : IntegerArray(0 to N_OUTPUT_STREAMS_ALGO-1) := (
    --sector 0
    0  => 0,
    1  => 1
);

begin

----------------------------------------------------------------------------
---------------------INPUT MAPPING
----------------------------------------------------------------------------

GEN_IN_LINKS_SLR3: for i in 0 to N_INPUT_STREAMS_ALGO_5x6-1 generate
    axiStreamInSLR3(i) <= axiStreamIn(XLA_INPUT_MAP_C_SLR3(i));
end generate;

GEN_IN_LINKS_SLR2: for i in 0 to N_INPUT_STREAMS_ALGO_5x6-1 generate
    axiStreamInSLR2(i) <= axiStreamIn(XLA_INPUT_MAP_C_SLR2(i));
end generate;

GEN_IN_LINKS_SLR1: for i in 0 to N_INPUT_STREAMS_ALGO_5x6-1 generate
    axiStreamInSLR1(i) <= axiStreamIn(XLA_INPUT_MAP_C_SLR1(i));
end generate;

GEN_IN_LINKS_SLR0: for i in 0 to N_INPUT_STREAMS_ALGO_2x6-1 generate
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
algoRstD6_SLR3  <= algoRstD5_SLR3  when rising_edge(algoClk);

algoStartD_SLR3  <= algoStart         when rising_edge(algoClk);
algoStartD1_SLR3 <= algoStartD_SLR3   when rising_edge(algoClk);
algoStartD2_SLR3 <= algoStartD1_SLR3  when rising_edge(algoClk);
algoStartD3_SLR3 <= algoStartD2_SLR3  when rising_edge(algoClk);
algoStartD4_SLR3 <= algoStartD3_SLR3  when rising_edge(algoClk);
algoStartD5_SLR3 <= algoStartD4_SLR3  when rising_edge(algoClk);
algoStartD6_SLR3 <= algoStartD5_SLR3  when rising_edge(algoClk);

----------------------------------------------------------------------------
---------------------FOR SLR2
----------------------------------------------------------------------------

algoRstD_SLR2   <= algoRst         when rising_edge(algoClk);
algoRstD1_SLR2  <= algoRstD_SLR2   when rising_edge(algoClk);
algoRstD2_SLR2  <= algoRstD1_SLR2  when rising_edge(algoClk);
algoRstD3_SLR2  <= algoRstD2_SLR2  when rising_edge(algoClk);
algoRstD4_SLR2  <= algoRstD3_SLR2  when rising_edge(algoClk);
algoRstD5_SLR2  <= algoRstD4_SLR2  when rising_edge(algoClk);
algoRstD6_SLR2  <= algoRstD5_SLR2  when rising_edge(algoClk);

algoStartD_SLR2  <= algoStart         when rising_edge(algoClk);
algoStartD1_SLR2 <= algoStartD_SLR2   when rising_edge(algoClk);
algoStartD2_SLR2 <= algoStartD1_SLR2  when rising_edge(algoClk);
algoStartD3_SLR2 <= algoStartD2_SLR2  when rising_edge(algoClk);
algoStartD4_SLR2 <= algoStartD3_SLR2  when rising_edge(algoClk);
algoStartD5_SLR2 <= algoStartD4_SLR2  when rising_edge(algoClk);
algoStartD6_SLR2 <= algoStartD5_SLR2  when rising_edge(algoClk);

----------------------------------------------------------------------------
---------------------FOR SLR1
----------------------------------------------------------------------------

algoRstD_SLR1   <= algoRst         when rising_edge(algoClk);
algoRstD1_SLR1  <= algoRstD_SLR1   when rising_edge(algoClk);
algoRstD2_SLR1  <= algoRstD1_SLR1  when rising_edge(algoClk);
algoRstD3_SLR1  <= algoRstD2_SLR1  when rising_edge(algoClk);
algoRstD4_SLR1  <= algoRstD3_SLR1  when rising_edge(algoClk);
algoRstD5_SLR1  <= algoRstD4_SLR1  when rising_edge(algoClk);
algoRstD6_SLR1  <= algoRstD5_SLR1  when rising_edge(algoClk);

algoStartD_SLR1  <= algoStart         when rising_edge(algoClk);
algoStartD1_SLR1 <= algoStartD_SLR1   when rising_edge(algoClk);
algoStartD2_SLR1 <= algoStartD1_SLR1  when rising_edge(algoClk);
algoStartD3_SLR1 <= algoStartD2_SLR1  when rising_edge(algoClk);
algoStartD4_SLR1 <= algoStartD3_SLR1  when rising_edge(algoClk);
algoStartD5_SLR1 <= algoStartD4_SLR1  when rising_edge(algoClk);
algoStartD6_SLR1 <= algoStartD5_SLR1  when rising_edge(algoClk);

----------------------------------------------------------------------------
---------------------FOR SLR0
----------------------------------------------------------------------------

algoRstD_SLR0   <= algoRst         when rising_edge(algoClk);
algoRstD1_SLR0  <= algoRstD_SLR0   when rising_edge(algoClk);
algoRstD2_SLR0  <= algoRstD1_SLR0  when rising_edge(algoClk);
algoRstD3_SLR0  <= algoRstD2_SLR0  when rising_edge(algoClk);
algoRstD4_SLR0  <= algoRstD3_SLR0  when rising_edge(algoClk);
algoRstD5_SLR0  <= algoRstD4_SLR0  when rising_edge(algoClk);
algoRstD6_SLR0  <= algoRstD5_SLR0  when rising_edge(algoClk);

algoStartD_SLR0  <= algoStart         when rising_edge(algoClk);
algoStartD1_SLR0 <= algoStartD_SLR0   when rising_edge(algoClk);
algoStartD2_SLR0 <= algoStartD1_SLR0  when rising_edge(algoClk);
algoStartD3_SLR0 <= algoStartD2_SLR0  when rising_edge(algoClk);
algoStartD4_SLR0 <= algoStartD3_SLR0  when rising_edge(algoClk);
algoStartD5_SLR0 <= algoStartD4_SLR0  when rising_edge(algoClk);
algoStartD6_SLR0 <= algoStartD5_SLR0  when rising_edge(algoClk);

----------------------------------------------------------------------------
---------------------ALGO INSTANTIATION AND OUTPUT GEN
----------------------------------------------------------------------------

RCT5x6_ALGO_SLR3: entity work.RCT5x6TopWrapper
  generic map(
    N_INPUT_STREAMS  => N_INPUT_STREAMS_ALGO_5x6,
    N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_ALGO
    )
  port map(
    -- Algo Control/Status Signals
    algoClk   => algoClk,
    algoRst   => algoRstD6_SLR3,
    algoStart => algoStartD6_SLR3,
    algoDone  => open,
    algoIdle  => open,
    algoReady => open,

    -- AXI-Stream In/Out Ports
    axiStreamIn  => axiStreamInSLR3D1,
    axiStreamOut => axiStreamOutSLR3D0
);

axiStreamOutSLR3D1 <= axiStreamOutSLR3D0 when rising_edge(algoClk);
axiStreamOutSLR3D2 <= axiStreamOutSLR3D1 when rising_edge(algoClk);

------------------------------------------------------------------------
------------------------------------------------------------------------

RCT5x6_ALGO_SLR2: entity work.RCT5x6TopWrapper
  generic map(
    N_INPUT_STREAMS  => N_INPUT_STREAMS_ALGO_5x6,
    N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_ALGO
    )
  port map(
    -- Algo Control/Status Signals
    algoClk   => algoClk,
    algoRst   => algoRstD6_SLR2,
    algoStart => algoStartD6_SLR2,
    algoDone  => open,
    algoIdle  => open,
    algoReady => open,

    -- AXI-Stream In/Out Ports
    axiStreamIn  => axiStreamInSLR2D1,
    axiStreamOut => axiStreamOutSLR2D0
);

axiStreamOutSLR2D1 <= axiStreamOutSLR2D0 when rising_edge(algoClk);
axiStreamOutSLR2D2 <= axiStreamOutSLR2D1 when rising_edge(algoClk);

------------------------------------------------------------------------
------------------------------------------------------------------------

RCT5x6_ALGO_SLR1: entity work.RCT5x6TopWrapper
  generic map(
    N_INPUT_STREAMS  => N_INPUT_STREAMS_ALGO_5x6,
    N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_ALGO
    )
  port map(
    -- Algo Control/Status Signals
    algoClk   => algoClk,
    algoRst   => algoRstD6_SLR1,
    algoStart => algoStartD6_SLR1,
    algoDone  => open,
    algoIdle  => open,
    algoReady => open,

    -- AXI-Stream In/Out Ports
    axiStreamIn  => axiStreamInSLR1D1,
    axiStreamOut => axiStreamOutSLR1D0
);

axiStreamOutSLR1D1 <= axiStreamOutSLR1D0 when rising_edge(algoClk);
axiStreamOutSLR1D2 <= axiStreamOutSLR1D1 when rising_edge(algoClk);

------------------------------------------------------------------------
------------------------------------------------------------------------

RCT2x6_ALGO_SLR0: entity work.RCT2x6TopWrapper
  generic map(
    N_INPUT_STREAMS  => N_INPUT_STREAMS_ALGO_2x6,
    N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_ALGO
    )
  port map(
    -- Algo Control/Status Signals
    algoClk   => algoClk,
    algoRst   => algoRstD6_SLR0,
    algoStart => algoStartD6_SLR0,
    algoDone  => open,
    algoIdle  => open,
    algoReady => open,

    -- AXI-Stream In/Out Ports
    axiStreamIn  => axiStreamInSLR0D1,
    axiStreamOut => axiStreamOutSLR0D0
);

axiStreamOutSLR0D1 <= axiStreamOutSLR0D0 when rising_edge(algoClk);
axiStreamOutSLR0D2 <= axiStreamOutSLR0D1 when rising_edge(algoClk);

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

GEN_OUT_LINKS_SLR3: for idx in 0 to N_OUTPUT_STREAMS_ALGO-1 generate
    axiStreamOut(XLA_OUTPUT_MAP_C_SLR3(idx))   <= axiStreamOutSLR3D2(idx);
end generate;

GEN_OUT_LINKS_SLR2: for idx in 0 to N_OUTPUT_STREAMS_ALGO-1 generate
    axiStreamOut(XLA_OUTPUT_MAP_C_SLR2(idx))   <= axiStreamOutSLR2D2(idx);
end generate;

GEN_OUT_LINKS_SLR1: for idx in 0 to N_OUTPUT_STREAMS_ALGO-1 generate
    axiStreamOut(XLA_OUTPUT_MAP_C_SLR1(idx))   <= axiStreamOutSLR1D2(idx); 
end generate;

GEN_OUT_LINKS_SLR0: for idx in 0 to N_OUTPUT_STREAMS_ALGO-1 generate
    axiStreamOut(XLA_OUTPUT_MAP_C_SLR0(idx))   <= axiStreamOutSLR0D2(idx);
end generate;

end rtl;
