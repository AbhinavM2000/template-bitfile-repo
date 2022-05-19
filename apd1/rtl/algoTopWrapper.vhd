library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;

entity algoTopWrapper is
  generic (
  PASS_THROUGH_G : boolean := true;
  N_ALGO_AUX_CLKS_G: integer := 1;
    N_INPUT_STREAMS_G  : integer := 24;
    N_OUTPUT_STREAMS_G : integer := 24
    );
  port (
    -- Algo Control/Status Signals
    algoClk   : in  sl;
    algoClkDiv2   : in  sl:='0';
    algoClkAux : in slv(N_ALGO_AUX_CLKS_G-1 downto 0) := (others => '0');
    algoRst   : in  sl;
    algoStart : in  sl;
    algoDone  : out sl := '0';
    algoIdle  : out sl := '0';
    algoReady : out sl := '0';

    -- AXI-Stream In/Out Ports
    axiStreamIn  : in  AxiStreamMasterArray(0 to N_INPUT_STREAMS_G-1);
    axiStreamOut : out AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_G-1)
    );
end algoTopWrapper;

architecture rtl of algoTopWrapper is

component algoTop 
  generic (
  PASS_THROUGH_G : boolean := true;
  N_ALGO_AUX_CLKS_G: integer := 1;
    N_INPUT_STREAMS_G  : integer := 24;
    N_OUTPUT_STREAMS_G : integer := 24
    );
  port (
    -- Algo Control/Status Signals
    algoClk   : in  sl;
    algoClkDiv2   : in  sl:='0';
    algoClkAux : in slv(N_ALGO_AUX_CLKS_G-1 downto 0) := (others => '0');
    algoRst   : in  sl;
    algoStart : in  sl;
    algoDone  : out sl := '0';
    algoIdle  : out sl := '0';
    algoReady : out sl := '0';

    -- AXI-Stream In/Out Ports
    axiStreamIn  : in  AxiStreamMasterArray(0 to N_INPUT_STREAMS_G-1);
    axiStreamOut : out AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_G-1)
    );
end component algoTop;

begin

gen_passThrough: if PASS_THROUGH_G = true generate
  process(algoClk) is
  begin
    if rising_edge(algoClk) then
      axiStreamOut <= axiStreamIn;
    end if;
  end process;
  end generate;

gen_algo: if PASS_THROUGH_G = false generate
U_algoTop : algoTop 
  generic map(
  PASS_THROUGH_G => PASS_THROUGH_G,
  N_ALGO_AUX_CLKS_G => N_ALGO_AUX_CLKS_G,
    N_INPUT_STREAMS_G  => N_INPUT_STREAMS_G,
    N_OUTPUT_STREAMS_G=>N_OUTPUT_STREAMS_G
    )
  port map(
    algoClk   => algoClk,
    algoClkDiv2=>algoClkDiv2,
    algoClkAux => algoClkAux,
    algoRst   => algoRst,
    algoStart =>algoStart,
    algoDone  =>algoDone,
    algoIdle  =>algoIdle,
    algoReady =>algoReady,
    axiStreamIn =>axiStreamIn,
    axiStreamOut =>axiStreamOut
    );

  end generate;

end rtl;
