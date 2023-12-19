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

  constant N_INPUT_STREAMS_ALGO  : integer := 6;
  constant N_OUTPUT_STREAMS_ALGO : integer := 6;

  signal axiStreamInXLA  : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO-1);
  signal axiStreamOutXLA : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);

  signal axiStreamInD0  : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO-1);
  signal axiStreamInD1  : AxiStreamMasterArray(0 to N_INPUT_STREAMS_ALGO-1);

  signal axiStreamOutD0  : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);
  signal axiStreamOutD1  : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_ALGO-1);

  signal algoRstD  : sl := '1';
  signal algoRstD1 : sl := '1';

  signal algoStartD  : sl := '0';
  signal algoStartD1 : sl := '0';

  constant XLA_INPUT_MAP_C : IntegerArray(0 to N_INPUT_STREAMS_ALGO-1) := (
    --sector 0
    0  => 0,
    1  => 1,
    2  => 2,
    3  => 3,
    4  => 4,
    5  => 5
    );

  constant XLA_OUTPUT_MAP_C : IntegerArray(0 to N_OUTPUT_STREAMS_ALGO-1) := (
    --sector 4
    0  => 60,
    1  => 61,
    2  => 62,
    3  => 63,
    4  => 64,
    5  => 65
    );

begin

  axiStreamInD1  <= axiStreamInD0 when rising_edge(algoClk);
  axiStreamInXLA <= axiStreamInD1  when rising_edge(algoClk);

  algoRstD  <= algoRst  when rising_edge(algoClk);
  algoRstD1 <= algoRstD when rising_edge(algoClk);

  algoStartD  <= algoStart  when rising_edge(algoClk);
  algoStartD1 <= algoStartD when rising_edge(algoClk);

  gen_XlaInputMapping : for i in 0 to N_INPUT_STREAMS_ALGO-1 generate
    axiStreamInD0(i) <= axiStreamIn(XLA_INPUT_MAP_C(i));
  end generate;

  gen_XlaOutputMapping : for i in 0 to N_OUTPUT_STREAMS_ALGO-1 generate
    axiStreamOut(XLA_OUTPUT_MAP_C(i)) <= axiStreamOutD1(i);
  end generate;

  axiStreamOutD0 <= axiStreamOutXLA when rising_edge(algoClk);
  axiStreamOutD1 <= axiStreamOutD0 when rising_edge(algoClk);

  U_ALGO_SLR1 : entity work.StarterAlgoTopWrapper
    generic map(
      N_INPUT_STREAMS  => N_INPUT_STREAMS_ALGO,
      N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_ALGO
      )
    port map (
      -- Algo Control/Status Signals
      algoClk   => algoClk,
      algoRst   => algoRstD1,
      algoStart => algoStartD1,
      algoDone  => open,
      algoIdle  => open,
      algoReady => open,

      axiStreamIn  => axiStreamInXLA,
      axiStreamOut => axiStreamOutXLA
      );

end rtl;
