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

attribute dont_touch : string;
attribute dont_touch of algoRstD_SLR0, algoRstD1_SLR0, algoRstD2_SLR0, algoRstD3_SLR0, algoRstD4_SLR0, algoRstD5_SLR0 : signal is "yes";
attribute dont_touch of algoStartD_SLR0, algoStartD1_SLR0, algoStartD2_SLR0, algoStartD3_SLR0, algoStartD4_SLR0, algoStartD5_SLR0 : signal is "yes";

attribute dont_touch of algoRstD_SLR1, algoRstD1_SLR1, algoRstD2_SLR1, algoRstD3_SLR1, algoRstD4_SLR1, algoRstD5_SLR1 : signal is "yes";
attribute dont_touch of algoStartD_SLR1, algoStartD1_SLR1, algoStartD2_SLR1, algoStartD3_SLR1, algoStartD4_SLR1, algoStartD5_SLR1 : signal is "yes";

attribute dont_touch of algoRstD_SLR2, algoRstD1_SLR2, algoRstD2_SLR2, algoRstD3_SLR2, algoRstD4_SLR2, algoRstD5_SLR2 : signal is "yes";
attribute dont_touch of algoStartD_SLR2, algoStartD1_SLR2, algoStartD2_SLR2, algoStartD3_SLR2, algoStartD4_SLR2, algoStartD5_SLR2 : signal is "yes";

attribute dont_touch of algoRstD_SLR3, algoRstD1_SLR3, algoRstD2_SLR3, algoRstD3_SLR3, algoRstD4_SLR3, algoRstD5_SLR3 : signal is "yes";
attribute dont_touch of algoStartD_SLR3, algoStartD1_SLR3, algoStartD2_SLR3, algoStartD3_SLR3, algoStartD4_SLR3, algoStartD5_SLR3 : signal is "yes";

attribute shreg_extract : string;
attribute shreg_extract of algoRstD_SLR0, algoRstD1_SLR0, algoRstD2_SLR0, algoRstD3_SLR0, algoRstD4_SLR0, algoRstD5_SLR0 : signal is "no";
attribute shreg_extract of algoStartD_SLR0, algoStartD1_SLR0, algoStartD2_SLR0, algoStartD3_SLR0, algoStartD4_SLR0, algoStartD5_SLR0 : signal is "no";

attribute shreg_extract of algoRstD_SLR1, algoRstD1_SLR1, algoRstD2_SLR1, algoRstD3_SLR1, algoRstD4_SLR1, algoRstD5_SLR1 : signal is "no";
attribute shreg_extract of algoStartD_SLR1, algoStartD1_SLR1, algoStartD2_SLR1, algoStartD3_SLR1, algoStartD4_SLR1, algoStartD5_SLR1 : signal is "no";

attribute shreg_extract of algoRstD_SLR2, algoRstD1_SLR2, algoRstD2_SLR2, algoRstD3_SLR2, algoRstD4_SLR2, algoRstD5_SLR2 : signal is "no";
attribute shreg_extract of algoStartD_SLR2, algoStartD1_SLR2, algoStartD2_SLR2, algoStartD3_SLR2, algoStartD4_SLR2, algoStartD5_SLR2 : signal is "no";

attribute shreg_extract of algoRstD_SLR3, algoRstD1_SLR3, algoRstD2_SLR3, algoRstD3_SLR3, algoRstD4_SLR3, algoRstD5_SLR3 : signal is "no";
attribute shreg_extract of algoStartD_SLR3, algoStartD1_SLR3, algoStartD2_SLR3, algoStartD3_SLR3, algoStartD4_SLR3, algoStartD5_SLR3 : signal is "no";

signal axiStreamInSLR3   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR3D0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR3D1 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR3D2 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);

signal axiStreamInSLR2   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR2D0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR2D1 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR2D2 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);

signal axiStreamInSLR1   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR1D0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR1D1 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);
signal axiStreamInSLR1D2 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_5x6-1);

signal axiStreamInSLR0   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_2x6-1);
signal axiStreamInSLR0D0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_2x6-1);
signal axiStreamInSLR0D1 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_2x6-1);
signal axiStreamInSLR0D2 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO_2x6-1);

signal axiStreamOutSLR0D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR0D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR0D2 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR0D3 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR0D4 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR0D5 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR0D6 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);

signal axiStreamOutSLR1D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR1D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR1D2 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR1D3 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR1D4 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR1D5 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR1D6 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);

signal axiStreamOutSLR2D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR2D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR2D2 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR2D3 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR2D4 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR2D5 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR2D6 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);

signal axiStreamOutSLR3D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR3D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR3D2 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR3D3 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR3D4 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR3D5 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
signal axiStreamOutSLR3D6 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);

signal axiStreamOutAlgo : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_TOTAL-1);

attribute shreg_extract of axiStreamInSLR3D1, axiStreamInSLR2D1, axiStreamInSLR1D1, axiStreamInSLR0D1: signal is "no";

attribute shreg_extract of axiStreamOutSLR0D0, axiStreamOutSLR0D1, axiStreamOutSLR0D2, axiStreamOutSLR0D3, axiStreamOutSLR0D4, axiStreamOutSLR0D5, axiStreamOutSLR0D6: signal is "no";
attribute shreg_extract of axiStreamOutSLR1D0, axiStreamOutSLR1D1, axiStreamOutSLR1D2, axiStreamOutSLR1D3, axiStreamOutSLR1D4, axiStreamOutSLR1D5, axiStreamOutSLR1D6: signal is "no";
attribute shreg_extract of axiStreamOutSLR2D0, axiStreamOutSLR2D1, axiStreamOutSLR2D2, axiStreamOutSLR2D3, axiStreamOutSLR2D4, axiStreamOutSLR2D5, axiStreamOutSLR2D6: signal is "no";
attribute shreg_extract of axiStreamOutSLR3D0, axiStreamOutSLR3D1, axiStreamOutSLR3D2, axiStreamOutSLR3D3, axiStreamOutSLR3D4, axiStreamOutSLR3D5, axiStreamOutSLR3D6: signal is "no";

constant XLA_INPUT_MAP_C_SLR3 : IntegerArray(0 to N_INPUT_STREAMS_ALGO_5x6-1) := (
   0  => 44,
   6  => 45,
   12 => 46,
   18 => 47,
   24 => 48,
   3  => 49,
   9  => 50,
   15 => 51,
   21 => 52,
   27 => 53,
   4  => 54,
   10 => 55,
   16 => 56,
   22 => 57,
   28 => 58,

   1  => 108,
   7  => 109,
   13 => 110,
   19 => 111,
   25 => 112,
   2  => 113,
   8  => 114,
   14 => 115,
   20 => 116,
   26 => 117,
   5  => 118,
   11 => 119,
   17 => 120,
   23 => 121,
   29 => 122
);

constant XLA_INPUT_MAP_C_SLR2 : IntegerArray(0 to N_INPUT_STREAMS_ALGO_5x6-1) := (
    --sector 2
    0  => 28,
    6  => 29,
    12 => 30,
    18 => 31,
    24 => 32,
    3  => 33,
    9  => 34,
    15 => 35,
    21 => 36,
    27 => 37,
    4  => 38,
    10 => 39,
    16 => 40,
    22 => 41,
    28 => 42,
    
    1  => 92,
    7  => 93,
    13 => 94,
    19 => 95,
    25 => 96,
    2  => 97,
    8  => 98,
    14 => 99,
    20 => 100,
    26 => 101,
    5  => 102,
    11 => 103,
    17 => 104,
    23 => 105,
    29 => 106
);

constant XLA_INPUT_MAP_C_SLR1 : IntegerArray(0 to N_INPUT_STREAMS_ALGO_5x6-1) := (
    --sector 1
    0  => 12,
    6  => 13,
    12 => 14,
    18 => 15,
    24 => 16,
    3  => 17,
    9  => 18,
    15 => 19,
    21 => 20,
    27 => 21,
    4  => 22,
    10 => 23,
    16 => 24,
    22 => 25,
    28 => 26,

    1  => 76,
    7  => 77,
    13 => 78,
    19 => 79,
    25 => 80,
    2  => 81,
    8  => 82,
    14 => 83,
    20 => 84,
    26 => 85,
    5  => 86,
    11 => 87,
    17 => 88,
    23 => 89,
    29 => 90
);

constant XLA_INPUT_MAP_C_SLR0 : IntegerArray(0 to N_INPUT_STREAMS_ALGO_2x6-1) := (
    --sector 0
    0  => 64,
    6  => 65,
    1  => 66,
    7  => 67,
    2  => 68,
    8  => 69,
    3  => 70,
    9  => 71,
    4  => 72,
    10 => 73,
    5  => 74,
    11 => 75
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
    0  => 64,
    1  => 65
);

begin

----------------------------------------------------------------------------
---------------------INPUT MAPPING
----------------------------------------------------------------------------

gen_XlaInputMapping_5x6 : for i in 0 to N_INPUT_STREAMS_ALGO_5x6-1 generate
    axiStreamInSLR3(i) <= axiStreamIn(XLA_INPUT_MAP_C_SLR3(i));
    axiStreamInSLR2(i) <= axiStreamIn(XLA_INPUT_MAP_C_SLR2(i));
    axiStreamInSLR1(i) <= axiStreamIn(XLA_INPUT_MAP_C_SLR1(i));
end generate;

gen_XlaInputMapping_2x6 : for i in 0 to N_INPUT_STREAMS_ALGO_2x6-1 generate
    axiStreamInSLR0(i) <= axiStreamIn(XLA_INPUT_MAP_C_SLR0(i));
end generate;

----------------------------------------------------------------------------
---------------------INPUT BUFFERING
----------------------------------------------------------------------------

axiStreamInSLR3D0 <= axiStreamInSLR3   when rising_edge(algoClk);
axiStreamInSLR3D1 <= axiStreamInSLR3D0 when rising_edge(algoClk);
axiStreamInSLR3D2 <= axiStreamInSLR3D1 when rising_edge(algoClk);

axiStreamInSLR2D0 <= axiStreamInSLR2   when rising_edge(algoClk);
axiStreamInSLR2D1 <= axiStreamInSLR2D0 when rising_edge(algoClk);
axiStreamInSLR2D2 <= axiStreamInSLR2D1 when rising_edge(algoClk);

axiStreamInSLR1D0 <= axiStreamInSLR1   when rising_edge(algoClk);
axiStreamInSLR1D1 <= axiStreamInSLR1D0 when rising_edge(algoClk);
axiStreamInSLR1D2 <= axiStreamInSLR1D1 when rising_edge(algoClk);

axiStreamInSLR0D0 <= axiStreamInSLR0   when rising_edge(algoClk);
axiStreamInSLR0D1 <= axiStreamInSLR0D0 when rising_edge(algoClk);
axiStreamInSLR0D2 <= axiStreamInSLR0D1 when rising_edge(algoClk);

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
    algoRst   => algoRstD5_SLR3,
    algoStart => algoStartD5_SLR3,
    algoDone  => open,
    algoIdle  => open,
    algoReady => open,

    -- AXI-Stream In/Out Ports
    axiStreamIn  => axiStreamInSLR3D2,
    axiStreamOut => axiStreamOutSLR3D0
);

--------------------------------------------------------------------------------
--SLR crossing of SLR3 output
--------------------------------------------------------------------------------

axiStreamOutSLR3D1 <= axiStreamOutSLR3D0 when rising_edge(algoClk);
axiStreamOutSLR3D2 <= axiStreamOutSLR3D1 when rising_edge(algoClk);
axiStreamOutSLR3D3 <= axiStreamOutSLR3D2 when rising_edge(algoClk);
--axiStreamOutSLR3D4 <= axiStreamOutSLR3D3 when rising_edge(algoClk);
--axiStreamOutSLR3D5 <= axiStreamOutSLR3D4 when rising_edge(algoClk);
--axiStreamOutSLR3D6 <= axiStreamOutSLR3D5 when rising_edge(algoClk);

RCT5x6_ALGO_SLR2: entity work.RCT5x6TopWrapper
  generic map(
    N_INPUT_STREAMS  => N_INPUT_STREAMS_ALGO_5x6,
    N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_ALGO
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
    axiStreamIn  => axiStreamInSLR2D2,
    axiStreamOut => axiStreamOutSLR2D0
);

--------------------------------------------------------------------------------
--SLR crossing of SLR2 output
--------------------------------------------------------------------------------

axiStreamOutSLR2D1 <= axiStreamOutSLR2D0 when rising_edge(algoClk);
axiStreamOutSLR2D2 <= axiStreamOutSLR2D1 when rising_edge(algoClk);
axiStreamOutSLR2D3 <= axiStreamOutSLR2D2 when rising_edge(algoClk);
--axiStreamOutSLR2D4 <= axiStreamOutSLR2D3 when rising_edge(algoClk);
--axiStreamOutSLR2D5 <= axiStreamOutSLR2D4 when rising_edge(algoClk);
--axiStreamOutSLR2D6 <= axiStreamOutSLR2D5 when rising_edge(algoClk);

RCT5x6_ALGO_SLR1: entity work.RCT5x6TopWrapper
  generic map(
    N_INPUT_STREAMS  => N_INPUT_STREAMS_ALGO_5x6,
    N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_ALGO
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
    axiStreamIn  => axiStreamInSLR1D2,
    axiStreamOut => axiStreamOutSLR1D0
);

--------------------------------------------------------------------------------
--SLR crossing of SLR1 output
--------------------------------------------------------------------------------

axiStreamOutSLR1D1 <= axiStreamOutSLR1D0 when rising_edge(algoClk);
axiStreamOutSLR1D2 <= axiStreamOutSLR1D1 when rising_edge(algoClk);
axiStreamOutSLR1D3 <= axiStreamOutSLR1D2 when rising_edge(algoClk);
--axiStreamOutSLR1D4 <= axiStreamOutSLR1D3 when rising_edge(algoClk);
--axiStreamOutSLR1D5 <= axiStreamOutSLR1D4 when rising_edge(algoClk);
--axiStreamOutSLR1D6 <= axiStreamOutSLR1D5 when rising_edge(algoClk);

RCT2x6_ALGO_SLR0: entity work.RCT2x6TopWrapper
  generic map(
    N_INPUT_STREAMS  => N_INPUT_STREAMS_ALGO_2x6,
    N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_ALGO
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
    axiStreamIn  => axiStreamInSLR0D2,
    axiStreamOut => axiStreamOutSLR0D0
);

--------------------------------------------------------------------------------
--buffering of SLR0 output
--------------------------------------------------------------------------------

axiStreamOutSLR0D1 <= axiStreamOutSLR0D0 when rising_edge(algoClk);
axiStreamOutSLR0D2 <= axiStreamOutSLR0D1 when rising_edge(algoClk);
axiStreamOutSLR0D3 <= axiStreamOutSLR0D2 when rising_edge(algoClk);
--axiStreamOutSLR0D4 <= axiStreamOutSLR0D3 when rising_edge(algoClk);
--axiStreamOutSLR0D5 <= axiStreamOutSLR0D4 when rising_edge(algoClk);
--axiStreamOutSLR0D6 <= axiStreamOutSLR0D5 when rising_edge(algoClk);

GEN_OUT_LINKS: for idx in 0 to N_OUTPUT_STREAMS_ALGO-1 generate
    axiStreamOut(XLA_OUTPUT_MAP_C_SLR0(idx))   <= axiStreamOutSLR0D3(idx);
    axiStreamOut(XLA_OUTPUT_MAP_C_SLR1(idx))   <= axiStreamOutSLR1D3(idx);
    axiStreamOut(XLA_OUTPUT_MAP_C_SLR2(idx))   <= axiStreamOutSLR2D3(idx); 
    axiStreamOut(XLA_OUTPUT_MAP_C_SLR3(idx))   <= axiStreamOutSLR3D3(idx);
end generate;

end rtl;
