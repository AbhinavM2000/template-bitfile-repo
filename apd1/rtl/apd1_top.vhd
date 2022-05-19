library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;

use work.i2cPkg.all;

use work.PrjSpecPkg.all;

library UNISIM;
use UNISIM.vcomponents.all;

entity apd1_top is
  generic (
    AURORA_LANES : integer := 2;
    TPD_G        : time    := 1 ns;
    BUILD_INFO_G : BuildInfoType;
    XIL_DEVICE_G : string  := "ULTRASCALE"
    );
  port (
    clk_300_clk_n : in std_logic;
    clk_300_clk_p : in std_logic;

    I2C_C2C_scl_io : inout std_logic;
    I2C_C2C_sda_io : inout std_logic;

    gt_c2c_rx_rxn : in  slv (0 to AURORA_LANES-1);
    gt_c2c_rx_rxp : in  slv (0 to AURORA_LANES-1);
    gt_c2c_tx_txn : out slv (0 to AURORA_LANES-1);
    gt_c2c_tx_txp : out slv (0 to AURORA_LANES-1);

    refclk_c2c_clk_n : in std_logic;
    refclk_c2c_clk_p : in std_logic
    );
end apd1_top;

architecture rtl of apd1_top is


  signal clk_10  : sl;
  signal clk_40  : sl;
  signal clk_50  : sl;
  signal clk_80  : sl;
  signal clk_100 : sl;

  signal axi_lite_clk    : std_logic;
  signal axi_lite_resetn : std_logic_vector (0 to 0);
  signal axi_lite_reset  : std_logic;

  constant AXI_CLK_FREQUENCY_G : real := 50.00E+6;

  constant NUM_AXI_MASTERS_C : natural := 2;

  constant APX_INFO_INDEX_C        : natural := 0;
  constant APX_SECTOR_CTRL_INDEX_C : natural := 1;


  constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := (
    APX_INFO_INDEX_C        => (
      baseAddr              => APX_INFO_BASE_ADDR_C,
      addrBits              => 18,
      connectivity          => x"FFFF"),
    APX_SECTOR_CTRL_INDEX_C => (
      baseAddr              => APX_SECTOR_CTRL_BASE_ADDR_C,
      addrBits              => 23,
      connectivity          => x"FFFF"));

  signal mAxilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
  signal mAxilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_SLAVE_EMPTY_DECERR_C);
  signal mAxilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
  signal mAxilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_SLAVE_EMPTY_DECERR_C);

  signal mAxilWriteMaster : AxiLiteWriteMasterType;
  signal mAxilWriteSlave  : AxiLiteWriteSlaveType;
  signal mAxilReadMaster  : AxiLiteReadMasterType;
  signal mAxilReadSlave   : AxiLiteReadSlaveType;


 signal   secAxiRst :  slv(SECTOR_CNT_C-1 downto 0);

  signal secAxiWriteMasters : AxiLiteWriteMasterArray(SECTOR_CNT_C-1 downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
  signal secAxiWriteSlaves  : AxiLiteWriteSlaveArray(SECTOR_CNT_C-1 downto 0)  := (others => AXI_LITE_WRITE_SLAVE_EMPTY_DECERR_C);
  signal secAxiReadMasters  : AxiLiteReadMasterArray(SECTOR_CNT_C-1 downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
  signal secAxiReadSlaves   : AxiLiteReadSlaveArray(SECTOR_CNT_C-1 downto 0)   := (others => AXI_LITE_READ_SLAVE_EMPTY_DECERR_C);


    constant APX_SECTOR_OFFSETS_C : Slv32Array(0 to 5) :=      ( SECTOR_0_BASE_ADDR_C,
    SECTOR_1_BASE_ADDR_C,
    SECTOR_2_BASE_ADDR_C,
    SECTOR_3_BASE_ADDR_C,
    SECTOR_4_BASE_ADDR_C,
    SECTOR_5_BASE_ADDR_C); 
                                              

begin

  U_axiInfra : entity work.axiInfra
    generic map (
      I2C_C2C_PHY_ADDR_G => 85,
      N_AURORA_LANES     => 2,
      OSC_FREQ           => 300,
      C2C_MGT_TYPE       => "GTY",
      LINE_RATE_MHZ      => 10312
      )
    port map(
      clk10            => clk_10,
      clk100           => clk_100,
      clk40            => clk_40,
      clk50            => clk_50,
      clk80            => clk_80,
      refclk_c2c_clk_n => refclk_c2c_clk_n,
      refclk_c2c_clk_p => refclk_c2c_clk_p,
      clk_osc_in_n     => clk_300_clk_n,
      clk_osc_in_p     => clk_300_clk_p,
      gt_c2c_rx_rxn    => gt_c2c_rx_rxn,
      gt_c2c_rx_rxp    => gt_c2c_rx_rxp,
      gt_c2c_tx_txn    => gt_c2c_tx_txn,
      gt_c2c_tx_txp    => gt_c2c_tx_txp,

      I2C_C2C_scl_io => I2C_C2C_scl_io,
      I2C_C2C_sda_io => I2C_C2C_sda_io,

      mAxilClk         => axi_lite_clk,
      mAxilRst         => axi_lite_reset,
      mAxilWriteMaster => mAxilWriteMaster,
      mAxilWriteSlave  => mAxilWriteSlave,
      mAxilReadMaster  => mAxilReadMaster,
      mAxilReadSlave   => mAxilReadSlave
      );

---------------------------
  -- AXI-Lite Crossbar Module
  ---------------------------         
  U_XBAR : entity work.AxiLiteCrossbar
    generic map (
      TPD_G              => TPD_G,
      NUM_SLAVE_SLOTS_G  => 1,
      NUM_MASTER_SLOTS_G => NUM_AXI_MASTERS_C,
      MASTERS_CONFIG_G   => AXI_CONFIG_C)
    port map (
      sAxiWriteMasters(0) => mAxilWriteMaster,
      sAxiWriteSlaves(0)  => mAxilWriteSlave,
      sAxiReadMasters(0)  => mAxilReadMaster,
      sAxiReadSlaves(0)   => mAxilReadSlave,
      mAxiWriteMasters    => mAxilWriteMasters,
      mAxiWriteSlaves     => mAxilWriteSlaves,
      mAxiReadMasters     => mAxilReadMasters,
      mAxiReadSlaves      => mAxilReadSlaves,
      axiClk              => axi_lite_clk,
      axiClkRst           => axi_lite_reset);

  U_APxInfo : entity work.apxInfo
    generic map(
      AXI_CLK_FREQ_G          => AXI_CLK_FREQUENCY_G,
      INCLUDE_VERSION_CORE    => true,
      INCLUDE_SYSMON_CORE     => false,
      INCLUDE_APX_FS_INFO_ROM => true,
      INCLUDE_ALGO_INFO_ROM   => false,
      BUILD_INFO_G            => BUILD_INFO_G,
      XIL_DEVICE_G            => "ULTRASCALE",
      AXIL_BASE_ADDR_G        => APX_INFO_BASE_ADDR_C
      )
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => mAxilReadMasters(APX_INFO_INDEX_C),
      axiReadSlave   => mAxilReadSlaves(APX_INFO_INDEX_C),
      axiWriteMaster => mAxilWriteMasters(APX_INFO_INDEX_C),
      axiWriteSlave  => mAxilWriteSlaves(APX_INFO_INDEX_C),
      axiClk         => axi_lite_clk,
      axiRst         => axi_lite_reset);

U_ApxSectorChassisWrapper : entity work.ApxFsSectorChassisWrapper
  generic map(
    SECTOR_CNT_G => SECTOR_CNT_C,
    CHASSIS_TYPE_G => CHASSIS_TYPE_C
    )
  port map(
  
        axiClk         => axi_lite_clk,
      axiRstIn         => axi_lite_reset,
      
      sAxiReadMaster  => mAxilReadMasters(APX_SECTOR_CTRL_INDEX_C),
      sAxiReadSlave   => mAxilReadSlaves(APX_SECTOR_CTRL_INDEX_C),
      sAxiWriteMaster => mAxilWriteMasters(APX_SECTOR_CTRL_INDEX_C),
      sAxiWriteSlave  => mAxilWriteSlaves(APX_SECTOR_CTRL_INDEX_C),

axiRstOut => secAxiRst,
    mAxiWriteMasters => secAxiWriteMasters,
    mAxiWriteSlaves  => secAxiWriteSlaves,
    mAxiReadMasters  => secAxiReadMasters,
    mAxiReadSlaves  => secAxiReadSlaves
    );
    

  gen_sector : for i in 0 to SECTOR_CNT_C-1 generate 
      U_APxAxiTestIp : entity work.apxTestIp
    generic map(
      AXI_CLK_FREQ_G   => AXI_CLK_FREQUENCY_G,
      SECTOR_NO => i,
      BUILD_INFO_G     => BUILD_INFO_G,
      XIL_DEVICE_G     => "ULTRASCALE",
      AXIL_BASE_ADDR_G => APX_SECTOR_OFFSETS_C(i)
      )
    port map(
      -- AXI-Lite Bus
      axiReadMaster  => secAxiReadMasters(i),
      axiReadSlave   => secAxiReadSlaves(i),
      axiWriteMaster => secAxiWriteMasters(i),
      axiWriteSlave  => secAxiWriteSlaves(i),
      axiClk         => axi_lite_clk,
      axiRst         => secAxiRst(i));
end generate;  

end architecture;
