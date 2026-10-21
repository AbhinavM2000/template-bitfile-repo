library IEEE;
use IEEE.STD_LOGIC_1164.all;

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

    -- AXI-Lite Bus
    axiClk         : in  sl;
    axiClkRst      : in  sl;
    axiReadMaster  : in  AxiLiteReadMasterType;
    axiReadSlave   : out AxiLiteReadSlaveType;
    axiWriteMaster : in  AxiLiteWriteMasterType;
    axiWriteSlave  : out AxiLiteWriteSlaveType;


    -- AXI-Stream In/Out Ports
    axiStreamIn  : in  AxiStreamMasterArray(0 to N_INPUT_STREAMS-1);
    axiStreamOut : out AxiStreamMasterArray(0 to N_OUTPUT_STREAMS-1)
    );
end algoTopWrapper;

architecture rtl of algoTopWrapper is

  constant N_INPUT_STREAMS_IP3  : natural := 32;
  constant N_OUTPUT_STREAMS_IP3 : natural := 1;

  signal algoRstD_SLR3    : sl := '1';
  signal algoRstD1_SLR3   : sl := '1';
  signal algoStartD_SLR3  : sl := '0';
  signal algoStartD1_SLR3 : sl := '0';

  attribute dont_touch : string;
  attribute dont_touch of algoRstD_SLR3, algoRstD1_SLR3,
    algoStartD_SLR3, algoStartD1_SLR3 : signal is "yes";

  attribute shreg_extract : string;
  attribute shreg_extract of algoRstD_SLR3, algoRstD1_SLR3,
    algoStartD_SLR3, algoStartD1_SLR3 : signal is "no";

  signal axiStreamInSLR3   : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP3-1);
  signal axiStreamInSLR3D0 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP3-1);
  signal axiStreamInSLR3D1 : AxiStreamMasterArray(0 to N_INPUT_STREAMS_IP3-1);

  signal axiStreamOutIP3   : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP3-1);
  signal axiStreamOutIP3D0 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP3-1);
  signal axiStreamOutIP3D1 : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS_IP3-1);
  signal axiStreamOutD0    : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS-1);
  signal axiStreamOutD1    : AxiStreamMasterArray(0 to N_OUTPUT_STREAMS-1);

  constant XLA_INPUT_MAP_C_SLR3 : IntegerArray(0 to N_INPUT_STREAMS_IP3-1) := (
    45,
    46, 
    47,
    48, 
    49, 
    50,
    51,
    52, 
    53, 
    54,
    55, 
    56, 
    57, 
    58,
    59,
    123,
    122, 
    121, 
    120,
    119,
    118,
    117,
    116, 
    115,
    114, 
    113,
    112,
    111,
    110,
    109,
    108,
    107
  );

begin


  GEN_IN_LINKS : for i in XLA_INPUT_MAP_C_SLR3'range generate
    axiStreamInSLR3(i) <= axiStreamIn(XLA_INPUT_MAP_C_SLR3(i));
  end generate;


  axiStreamInSLR3D0 <= axiStreamInSLR3   when rising_edge(algoClk);
  axiStreamInSLR3D1 <= axiStreamInSLR3D0 when rising_edge(algoClk);

  algoRstD_SLR3    <= algoRst        when rising_edge(algoClk);
  algoRstD1_SLR3   <= algoRstD_SLR3  when rising_edge(algoClk);
  algoStartD_SLR3  <= algoStart        when rising_edge(algoClk);
  algoStartD1_SLR3 <= algoStartD_SLR3  when rising_edge(algoClk);

  ALGO_IP3_SLR3 : entity work.IP3TopWrapper
    generic map (
      N_INPUT_STREAMS  => N_INPUT_STREAMS_IP3,
      N_OUTPUT_STREAMS => N_OUTPUT_STREAMS_IP3
    )
    port map (
      algoClk      => algoClk,
      algoRst      => algoRstD1_SLR3,
      algoStart    => algoStartD1_SLR3,
      algoDone     => algoDone,
      algoIdle     => algoIdle,
      algoReady    => algoReady,
      axiStreamIn  => axiStreamInSLR3D1,
      axiStreamOut => axiStreamOutIP3
    );


  axiStreamOutIP3D0 <= axiStreamOutIP3   when rising_edge(algoClk);
  axiStreamOutIP3D1 <= axiStreamOutIP3D0 when rising_edge(algoClk);


  axiStreamOutD0 <= (
    29     => axiStreamOutIP3D1(0),
    others => AXI_STREAM_MASTER_INIT_C
  );

  axiStreamOutD1 <= axiStreamOutD0 when rising_edge(algoClk);
  axiStreamOut   <= axiStreamOutD1;

end rtl;
