library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiLitePkg.all;

library apx_fs;
use apx_fs.PrjSpecPkg.all;

entity apxTestIp is
  generic (
    TPD_G                   : time             := 1 ns;
    SECTOR_NO : integer := 0;

    AXI_CLK_FREQ_G          : real             := 100.0E+6;  -- Reference Clock frequency, units of Hz
    BUILD_INFO_G            : BuildInfoType;
    XIL_DEVICE_G            : string           := "ULTRASCALE";
    AXIL_BASE_ADDR_G        : slv(31 downto 0) := x"00000000"
    );
  port (
    -- AXI-Lite Bus
    axiClk         : in  sl                     := '0';
    axiRst         : in  sl                     := '0';
    axiReadMaster  : in  AxiLiteReadMasterType  := AXI_LITE_READ_MASTER_INIT_C;
    axiReadSlave   : out AxiLiteReadSlaveType;
    axiWriteMaster : in  AxiLiteWriteMasterType := AXI_LITE_WRITE_MASTER_INIT_C;
    axiWriteSlave  : out AxiLiteWriteSlaveType);
end apxTestIp;

architecture rtl of apxTestIp is

component AxiLiteRegs 
   generic (
      TPD_G            : time                  := 1 ns;
      NUM_WRITE_REG_G  : integer range 1 to 32 := 1;
      INI_WRITE_REG_G  : Slv32Array            := (0 => x"0000_0000");
      NUM_READ_REG_G   : integer range 1 to 32 := 1);
   port (
      -- AXI-Lite Bus
      axiClk         : in  sl;
      axiClkRst      : in  sl;
      axiReadMaster  : in  AxiLiteReadMasterType;
      axiReadSlave   : out AxiLiteReadSlaveType;
      axiWriteMaster : in  AxiLiteWriteMasterType;
      axiWriteSlave  : out AxiLiteWriteSlaveType;
      -- User Read/Write registers
      writeRegister  : out Slv32Array(NUM_WRITE_REG_G-1 downto 0);
      readRegister   : in  Slv32Array(NUM_READ_REG_G-1 downto 0) := (others => (others => '0')));
end component AxiLiteRegs;

  constant NUM_AXIL_MASTERS_C : integer := 3;

  constant REG_FILE_C : natural := 0;
  constant APX_RAM0_C   : natural := 1;
  constant APX_RAM1_C     : natural := 2;

  constant REG_FILE_BASE_ADDR_C     : slv(31 downto 0) := slv(unsigned(AXIL_BASE_ADDR_G) + x"0_0000");
  constant APX_RAM0_BASE_ADDR_C     : slv(31 downto 0) := slv(unsigned(AXIL_BASE_ADDR_G) + x"1_0000");
  constant APX_RAM1_BASE_ADDR_C   : slv(31 downto 0) := slv(unsigned(AXIL_BASE_ADDR_G) + x"4_0000");

  constant XBAR_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXIL_MASTERS_C-1 downto 0) := (
    REG_FILE_C => (
      baseAddr      => REG_FILE_BASE_ADDR_C,
      addrBits      => 16,
      connectivity  => x"FFFF"),
    APX_RAM0_C => (
      baseAddr      => APX_RAM0_BASE_ADDR_C,
      addrBits      => 16,
      connectivity  => x"FFFF"),
    APX_RAM1_C     => (
      baseAddr      => APX_RAM1_BASE_ADDR_C,
      addrBits      => 16,
      connectivity  => x"FFFF")
    );

  signal locAxiWriteMasters : AxiLiteWriteMasterArray(NUM_AXIL_MASTERS_C-1 downto 0) := (others => AXI_LITE_WRITE_MASTER_INIT_C);
  signal locAxiWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0)  := (others => AXI_LITE_WRITE_SLAVE_EMPTY_DECERR_C);
  signal locAxiReadMasters  : AxiLiteReadMasterArray(NUM_AXIL_MASTERS_C-1 downto 0)  := (others => AXI_LITE_READ_MASTER_INIT_C);
  signal locAxiReadSlaves   : AxiLiteReadSlaveArray(NUM_AXIL_MASTERS_C-1 downto 0)   := (others => AXI_LITE_READ_SLAVE_EMPTY_DECERR_C);


constant NUM_WRITE_REG_G : integer := 1;
constant NUM_READ_REG_G : integer := 1;


 signal    writeRegister  :  Slv32Array(NUM_WRITE_REG_G-1 downto 0);
  signal     readRegister   :   Slv32Array(NUM_READ_REG_G-1 downto 0) := (others => (others => '0'));
  
begin

readRegister(0) <= std_logic_vector(to_unsigned(SECTOR_NO,32));

  --------------------------
  -- AXI-Lite: Crossbar Core
  --------------------------
  U_XBAR : entity surf.AxiLiteCrossbar
    generic map (
      TPD_G              => TPD_G,
      NUM_SLAVE_SLOTS_G  => 1,
      NUM_MASTER_SLOTS_G => NUM_AXIL_MASTERS_C,
      MASTERS_CONFIG_G   => XBAR_CONFIG_C)
    port map (
      axiClk              => axiClk,
      axiClkRst           => axiRst,
      sAxiWriteMasters(0) => axiWriteMaster,
      sAxiWriteSlaves(0)  => axiWriteSlave,
      sAxiReadMasters(0)  => axiReadMaster,
      sAxiReadSlaves(0)   => axiReadSlave,
      mAxiWriteMasters    => locAxiWriteMasters,
      mAxiWriteSlaves     => locAxiWriteSlaves,
      mAxiReadMasters     => locAxiReadMasters,
      mAxiReadSlaves      => locAxiReadSlaves);


U_ApxRegs : entity surf.AxiLiteRegs 
generic map(
NUM_READ_REG_G => NUM_READ_REG_G,
NUM_WRITE_REG_G => NUM_WRITE_REG_G

)
   port map(
        axiReadMaster  => locAxiReadMasters(REG_FILE_C),
        axiReadSlave   => locAxiReadSlaves(REG_FILE_C),
        axiWriteMaster => locAxiWriteMasters(REG_FILE_C),
        axiWriteSlave  => locAxiWriteSlaves(REG_FILE_C),
        axiClk         => axiClk,
        axiClkRst         => axiRst,
      writeRegister  => writeRegister,
      readRegister   => readRegister);


    U_ApxRAM0 : entity surf.AxiDualPortRam
      generic map(
        SYNTH_MODE_G        => "xpm",
        MEMORY_INIT_FILE_G  => "apx_fs_info.mem",  -- Used for MEMORY_TYPE_G="XPM only
        MEMORY_INIT_PARAM_G => "",      -- Used for MEMORY_TYPE_G="XPM only    
        COMMON_CLK_G        => true,
        ADDR_WIDTH_G        => 12,
        DATA_WIDTH_G        => 32)
      port map(
        axiReadMaster  => locAxiReadMasters(APX_RAM0_C),
        axiReadSlave   => locAxiReadSlaves(APX_RAM0_C),
        axiWriteMaster => locAxiWriteMasters(APX_RAM0_C),
        axiWriteSlave  => locAxiWriteSlaves(APX_RAM0_C),
        axiClk         => axiClk,
        axiRst         => axiRst);



    U_ApxRAM1 : entity surf.AxiDualPortRam
      generic map(
        SYNTH_MODE_G        => "xpm",
        MEMORY_INIT_FILE_G  => "apx_fs_info.mem",  -- Used for MEMORY_TYPE_G="XPM only
        MEMORY_INIT_PARAM_G => "",      -- Used for MEMORY_TYPE_G="XPM only    
        COMMON_CLK_G        => true,
        ADDR_WIDTH_G        => 13,
        DATA_WIDTH_G        => 32)
      port map(
        axiReadMaster  => locAxiReadMasters(APX_RAM1_C),
        axiReadSlave   => locAxiReadSlaves(APX_RAM1_C),
        axiWriteMaster => locAxiWriteMasters(APX_RAM1_C),
        axiWriteSlave  => locAxiWriteSlaves(APX_RAM1_C),
        axiClk         => axiClk,
        axiRst         => axiRst);

end architecture rtl;
