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
    N_INPUT_STREAMS  : integer := 100;
    N_OUTPUT_STREAMS : integer := 100
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

    delay : in slv(15 downto 0);

    -- AXI-Stream In/Out Ports
    axiStreamIn  : in  AxiStreamMasterArray(0 to N_INPUT_STREAMS-1);
    axiStreamOut : out AxiStreamMasterArray(0 to N_OUTPUT_STREAMS-1) := (others => AXI_STREAM_MASTER_INIT_C)
    );
end algoTopWrapper;

architecture rtl of algoTopWrapper is

  signal  axiStreamInReg  :   AxiStreamMasterArray(0 to N_INPUT_STREAMS-1);

  signal sAxiStreamOut : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS-1) := (others => AXI_STREAM_MASTER_INIT_C);

begin

axiStreamInReg <= axiStreamIn when rising_edge(algoClk);

  U_algoSlice1 : entity work.algoSlice1
    port map(
      axisClk        => algoClk,
      AxiStreamInGA  => axiStreamInReg(60 to 75),
      AxiStreamInGB  => axiStreamInReg(76 to 79),
      AxiStreamOutGA => sAxiStreamOut(24 to 27),
      AxiStreamOutGB => sAxiStreamOut(12 to 19)
      );

  U_algoSlice2 : entity work.algoSlice2
    port map(
      axisClk                 => algoClk,
      AxiStreamInGA(0 to 11)  => axiStreamInReg(0 to 11),
      AxiStreamInGA(12 to 15) => axiStreamInReg(48 to 51),
      AxiStreamInGB           => axiStreamInReg(52 to 59),
      AxiStreamOutGA          => sAxiStreamOut(52 to 59),
      AxiStreamOutGB          => sAxiStreamOut(0 to 7)
      );

  axiStreamOut <= sAxiStreamOut when rising_edge(algoClk);

end rtl;
