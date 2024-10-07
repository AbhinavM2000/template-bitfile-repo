library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;

entity IP2TopWrapper is
 generic (
    N_INPUT_STREAMS  : integer := 8;
    N_OUTPUT_STREAMS : integer := 5
    );
  port (
    -- Algo Control/Status Signals
    algoClk   : in  std_logic;
    algoRst   : in  std_logic;
    algoStart : in  std_logic;
    calibIP2 : IN Slv32Array (24 downto 0);


    algoDone  : out std_logic := '0';
    algoIdle  : out std_logic := '0';
    algoReady : out std_logic := '0';

    -- AXI-Stream In/Out Ports
    axiStreamIn  : in  AxiStreamMasterArray(0 TO N_INPUT_STREAMS-1);
    axiStreamOut : out AxiStreamMasterArray(0 TO N_OUTPUT_STREAMS-1)
    );
end IP2TopWrapper;

architecture Behavioral of IP2TopWrapper is

begin

    U_IP2AlgoWrapper : entity work.IP2AlgoWrapper
  generic map(
    N_INPUT_STREAMS  => N_INPUT_STREAMS,
    N_OUTPUT_STREAMS => N_OUTPUT_STREAMS
    )
  port map(
    -- Algo Control/Status Signals
    algoClk   => algoClk,
    algoRst   => algoRst,
    algoStart => algoStart,
    algoDone  => algoDone,
    algoIdle  => algoIdle,
    algoReady => algoReady,
    calibIP2 => calibIP2,
  
    -- AXI-Stream In/Out Ports
    axiStreamIn  => axiStreamIn,
    axiStreamOut => axiStreamOut
 );

end Behavioral;

