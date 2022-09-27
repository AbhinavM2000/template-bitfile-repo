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


signal sAxiStreamOutSLR0 :  AxiStreamMasterArray(0 to 11);
signal sAxiStreamOutSLR1 :  AxiStreamMasterArray(16 to 27);
signal sAxiStreamOutSLR2 :  AxiStreamMasterArray(32 to 35);

attribute dont_touch : string;
attribute dont_touch of sAxiStreamOutSLR0, sAxiStreamOutSLR1, sAxiStreamOutSLR2 : signal is "TRUE";

begin

  genOPWSLR0 : for i in 0 to 11 generate
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
          axiStreamOut => sAxiStreamOutSLR0(i),

          --LHC clock domain
          clkLHC     => clkLHC,
          bc0_clkLHC => bc0_clkLHC,

          delay => delay
          );
    end generate;
  end generate;
  
    genOPWSLR1 : for i in 16 to 27 generate
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
          axiStreamOut => sAxiStreamOutSLR1(i),

          --LHC clock domain
          clkLHC     => clkLHC,
          bc0_clkLHC => bc0_clkLHC,

          delay => delay
          );
    end generate;
  end generate;
  
  genOPWSLR2 : for i in 32 to 35 generate
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
          axiStreamOut => sAxiStreamOutSLR2(i),

          --LHC clock domain
          clkLHC     => clkLHC,
          bc0_clkLHC => bc0_clkLHC,

          delay => delay
          );
    end generate;
  end generate;
    
    
  AxiStreamOut(0 to 11) <= sAxiStreamOutSLR0(0 to 11);
  AxiStreamOut(16 to 27) <= sAxiStreamOutSLR1(16 to 27);
  AxiStreamOut(32 to 35) <= sAxiStreamOutSLR2(32 to 35);

end rtl;
