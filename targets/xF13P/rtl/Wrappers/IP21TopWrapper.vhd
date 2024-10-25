library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;

entity IP21TopWrapper is
 generic (
    N_INPUT_STREAMS  : integer := 4;
    N_OUTPUT_STREAMS : integer := 4
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
end IP21TopWrapper;

architecture Behavioral of IP21TopWrapper is

begin

    U_IP21AlgoWrapper : entity work.IP21AlgoWrapper
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

