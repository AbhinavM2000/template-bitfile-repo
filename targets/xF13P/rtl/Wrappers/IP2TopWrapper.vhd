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
    calib0 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib1 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib2 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib3 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib4 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib5 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib6 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib7 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib8 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib9 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib10 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib11 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib12 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib13 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib14 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib15 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib16 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib17 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib18 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib19 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib20 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib21 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib22 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib23 : IN STD_LOGIC_VECTOR (15 downto 0);
    calib24 : IN STD_LOGIC_VECTOR (15 downto 0);

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
    calib0 => calib0,
    calib1 => calib1,
    calib2 => calib2,
    calib3 => calib3,
    calib4 => calib4,
    calib5 => calib5,
    calib6 => calib6,
    calib7 => calib7,
    calib8 => calib8,
    calib9 => calib9,
    calib10 => calib10,
    calib11 => calib11,
    calib12 => calib12,
    calib13 => calib13,
    calib14 => calib14,
    calib15 => calib15,
    calib16 => calib16,
    calib17 => calib17,
    calib18 => calib18,
    calib19 => calib19,
    calib20 => calib20,
    calib21 => calib21,
    calib22 => calib22,
    calib23 => calib23,
    calib24 => calib24,
    -- AXI-Stream In/Out Ports
    axiStreamIn  => axiStreamIn,
    axiStreamOut => axiStreamOut
 );

end Behavioral;

