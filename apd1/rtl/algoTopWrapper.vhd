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

    -- AXI-Stream In/Out Ports
    axiStreamIn  : in  AxiStreamMasterArray(0 to N_INPUT_STREAMS-1);
    axiStreamOut : out AxiStreamMasterArray(0 to N_OUTPUT_STREAMS-1) := (others => AXI_STREAM_MASTER_INIT_C)
    );
end algoTopWrapper;

architecture rtl of algoTopWrapper is


begin

  genOPW : for i in 0 to N_OUTPUT_STREAMS-1 generate
    genEnabled : if (APX_CH_CFG_G(i).enabled(AXP_CH_ENABLE_PE_TX) = '1') generate
      U_OPWGen_Tx : entity apx_fs.OPWGen
        generic map(
          TM_INTERVAL     => APX_CH_CFG_G(i).TxProtocolCfg.CSPTMInterval,
          CLK_RATIO       => APX_CH_CFG_G(i).TxProtocolCfg.CSPClkRatio,
          FRAME_LENGTH    => APX_CH_CFG_G(i).TxProtocolCfg.CSPFrameLength,
          THROTTLE_VECTOR => APX_CH_CFG_G(i).TxProtocolCfg.CSPThrottleVector
          )
        port map(
          slow_ctl_rst => algoRst,

          -- AXI-stream/algo interface
          axisClk      => algoClk,
          axiStreamOut => axiStreamOut(i),

          --LHC clock domain
          clkLHC     => clkLHC,
          bc0_clkLHC => bc0_clkLHC,

          delay => x"0000"  --delay on LHC BC0 in AXI stream clock units to position the OPW pattern with respect to TCDS BC0
          );
    end generate;
  end generate;

end rtl;
