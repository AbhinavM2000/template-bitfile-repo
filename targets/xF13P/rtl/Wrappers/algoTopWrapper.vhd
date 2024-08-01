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
CONSTANT N_OUTPUT_STREAMS_IP3 : NATURAL := 8; -- This has been doubled to account for the 2x duplication

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
signal axiStreamOutIP3   : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP3-1);
signal axiStreamOutIP3D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP3-1);
signal axiStreamOutIP3D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP3-1);

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

constant XLA_OUTPUT_MAP_C_SLR0 : IntegerArray(0 to N_OUTPUT_STREAMS_IP3-1) := (
  --sector 4
  0  => 64,
  1  => 65,
  2  => 66,
  3  => 67,
  --duplicate outputs
  4  => 68,
  5  => 69,
  6  => 70,
  7  => 71
);

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
    N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_IP3
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


-- First generate statement for 4 outputs
GEN_OUT_LINKS_SLR0_0_TO_3: for idx in 0 to 3 generate
    axiStreamOut(XLA_OUTPUT_MAP_C_SLR0(idx)) <= axiStreamOutIP3D1(idx);
end generate;

-- Second generate statement for 4 duplicates
GEN_OUT_LINKS_SLR0_4_TO_7: for idx in 4 to 7 generate
    axiStreamOut(XLA_OUTPUT_MAP_C_SLR0(idx)) <= axiStreamOutIP3D1(idx - 4);
end generate;



end rtl;

