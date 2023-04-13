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

  signal OPWrst, OPWrst2  : slv(0 to N_INPUT_STREAMS-1);

attribute dont_touch : string;
attribute dont_touch of OPWrst, OPWrst2 : signal is "TRUE";


begin

  genOPWrst : for i in 0 to N_INPUT_STREAMS-1 generate
    process(algoClk) is
    begin
      if rising_edge(algoClk) then
        OPWrst(i)  <= algoRst;
        OPWrst2(i) <= OPWrst(i);
      end if;
    end process;
  end generate;

  genOPW : for i in 0 to N_INPUT_STREAMS-1 generate
    genEnabled : if (APX_CH_CFG_G(i).enabled(AXP_CH_ENABLE_PE_TX) = '1') generate
      U_OPWGen_Tx : entity apx_fs.OPWGen
        generic map(
          FRAME_INTERVAL      => APX_CH_CFG_G(i).TxProtocolCfg.CSPFrameInterval,
          FRAME_LENGTH    => APX_CH_CFG_G(i).TxProtocolCfg.CSPFrameLength,
          THROTTLE_VECTOR => APX_CH_CFG_G(i).TxProtocolCfg.CSPThrottleVector
          )
        port map(
          slow_ctl_rst => OPWrst2(i),

          -- AXI-stream/algo interface
          axisClk      => algoClk,
          axiStreamOut => AxiStreamOut(i),

          --LHC clock domain
          clkLHC     => clkLHC,
          bc0_clkLHC => bc0_clkLHC,

          delay => delay
          );
    end generate;
  end generate;

end rtl;
