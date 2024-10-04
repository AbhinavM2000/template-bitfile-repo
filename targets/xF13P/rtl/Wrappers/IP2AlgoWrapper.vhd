library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;

entity IP2AlgoWrapper is
  generic (
    N_INPUT_STREAMS  : integer := 8;
    N_OUTPUT_STREAMS : integer := 5
    );
  port (
    -- Algo Control/Status Signals
    algoClk   : in  std_logic;
    algoRst   : in  std_logic;
    algoStart : in  std_logic;
    algoDone  : out std_logic := '0';
    algoIdle  : out std_logic := '0';
    algoReady : out std_logic := '0';

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

    -- AXI-Stream In/Out Ports
    axiStreamIn  : in  AxiStreamMasterArray(0 TO N_INPUT_STREAMS-1);
    axiStreamOut : out AxiStreamMasterArray(0 TO N_OUTPUT_STREAMS-1)
    );
end IP2AlgoWrapper;

architecture Behavioral of IP2AlgoWrapper is

  signal algoRstD1   : std_logic := '1'; 
  signal algoStartD1 : std_logic := '0'; 

  type t_cyc_9_arr is array(integer range <>) of integer range 0 to 8;
  type t_slv_576_arr is array(integer range <>) of std_logic_vector(575 downto 0);

  signal link_in  : t_slv_576_arr(0 TO N_INPUT_STREAMS-1);
  signal link_out : t_slv_576_arr(0 TO N_OUTPUT_STREAMS-1);

  signal link_in_reg  : t_slv_576_arr(0 TO N_INPUT_STREAMS-1);
  signal link_out_reg : t_slv_576_arr(0 TO N_OUTPUT_STREAMS-1);

  signal link_out_ap_vld         : std_logic_vector(0 TO N_OUTPUT_STREAMS-1) := (others => '0');
  signal link_out_ap_vld_latched : std_logic_vector(0 TO N_OUTPUT_STREAMS-1) := (others => '0');

  signal in_cyc  : t_cyc_9_arr(0 TO N_INPUT_STREAMS-1);
  signal out_cyc : t_cyc_9_arr(0 TO N_OUTPUT_STREAMS-1);

begin
  
  algoRstD1   <= algoRst   when rising_edge(algoClk);
  algoStartD1 <= algoStart when rising_edge(algoClk);

  gen_cyc_in : for idx in 0 TO N_INPUT_STREAMS-1 generate
    process(algoClk) is
    begin
      if rising_edge(algoClk) then
        
        if (axiStreamIn(idx).tValid = '0') then
          in_cyc(idx) <= 0;
        elsif (axiStreamIn(idx).tValid = '1') then
          in_cyc(idx) <= in_cyc(idx) + 1;
          if (in_cyc(idx) = 8) then
            in_cyc(idx) <= 0;
          end if;
        else
            in_cyc(idx) <= 0;
        end if;

        if (in_cyc(idx) = 0) then 
            link_in(idx)(63 downto 0)  <= axiStreamIn(idx).tdata(63 downto 0); 
        end if;

        if (in_cyc(idx) = 1) then 
            link_in(idx)(127 downto 64)  <= axiStreamIn(idx).tdata(63 downto 0); 
        end if;

        if (in_cyc(idx) = 2) then 
            link_in(idx)(191 downto 128)  <= axiStreamIn(idx).tdata(63 downto 0); 
        end if;

        if (in_cyc(idx) = 3) then 
            link_in(idx)(255 downto 192)  <= axiStreamIn(idx).tdata(63 downto 0); 
        end if;

        if (in_cyc(idx) = 4) then 
            link_in(idx)(319 downto 256)  <= axiStreamIn(idx).tdata(63 downto 0); 
        end if;

        if (in_cyc(idx) = 5) then 
            link_in(idx)(383 downto 320)  <= axiStreamIn(idx).tdata(63 downto 0); 
        end if;

        if (in_cyc(idx) = 6) then 
            link_in(idx)(447 downto 384)  <= axiStreamIn(idx).tdata(63 downto 0); 
        end if;

        if (in_cyc(idx) = 7) then 
            link_in(idx)(511 downto 448)  <= axiStreamIn(idx).tdata(63 downto 0); 
        end if;

        if (in_cyc(idx) = 8) then 
            link_in_reg(idx)(63 downto 0)    <= link_in(idx)(63 downto 0);
            link_in_reg(idx)(127 downto 64)  <= link_in(idx)(127 downto 64);
            link_in_reg(idx)(191 downto 128) <= link_in(idx)(191 downto 128);
            link_in_reg(idx)(255 downto 192) <= link_in(idx)(255 downto 192);
            link_in_reg(idx)(319 downto 256) <= link_in(idx)(319 downto 256);
            link_in_reg(idx)(383 downto 320) <= link_in(idx)(383 downto 320);
            link_in_reg(idx)(447 downto 384) <= link_in(idx)(447 downto 384);
            link_in_reg(idx)(511 downto 448) <= link_in(idx)(511 downto 448);
            link_in_reg(idx)(575 downto 512) <= axiStreamIn(idx).tdata(63 downto 0); 
        end if;

      end if;
    end process;
  end generate;

  gen_cyc_out : for idx in 0 TO N_OUTPUT_STREAMS-1 generate
    process(algoClk) is
    begin
      if rising_edge(algoClk) then

        if (link_out_ap_vld(idx) = '1') then
          link_out_reg(idx) <= link_out(idx);
        end if;

        if (algoRstD1 = '1') then
            link_out_ap_vld_latched(idx) <= '0';
        elsif (link_out_ap_vld(idx) = '1') then
            link_out_ap_vld_latched(idx) <= '1';
        end if;

        if (link_out_ap_vld_latched(idx) = '0') then
          out_cyc(idx)             <=  0;
          axiStreamOut(idx).tValid <= '0';
        else
          axiStreamOut(idx).tValid <= '1';
          out_cyc(idx)             <= out_cyc(idx) + 1;
          if (out_cyc(idx) = 8) then
            out_cyc(idx) <= 0;
          end if;
        end if;

        if (out_cyc(idx) = 0) then axiStreamOut(idx).tdata(63 downto 0) <= link_out_reg(idx)(63 downto 0); end if;
        if (out_cyc(idx) = 1) then axiStreamOut(idx).tdata(63 downto 0) <= link_out_reg(idx)(127 downto 64); end if;
        if (out_cyc(idx) = 2) then axiStreamOut(idx).tdata(63 downto 0) <= link_out_reg(idx)(191 downto 128); end if;
        if (out_cyc(idx) = 3) then axiStreamOut(idx).tdata(63 downto 0) <= link_out_reg(idx)(255 downto 192); end if;
        if (out_cyc(idx) = 4) then axiStreamOut(idx).tdata(63 downto 0) <= link_out_reg(idx)(319 downto 256); end if;
        if (out_cyc(idx) = 5) then axiStreamOut(idx).tdata(63 downto 0) <= link_out_reg(idx)(383 downto 320); end if;
        if (out_cyc(idx) = 6) then axiStreamOut(idx).tdata(63 downto 0) <= link_out_reg(idx)(447 downto 384); end if;
        if (out_cyc(idx) = 7) then axiStreamOut(idx).tdata(63 downto 0) <= link_out_reg(idx)(511 downto 448); end if;
        if (out_cyc(idx) = 8) then axiStreamOut(idx).tdata(63 downto 0) <= link_out_reg(idx)(575 downto 512); end if;

      end if;
    end process;
 end generate;

  i_IP2_algo_top : entity work.IP2_algo_top
    port map (
        ap_clk      => algoClk,
        ap_rst      => algoRstD1,
        ap_start    => algoStartD1,
        ap_done     => algoDone,
        ap_idle     => algoIdle,
        ap_ready    => algoReady,

        link_in_0_V  => link_in_reg(0),
        link_in_1_V  => link_in_reg(1),
        link_in_2_V  => link_in_reg(2),
        link_in_3_V  => link_in_reg(3),
        link_in_4_V  => link_in_reg(4),
        link_in_5_V  => link_in_reg(5),
        link_in_6_V  => link_in_reg(6),
        link_in_7_V  => link_in_reg(7),

        ss_fun0_V  => calib0,  -- 126
        ss_fun1_V  => calib1,  -- 125
        ss_fun2_V  => calib2,  -- 125
        ss_fun3_V  => calib3,  -- 124
        ss_fun4_V  => calib4,  -- 123
        ss_fun5_V  => calib5,  -- 123
        ss_fun6_V  => calib6,  -- 122
        ss_fun7_V  => calib7,  -- 122
        ss_fun8_V  => calib8,  -- 121
        ss_fun9_V  => calib9,  -- 121
        ss_fun10_V => calib10,  -- 121
        ss_fun11_V => calib12,  -- 121
        ss_fun12_V => calib13,  -- 121
        ss_fun13_V => calib13,  -- 120
        ss_fun14_V => calib14,  -- 120
        ss_fun15_V => calib15,  -- 120
        ss_fun16_V => calib16,  -- 120
        ss_fun17_V => calib17,  -- 120
        ss_fun18_V => calib18,  -- 120
        ss_fun19_V => calib19,  -- 120
        ss_fun20_V => calib20,  -- 120
        ss_fun21_V => calib21,  -- 120
        ss_fun22_V => calib22,  -- 120
        ss_fun23_V => calib23,  -- 120
        ss_fun24_V => calib24,  -- 120

        link_out_0_V  => link_out(0),
        link_out_1_V  => link_out(1),
        link_out_2_V  => link_out(2),
        link_out_3_V  => link_out(3),
        link_out_4_V  => link_out(4),
        
        link_out_0_V_ap_vld  => link_out_ap_vld(0),
        link_out_1_V_ap_vld  => link_out_ap_vld(1),
        link_out_2_V_ap_vld  => link_out_ap_vld(2),
        link_out_3_V_ap_vld  => link_out_ap_vld(3),
        link_out_4_V_ap_vld  => link_out_ap_vld(4)
);

end Behavioral;
