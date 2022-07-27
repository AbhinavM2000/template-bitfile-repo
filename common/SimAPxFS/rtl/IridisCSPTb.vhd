library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library surf;
--use surf.AxiLitePkg.all;
use surf.AxiStreamPkg.all;
use surf.StdRtlPkg.all;
use surf.TextUtilPkg.all;

-- Aldec 
--library aldec;
--use aldec.signal_agent_pkg.all;
library apx_fs;

use apx_fs.IridisCSPPkg.all;
use apx_fs.CSPRulesPkg.all;
-- TCDS Library
use work.tcds2_bx_and_orbit_pkg.all;

--  CSP simulation Pakage 
use work.CSPSimulationPkg.all; 
use work.CSPSimCtrlPkg.all; 
use work.CSPSimTypePkg.all;

entity IridisCSPTb is
end IridisCSPTb;


architecture Behavioral of IridisCSPTb is

-- AXI Stream -- 
   constant CLK_PERIOD_C  : time              := 4 ns;
   constant TPD_C         : time              := CLK_PERIOD_C/4;
   constant PIPE_STAGES_C : natural           := 1;
   constant AXI_STREAM_ALGO_TDATA_C: natural        := 64;
   --constant MAX_CNT_C     : slv(AXI_STREAM_ALGO_TDATA_C-1 downto 0) := resize(x"000000000000000019999997E241C000",AXI_STREAM_ALGO_TDATA_C);
   constant MAX_CNT_C     : slv(AXI_STREAM_ALGO_TDATA_C-1 downto 0) := resize(x"0000FFFF",AXI_STREAM_ALGO_TDATA_C);
   constant PRBS_TAPS_C   : NaturalArray      := (0 => 31, 1 => 6, 2 => 2, 3 => 1);
   constant FS_TO_LHC_CLK_FACTOR_C : natural := 9; 
   constant NUM_FS_CLOCKS_C        : natural := 3;
------------------------------------------------------------
  constant ClkMgrCfg : tClkMgrCfgArr(1 to 1) := (
    1   => (CLKFBOUT_MULT_F => 3.0, CLKOUT0_DIVIDE_F => 3.375, CLKOUT1_DIVIDE => 27, CLKOUT2_DIVIDE => 3 ));

 type TxStateType is ( 
    START_S, 
    IDLES_S,
    FFO_S,
    RUN_S, 
    NEW_FRAME_S); 
    

   type RegType is record
      passed      : sl;
      failed      : sl;
      wrPbrs      : slv(31 downto 0);
      wrSof       : sl;
      wrEoF       : sl;
      wrPkt       : slv(AXI_STREAM_ALGO_TDATA_C-1 downto 0);
      wrCnt       : slv(AXI_STREAM_ALGO_TDATA_C-1 downto 0);
      wrBxCnt     : integer range 0 to 200;
      wrFFO       : sl;
      FFOWr       : sl;
      TxState     : TxStateType;
      wrFrameCnt  : integer;
	  wrDataGenEn : sl;
	  --
	  wordCnt      : integer range 0 to 200;
	  frameCnt     : integer;
      wrIdles      : sl; 
  end record RegType;
   
  
  
  constant REG_INIT_C : RegType := (
      passed      => '0',
      failed      => '0',
      wrPbrs      => x"AE64B770",
      wrSof       => '0',
      wrEof       => '0',
      wrPkt       => (others => '0'),
      wrCnt       => (others => '0'),
      wrBxCnt      => 0,
      wrFFO       => '0',
      FFOWr       => '0',
      TxState     => START_S, 
      wrFrameCnt  => 0,
	  wrDataGenEn => '0',
	  -- 
	  wordCnt     => 0,
	  frameCnt    => 0,
    wrIdles     => '0');
   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

   signal AxisTxMaster : AxiStreamMasterType := AXI_STREAM_MASTER_INIT_C;
   signal AxisRxMaster : AxiStreamMasterType := AXI_STREAM_MASTER_INIT_C;


--  SideBand
   signal AxisDataSideBand : AxiStreamMasterType := AXI_STREAM_MASTER_INIT_C;
   signal AxisTxSideBand: AxiStreamMasterType := AXI_STREAM_MASTER_INIT_C;

   signal  SideBandMonitor : tAxiStreamMonitor; 

   signal RstAux : sl := '0';
   signal rst    : sl := '0';
   signal passed : sl := '0';
   signal failed : sl := '0';
------
  -- Orbit Genarator 
  signal BxNumber : bx_num; 
  signal OrbitNumber : orbit_num; 
  signal OrbitStrobe : sl := '0';
  signal axiClk : sl := '0';
  signal axisTxClk, axisRxClk: sl := '0';
--------------------------------------------------------------------
  constant MAIN_CLK_PERIOD_C : time := 1.389 ns; 
  signal  mainSimClk: sl       := '0';
  signal  mainSimRstClk: sl    := '0';
  signal fsClks                : slv(NUM_FS_CLOCKS_C-1 downto 0);
  signal  ClkMngrLockStat      : sl := '0';
  --------------------------------------------------------------------
  

  constant MGT_CLK_PERIOD_C     : time := 2.48242425 ns;

  constant FRAME_LENGTH_G     : natural := 54;
  constant FIFO_READ_LENGTH_G : natural := 54;
  constant FIFO_HOLD_LENGTH_G : natural := 0;
 -- 
  signal  RxOrbitStrobe : sl := '0';
  
-- Clk Signlas 
  signal clk40     : sl        := '0';
  signal mgtClk    : sl;

  -- Core Diagnostic Ports

  -- MGT interface
  signal mgtRxInitDone              : sl := '1';
  signal mgtRxHeaderValid           : sl;
  signal mgtRxHeader                : slv(2 downto 0);
  signal mgtRxDataValid             : sl;
  signal mgtRxData                  : slv(63 downto 0);
  signal mgtRxSlip                  : sl;
  signal mgtRst                     : sl; 

  signal mgtTxInitDone : sl := '1';
--
  signal mgtTxHeader   : slv(2 downto 0)  := (others => '0');
  signal mgtTxData     : slv(63 downto 0) := (others => '0');
  signal mgtTxSequence : slv(6 downto 0)  := (others => '0');

-- Iridis Ctrl Signals 
  signal iridisSfRxCtrl : tIridisSfRxCtrl := IRIDIS_SF_RX_CTRL_C;
  signal iridisSfRxStat : tIridisSfRxStat := IRIDIS_SF_RX_STAT_C;

  signal iridisSfTxCtrl : tIridisSfTxCtrl := IRIDIS_SF_TX_CTRL_C;
  signal iridisSfTxStat : tIridisSfTxStat := IRIDIS_SF_TX_STAT_C;

  signal cspSpecialStatusTb : slv(CSP_SPECIAL_STATUS_BITS_C) := (others => '0');
  signal RxcspSpecialStatusTb : slv(CSP_SPECIAL_STATUS_BITS_C) := (others => '0');
  signal OrbitGenRst : sl := '0';
  
  signal TxCtrlStrobe :sl := '0';
  signal RxCtrlStrobe,AxisOrbitStrobe :sl := '0';
   
   --
    signal MgtInitStart: sl :='0';
  --
  --
  signal TxBC0 : sl := '0';
  signal EnableProc : sl := '1'; 
  --
  signal CNTR_FRAME_LENGTH : integer range 1 to 1000 := 165; 
  signal CNTR_FRAME_USR_LENGTH : integer range 1 to 1000 := 165; 
  --
  signal  Bc0Position : bx_num := to_bx(x"001");
  signal  Rxbc0 : sl := '0';
  --    
  signal CNTR_FRAME_x_ORBIT : integer  := 10; 
  --
  signal SpyScramblerEna: sl := '0';
  signal RxDataValid, RxHeaderValid: sl := '0';
  signal mgtRxDataValidD1, mgtRxHeaderValidD1 : sl := '0';
  signal HeaderTxPatch   : slv(2 downto 0)  := (others => '0');
  signal DataTxPatch     : slv(63 downto 0) := (others => '0');
  -- 
   signal TxMatchFlag, RxMatchFlag, EnableMatchFlag : sl := '0';
  -- -- GEAR PAUSE  VALUES --- From Simulation and Xilinx Recomendations. 
   constant GEAR_PAUSE_VAL1_C : slv (6 downto 0) := "0101011"; 
   constant GEAR_PAUSE_VAL2_C : slv (6 downto 0) := "1000001"; 
   constant GEAR_PAUSE_VAL3_C : slv (6 downto 0) := "0010101"; 
  
type ErrorGeneratorType is record 
     FreeCntr          : integer; 
     DataOut           : slv (63 downto 0);
     HdrOut            : slv (2 downto 0); 
     ErrorFlag         : slv (6 downto 0);
     TimeErrorPosition : integer; 
     ErrorType         : ErrorType;
    end record ErrorGeneratorType ;
    
  
  constant ERROR_GEN_INIT_C : ErrorGeneratorType :=(
       FreeCntr =>  0, 
       DataOut => (others => '0'),
     HdrOut   => (others => '0'),
       ErrorFlag        => (others => '0'),
	   TimeErrorPosition => 0, 
       ErrorType => NORMAL);
   

   constant CFG_ERROR_INIT_C : ConfigErrorType  := (
      ErrorPosition => 0,
      TypeError      => NORMAL);

  signal cfgErr : ConfigErrorType := CFG_ERROR_INIT_C;   
  signal r_Err: ErrorGeneratorType := ERROR_GEN_INIT_C;
  signal rin_Err: ErrorGeneratorType;
  
  -- 
   signal AxisRst: sl := '1';  -- Rst state by defaul; 
  
  
  ------------------------------------------------------------------------------------
------------------------------------------------------------------------------------ 
begin

  assert (CHAN_FRAME_LENGTH_SIM_C <=  (CHAN_TM_INTERVAL_SIM_C * CHAN_CLK_RATIO_SIM_C)) report "Number of words in the frame must be <= TM_INTERVAL * CLK_RATIO" severity failure;

   ---------------------------
  -- Generate clocks and resets
  ClkRst_Mgt : entity surf.ClkRst
    generic map (
      CLK_PERIOD_G      => MGT_CLK_PERIOD_C,
      RST_START_DELAY_G => 0 ns,  -- Wait this long into simulation before asserting reset
      RST_HOLD_TIME_G   => 1000 ns)     -- Hold reset for this long)
    port map (
      clkP => mgtClk,
      clkN => open,
      rst  => open,
      rstL => open);  
      
    RstAux <= '1' when (OrbitGenRst = '1' or iridisSfTxCtrl.resync = '1') else '0';
-------------------------------
  ClkRst_Main : entity surf.ClkRst
    generic map (
      CLK_PERIOD_G      => MAIN_CLK_PERIOD_C,
      RST_START_DELAY_G => 0 ns,  -- Wait this long into simulation before asserting reset
      RST_HOLD_TIME_G   => 1000 ns)     -- Hold reset for this long)
    port map (
      clkP => mainSimClk,
      clkN => open,
      rst  => OrbitGenRst,
      rstL => open);

   ------------------------------------------
  U_ClockManager : entity surf.ClockManagerUltraScale
    generic map(
      SIMULATION_G       => true,
      INPUT_BUFG_G       => false,
      NUM_CLOCKS_G       => NUM_FS_CLOCKS_C,
      CLKIN_PERIOD_G     => 1.389,
      DIVCLK_DIVIDE_G    => 2,
      CLKFBOUT_MULT_F_G  => ClkMgrCfg(1).CLKFBOUT_MULT_F,
      CLKOUT0_DIVIDE_F_G => ClkMgrCfg(1).CLKOUT0_DIVIDE_F,
      CLKOUT1_DIVIDE_G   => ClkMgrCfg(1).CLKOUT1_DIVIDE,
      CLKOUT2_DIVIDE_G   => ClkMgrCfg(1).CLKOUT2_DIVIDE
      )
    port map(
      clkIn  => mainSimClk,
      rstIn  => mainSimRstClk,
      clkOut => fsClks,
      locked => clkMngrLockStat);
    -- fsClk(0) =  320 MHz 
	-- fsClk(1) =  40 MHz 
	-- fsClk(2) = 360 MHz 
   clk40 <=  fsClks(1);       -- 
   axisTxClk <= fsClks(2);    --  
   axisRxClk <= fsClks(2);
   
 -------------------------------
 -- TCDS2 Control
  ------------------------------------------
  -- BX and orbit generator.
  ------------------------------------------

   U_OrbitStrobeGen : entity work.orbit_strobe_generator
    port map (
      reset_i              => RstAux,
      bunch_clock_i        => clk40,
      orbit_strobe_i       => '0',
      expected_strobe_bx_i => to_bx(x"001"),
      desired_strobe_bx_i  => Bc0Position,

      bx_number_o          => BxNumber,
      orbit_number_o       => OrbitNumber,
      orbit_strobe_o       => OrbitStrobe  -- BC0
    );
	
 U_AxisStreamRst : entity surf.PwrUpRst
     generic map (
	 DURATION_G => 300
	 )
    port map (
           arst  => TxBc0,
           clk   => axisTxClk, 
           rstOut => AxisRst);
    
    
-- ------------------------------------
--  CSP Generator --------------------
---------------------------------------
  U_SideBandGen: entity apx_fs.SideBandGen    
       generic map ( 
         TPD_G            => TPD_C, 
         TM_INTERVAL      => CHAN_TM_INTERVAL_SIM_C,
         CLK_RATIO        => CHAN_CLK_RATIO_SIM_C,
         FRAME_LENGTH     => CHAN_FRAME_LENGTH_SIM_C, 
         THROTTLE_VECTOR  => CHAN_THROTTLE_VECTOR_SIM_C, 
         BC0_OFFSET       => 0,
         BC0_CLK_DOMAIN   => "LHC",
         MODE             => "GENERATE"
       )
       port map ( 
              -- AXI-stream/a
              axisClk      => axisTxClk,
              axiStreamIn  =>  AxisDataSideBand, 
              axiStreamOut =>  AxisTxSideBand,
              bc0_axis     =>  '0',
              rst_axis     => AxisRst,
              --LHC clock domain
              clkLHC       => clk40, 
              bc0_clkLHC   => OrbitStrobe,
              
               --Delay on distributed LHC clock (in AXI stream clock units)
              delay        => x"0100",
              
              --monitor bit output stream
              monitorOut   => SideBandMonitor
            );


-- ------------------------------------
-- Iridis Rx --------------------------
---------------------------------------
U_IridisCSPRx: entity apx_fs.IridisCSPRx
   generic map (
       TPD_G  => TPD_C, 
       CHAN_TM_INTERVAL      => RX_CHAN_TM_INTERVAL_SIM_C,
       CHAN_CLK_RATIO        => RX_CHAN_CLK_RATIO_SIM_C,   
       CHAN_THROTTLE_VECTOR  => RX_CHAN_THROTTLE_VECTOR_SIM_C,    
       CHAN_FRAME_LENGTH     => RX_CHAN_FRAME_LENGTH_SIM_C           
     )
   port map  (
   axisClk    => axisRxClk, 
   axiStream  => AxisRxMaster, 


   clkLHC     => clk40, 
   bc0_clkLHC => OrbitStrobe, 

   cspSpecialStatus  => RxcspSpecialStatusTb, 

   mgtRxClk         => mgtClk, 
   mgtRxInitDone    => mgtRxInitDone, 
   mgtRxHeaderValid => mgtRxHeaderValid, 
   mgtRxHeader      => mgtRxHeader, 
   mgtRxDataValid   => mgtRxDataValid,  
   mgtRxData        => mgtRxData, 
   mgtRxSlip        => mgtRxSlip, 
   mgtRst           => mgtRst, 


   iridisSfRxCtrl => iridisSfRxCtrl,
   iridisSfRxStat => iridisSfRxStat
 );

--------------------------------- 
---- Iridis Tx --------------
 -------------------------------- 
  U_IridisCSPTx : entity apx_fs.IridisCSPTx
    generic map (
      TPD_G              => TPD_C,
      CHAN_TM_INTERVAL   => CHAN_TM_INTERVAL_SIM_C,
      CHAN_CLK_RATIO     => CHAN_CLK_RATIO_SIM_C,
      CHAN_FRAME_LENGTH  => CHAN_FRAME_LENGTH_SIM_C, 
      CHAN_THROTTLE_VECTOR =>  CHAN_THROTTLE_VECTOR_SIM_C  
      )
    port map(
     clkLHC   => clk40, 
     bc0_clkLHC     => OrbitStrobe,
  
      -- MGT Interface 
      mgtTxClk => mgtClk,
      mgtTxInitDone => mgtTxInitDone,
      mgtTxHeader   => mgtTxHeader,
      mgtTxData     => mgtTxData,
      mgtTxSequence => mgtTxSequence,

      iridisSfTxCtrl => iridisSfTxCtrl, 
      iridisSfTxStat => iridisSfTxStat,

      cspSpecialStatus => cspSpecialStatusTb,
       
      
      axisClk  => axisTxClk,
      axiStream =>   AxisTxSideBand);-- AxisTxMaster);

-------------------------------------------
-- AXI Stream Generator                ----
--------------------------------------------
   comb : process ( r, RstAux,TxBC0) is
      variable v : RegType;
      variable i : natural;
   begin
      -- Latch the current value
      v := r;

      -- Generate the next random data words
     --- for i in 31 downto 0 loop
      --   v.wrPbrs := lfsrShift(v.wrPbrs, PRBS_TAPS_C);
       --  v.rdPbrs := lfsrShift(v.rdPbrs, PRBS_TAPS_C);
      --end loop;
    
    -- State MAchine 
        case r.TxState is 
        ----------------------------------------------------------------
		when START_S  => 
               -- Reset Frame Counter 
                  v.wrFrameCnt:=0;
               -- FF0 off
                  v.wrFFO := '0';
               -- SOF Off 
                  v.wrSof := '0';
                -- EOF Off 
                  v.wrEoF := '0';
				  -- Idles Off 
                  v.wrIdles := '1';
				-- Data Generator Pause; 
				v.wrDataGenEn := '0'; 

             if (TxBc0 = '1' ) then 
             --FF0 Send 
               v.wrFFO := '1';
             --SOF Send 
                 v.wrSof := '1';
                -- EOF Off 
                  v.wrEoF := '0';
            -- Next State 
                 v.Txstate := FFO_S;
			-- Data Generatro Active 
			     v.wrDataGenEn := '1';
              end if; 
        ----------------------------------------------------------------
              -- 
         when FFO_S => 
            --FFO Off 
               v.wrFFO := '0';
            -- Initial SOF Off 
               v.wrSof := '0';
             -- EOF Off 
                  v.wrEoF := '0';
           -- Increment BxCntr 
                 v.WrBxCnt := r.WrBxCnt+1; 

            -- Next State 
                v.TxState  := RUN_S; 
      ----------------------------------------------------------------    
        when RUN_S => 
             --SOF Off 
               v.wrSof := '0';
			 -- FF0 off
               v.wrFFO := '0';
              --
                if r.wrBxCnt < CNTR_FRAME_USR_LENGTH then 
                   v.wrBxCnt := r.wrBxCnt + 1;
                 else 
                   -- Send EOF 
                      v.wrEoF :='1'; 
                   -- Increment Frame Counter
                      v.wrFrameCnt := r.wrFrameCnt + 1 ;
                   -- Next State 
                      v.TxState := NEW_FRAME_S;
                 end if;
       ----------------------------------------------------------------
          when NEW_FRAME_S => 
            if ((r.wrFrameCnt =  CNTR_FRAME_x_ORBIT) and (r.wrBxCnt >= CNTR_FRAME_LENGTH ))then 
              -- FF0 set
                 v.wrFFO := '1';
              --SOF Send 
               v.wrSof := '1';
             -- EOF Off
                v.wrEoF :='0';
				      
             -- Reset BxCntr 
                v.wrBxCnt := 0; 
			
			-- Idles off 
                v.wrIdles := '1';
		 	   
			   -- Reset Frame Counter
               v.wrFrameCnt := 0 ;
				
             -- Next Stat 
                v.TxState := RUN_S;
             ----------------------------------------------------------------
              elsif (r.wrBxCnt < CNTR_FRAME_LENGTH) then  -- IDLES Condition 
              -- FF0 off
                 v.wrFFO := '0';
              -- EOF Off
                  v.wrEoF :='0';
              -- Increm BxCntr  
                 v.wrBxCnt := r.wrBxCnt + 1;
              -- Idles On 
                  v.wrIdles := '0';
              -- Next State 
                 v.TxState := IDLES_S; 
               ----------------------------------------------------------------
              else 
              -- Rest BxCntr
                  v.wrBxCnt := 0; 
              -- FF0 off
                 v.wrFFO := '0';
              --SOF Send 
               v.wrSof := '1';
              -- EOF Off
                v.wrEoF :='0';
			        -- Idles off 
                  v.wrIdles := '1';
             -- Next Stat 
                v.TxState := RUN_S;
             end if;
      ----------------------------------------------------------------     
         when IDLES_S => 
              if (r.wrBxCnt <= CNTR_FRAME_LENGTH-2) then 
                  -- Increment BxCntr 
                  v.wrBxCnt := r.wrBxCnt + 1; 
              else 
                  -- Idles on 
                  v.wrIdles  := '0';
                -- Increment BxCntr 
                  v.wrBxCnt := r.wrBxCnt + 1; 
                -- Next TxState 
                 v.TxState := NEW_FRAME_S; 
                 
               end if;
           when others => 
                 null ;
                v.TxState := START_S;

            end case; 
     ----------------------------------------------------------------
	 -- Payload Counters. 
	 -----------------------------------------------------------------
	     if (r.wrDataGenEn ='1') then 
		  if (((r.wrBxCnt = CNTR_FRAME_USR_LENGTH) and (r.wrEoF = '1')) or (r.wrIdles = '0')) then
		     v.wordCnt := 0;
		   else 
			v.wordCnt := r.wordCnt + 1;
		  end if;
		  
		  if (r.wrEoF = '1') then 
		     if ((r.frameCnt < CNTR_FRAME_x_ORBIT-1))then
			 v.frameCnt := r.frameCnt + 1;
			else 
			v.frameCnt := 0;
		    end if;
		 end if;
		  
		 end if;
	 -----------------------------------------
            -- Check the counter size
			if (CNTR_FRAME_LENGTH = CNTR_FRAME_USR_LENGTH) then  -- FULL TM
              if ((r.wrFrameCnt =  CNTR_FRAME_x_ORBIT-1) and (r.wrEoF = '1'))  then
               -- Increment the counter
                 v.wrPkt            := r.wrPkt + 1;
			  end if;
			else 
			 if ((r.wrFrameCnt =  CNTR_FRAME_x_ORBIT) and (r.wrEoF = '1'))  then  --
               -- Increment the counter
                 v.wrPkt            := r.wrPkt + 1;
			  end if;
			end if; 
     ----------------------------------------------------------------
      -- Reset
      if (RstAux = '1') then
         v := REG_INIT_C;
      end if;

      -- Register the variable for next clock cycle
      rin <= v;

      -- Outputs
      AxisTxMaster.tValid    <= r.wrIdles;
      AxisTxMaster.tUser(0)  <= r.wrSoF;
      AxisTxMaster.tUser(1)  <= r.wrFFO;
      AxisTxMaster.tLast     <= r.wrEoF;
       -- Forward counter
      AxisTxMaster.tData(15 downto 0)<= std_logic_vector(to_unsigned(r.wordCnt,16));           -- Word  (0 to 161)
      AxisTxMaster.tData(35 downto 20)<= std_logic_vector(to_unsigned(r.frameCnt,16));       -- Frame (0 to 198)
      AxisTxMaster.tData(63 downto 48)<= r.wrPkt(15 downto 0);                                 -- Orbit0 to ....

   end process comb;

   seq : process (axisTxClk) is
   begin
      if rising_edge(axisTxClk) then
         r <= rin; --after TPD_C;
      end if;
   end process seq;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
p_MainProces : process is
  begin
    while (EnableProc = '1') loop  
   wait for 50 ns;
  ------------------------------------------------------------------------------------
  -- Configuration of the Data Generator                                          ----
  -------------------------------------------------------------------------------
     DataGenCfg(CNTR_FRAME_x_ORBIT,CNTR_FRAME_LENGTH,CNTR_FRAME_USR_LENGTH);
  ------------------------------------------------------------------------------------
  --  Configurartion Erorr                                                         --
  ------------------------------------------------------------------------------------
       ErrorCnfg (NORMAL,308,cfgErr);
  ------------------------------------------------------------------------------------
  --  Set Configuration of CSP_Tx and CSP_Rx parameters. 
  ------------------------------------------------------------------------------------
      IridisTxCtrlSet(IDLE_METHOD,RESYNC_DLY,LINK_INFO_0,LINK_INFO_1,x"00",iridisSfTxCtrl);   
      wait for 10 ns;
      IridisRxCtrlSet(INDX_CORRECTION_BLOCK,MGT_RST_EN,AUTO_ORBIT_ALIGN,RESYNC_DEFAULT,RX_RESYNC_DLY,RELEASE_DLY,x"00",iridisSfRxCtrl); 
      wait  for 10 ns;
      show("Set Tx Resync Command"); 
      CtrlPulse(5,IridisSfTxCtrl.resync);
      wait for 150 ns;
  ------------------------------------------------------------------------------------
  --  After configuration and Tx Resync Command  Start the data generation  ---
  ------------------------------------------------------------------------------------
      DataGenStart(OrbitStrobe,TxBc0); 
	  wait until (rising_edge(OrbitStrobe));
	  show("Set Rx Resync Command"); 
      CtrlPulse(2,IridisSfRxCtrl.resync);
      wait for 100 ns; 
      EnableMatchFlag <= '1';
      wait until (rising_edge(OrbitStrobe));
      wait until (rising_edge(OrbitStrobe));
	  wait until (rising_edge(OrbitStrobe));
	  RxCountersStatus(iridisSfRxStat);
      wait for 50 ns;
	  EnableMatchFlag <= '0';
      wait for 50 ns;
      LinkRxInfo(iridisSfRxStat,iridisSfTxCtrl); 
	  wait ;
	  wait for  50ns;
       for i in 0 to 20  loop
	    CrCError(iridisSfTxCtrl);
		 wait for 500 ns ;
		 RxCountersStatus(iridisSfRxStat);
	     wait for 50 ns; 
	end loop;
	   wait until (rising_edge(OrbitStrobe));
	    RxCountersStatus(iridisSfRxStat);
	  wait ;
	  
	  HdrError(iridisSfTxCtrl);
      wait for 500 ns ;
      RxCountersStatus(iridisSfRxStat);
      wait until (rising_edge(OrbitStrobe));
      wait for  200 ns;
   	  RxClearSticky(iridisSfRxCtrl); 
      wait for 100 ns;
	    RxCountersStatus(iridisSfRxStat);
	 --
	    wait for 50 ns; 
		
	  if (IridisSfRxCtrl.ICBlockEn = '0') then 
	   RxSyncRecovery(IridisSfRxCtrl,iridisSfRxStat);
	  end if; 
   -- 
	 
	  wait  for 50 ns;
	  HdrError(iridisSfTxCtrl);

  --    CrCError(iridisSfTxCtrl);
      wait for 500 ns ;
      RxCountersStatus(iridisSfRxStat);
      wait until (rising_edge(OrbitStrobe));
      wait for  200 ns;
   	  RxClearSticky(iridisSfRxCtrl); 
      wait for 100 ns;
	  RxCountersStatus(iridisSfRxStat);
	  --
	  wait for 100 ns; 
	  ICFieldError(iridisSfTxCtrl); 
	  wait for 500 ns ;
      RxCountersStatus(iridisSfRxStat);
      wait until (rising_edge(OrbitStrobe));
	  wait for  200 ns;
   	  RxClearSticky(iridisSfRxCtrl); 
      wait for 100 ns;
	  RxCountersStatus(iridisSfRxStat);
	  --
	  
	    -- 
	 
	  wait  for 50 ns;
	  HdrError(iridisSfTxCtrl);
      wait for 500 ns ;
	  wait until (rising_edge(OrbitStrobe));
      RxCountersStatus(iridisSfRxStat);
      wait for  200 ns;
	  
	  
	  wait ;
  end loop; 
   wait; 
  end process p_MainProces;
----------------------------------------------------------------
-- Monitor Tx Error Signals 
----------------------------------------------------------------
 p_Report: process is 
     begin 
         while (EnableProc ='1') loop 
           wait until (falling_edge(iridisSfTxCtrl.resync));
           for i in 0 to 10000 loop  -- Comment: For the moment check the status only during 3
            assert (iridisSfTxStat.StickyBitFlags.ffoPositionErr = '0') report " FFO Position Error Detected" severity error;
            assert (iridisSfTxStat.StickyBitFlags.sofPositionErr = '0') report " SOF Position Error Detected" severity error;
            assert (iridisSfTxStat.StickyBitFlags.sofMissingErr = '0') report  " SOF Missing  Error Detected" severity error;
            assert (iridisSfTxStat.StickyBitFlags.eofPositionErr = '0') report " EOF Position Error Detected" severity error;
            assert (iridisSfTxStat.StickyBitFlags.eofMissingErr = '0') report  " EOF Missing  Error Detected" severity error;
			assert (iridisSfTxStat.StickyBitFlags.fifoOvrErr = '0') report  " FIFO Over Run Flags, (Serious problem of the Tx Block) " severity error;
		    assert (iridisSfTxStat.StickyBitFlags.fifoUdfErr = '0') report  " FIFO Under Run Flags, (Serious problem of the Tx Block) " severity error;
            wait until (rising_edge(OrbitStrobe)) ;  
           end loop; 
         end loop; 
         wait; 
  end process;
  

----------------------------------------------------------------
-- Monitor Rx Error Signals 
----------------------------------------------------------------
 p_RxMonitor: process is 
     begin 
         while (EnableProc ='1') loop 
           wait until (falling_edge(iridisSfRxCtrl.resync));
           for i in 0 to 10000 loop  -- Comment: For the moment check the status only during 3
            assert (iridisSfRxStat.StickyBitFlags.uccErr             = '0') report " Uknow Controk Errorr Detected" severity error;
            assert (iridisSfRxStat.StickyBitFlags.iimErr             = '0') report " Invalid Idle Method Error Detected (Method 1 Idles as Ctrl Word) " severity error;
            assert (iridisSfRxStat.StickyBitFlags.ffoMissingErr      = '0') report " FFO Not Detected at start" severity error;
            assert (iridisSfRxStat.StickyBitFlags.ffoPositionErr     = '0') report " FF0 detected in unexpected Position" severity error;
            assert (iridisSfRxStat.StickyBitFlags.eofPositionErr     = '0') report " EOF (in CRCV  word) encountered in unexpected position" severity error;
            assert (iridisSfRxStat.StickyBitFlags.eofMissingErr      = '0') report " EOF (in CRCV  word) not in expected position          " severity error;
            assert (iridisSfRxStat.StickyBitFlags.fifoOvrErr         = '0') report " FIFO Overflow Error Detected" severity error;
            assert (iridisSfRxStat.StickyBitFlags.fifoUdfErr         = '0') report " FIFO Underflow   Error Detected" severity error;
            wait until (rising_edge(OrbitStrobe)) ;  
           end loop; 
         end loop; 
         wait; 
  end process;

--------------------------
--- IridisCSPRx  Status  assertion                         ---
--------------------------------------------------------------
  p_RxMonitorStatus: process 
    begin 
       while (EnableProc = '1' ) loop 
         wait until (rising_edge(iridisSfRxStat.ResyncDone));
             report "IridisCSPRx  Synchronization completed" severity note;
         wait until (rising_edge(iridisSfRxStat.FFOLocked )); 
             report "IridisCSPRx  First Frame of orbit detected" severity note;
              while (iridisSfRxStat.ResyncDone='1') loop 
			  wait until (rising_edge(OrbitStrobe)) ; 
                assert (iridisSfRxStat.gearboxLocked ='1') report "Synchronization lost on gearbox"severity error;
                assert (iridisSfRxStat.FFOLocked    ='1') report "First Frame of Orbit unlocked"severity error;
                assert (iridisSfRxStat.ICLock        ='1') report "Index Corrector unlocked"severity error;
				 
              end loop; 
          end loop; 
        wait; 
   end process; 


----------------------------------------------------------------
 -- Rx Data Checker  --  to be improved
----------------------------------------------------------------
    p_RxDataChecker: process 
          begin 
             while (EnableProc = '1') loop 
              wait until (rising_edge(iridisSfRxStat.FFOLocked)); 
              assert (AxisRxMaster.tvalid = '1' and AxisTxMaster.tdata(AXI_STREAM_ALGO_TDATA_C-1  downto 0) /=  x"E400000000000000") report "Idle present in the Rx Data Strean (as Payload)" severity error; --failure;
              end loop; 
            wait; 
          end process; 
       ----------------------------------------------------------------
-- Spy Signls -- 
-----------------------------------------------------------------
       --signal_agent("/IridisSfTb/U_IridisTx/ScramblerEna","SpyScramblerEna",0);

-----------------------------------
 -- MGT   Control                --
-------------------------------------
 p_MgtRx: process(mgtClk) is
  begin
   if rising_edge(mgtClk) then
    
        mgtRxDataValid   <= mgtRxDataValidD1; 
        mgtRxHeaderValid <= mgtRxHeaderValidD1;

         mgtRxDataValidD1   <= RxDataValid;
         mgtRxHeaderValidD1 <=RxHeaderValid;
    end if;
  end process;

  -- -----------------------------------
  --  -- Forward the GearBox Pause    --
  -- -----------------------------------
  p_MgtValid: process is 
    begin 
        while (EnableProc = '1') loop 
		  RxDataValid <= '1'; 
		  RxHeaderValid <= '1';
        wait until ((mgtTxSequence = GEAR_PAUSE_VAL1_C) or (mgtTxSequence = GEAR_PAUSE_VAL2_C) or (mgtTxSequence = GEAR_PAUSE_VAL3_C)); 
			     RxDataValid <= '0' ;
			     RxHeaderValid <= '0';
             wait for MGT_CLK_PERIOD_C*2 ;
			      RxDataValid <= '1';
				  RxHeaderValid <= '1';  
         end loop;
          wait;
        end process;--
		
  -- -------------------------------------
  --  Report CRC Errors. 
  -- -------------------------------------

        p_CrcChk: process is 
          variable LocCounter : integer := 0;
           begin 
             while (EnableProc = '1') loop 
               wait until (rising_edge(AxisRxMaster.tUser(2)));
			   assert (AxisRxMaster.tUser(2) = '0') report "CRC Error detected" severity warning; 
			   wait for 200 ns; 
                LocCounter := to_integer(unsigned(iridisSfRxStat.CRCErrCnt)); 
                report "Number of CRC Errors: " & str(locCounter) ;
              end loop;
             wait;
           end process;

---------------------------------
-- Match Flag                 ---
---------------------------------
p_MatchFlagProcess: process is 
  variable TxTime, RxTime, DiffTime : time := 0 ns;
  variable NumOfBx : integer := 0;
  constant Baset : time := 25 ns;
  variable DataTemp : slv (35 downto 0) := (others =>'0');
    begin 
        while (EnableProc='1') loop 
         wait until (rising_Edge(EnableMatchFlag)); 
         while (EnableMatchFlag = '1') loop 
		  wait until (AxisRxMaster.tvalid = '1');
           wait until  (AxisTxMaster.tdata(7 downto 0) = x"10");
		   DataTemp := (AxisTxMaster.tdata(35 downto 0));
		   TxTime:= now  ;
           TxMatchFlag <= '1';
           wait until (rising_edge(axisTxClk));
           TxMatchFlag <= '0';
           wait until  (AxisRxMaster.tdata(35 downto 0) = DataTemp); 
           RxMatchFlag <= '1';
		   RxTime := now  ;
           wait until (rising_edge(axisTxClk));
		   DiffTime:= (RxTime - TxTime); 
		   NumOfBx := DiffTime/Baset;
		   show("============================================");
		   show("Total number of Bx "&str(NumOfBx));
		    show("============================================");
           RxMatchFlag <= '0';
           wait until (rising_edge(OrbitStrobe)); 
        end loop;
       end loop; 
       wait ;
    end process;

--------------------------------------------------
-- Error Generator ---
--------------------------------------------------

    ErrorComb: process (r_Err,mgtTxData, cfgErr, mgtTxHeader) is 
      variable v : ErrorGeneratorType; 

    begin 
       -- Latch  the current value 
      v := r_Err; 
      
      v.TimeErrorPosition := cfgErr.ErrorPosition;
      v.ErrorType       := cfgErr.TypeError;
        -- Update the Counter 
		  if r_Err.FreeCntr = 65535 then 
		    v.FreeCntr := 0;
		  else
            v.FreeCntr := r_Err.FreeCntr + 1; 
          end if;
	   
	   -- 
          v.DataOut := mgtTxData; 
          v.HdrOut  := mgtTxHeader;
          v.ErrorFlag := (others => '0');
        
           case r_Err.ErrorType is 
             when NORMAL  => 
               -- Outputs 
               v.DataOut := mgtTxData;      
               v.HdrOut  := mgtTxHeader;
             when SINGLE_HDR_ERR => 
               if(r_Err.FreeCntr = r_Err.TimeErrorPosition) then 
                 v.HdrOut(1) := not mgtTxHeader(1);
                 v.DataOut   := mgtTxData;
                 v.ErrorFlag := "0000001"; 
                end if; 
             when DOUBLE_HDR_ERR => 
               if (r_Err.FreeCntr = r_Err.TimeErrorPosition) then 
                v.HdrOut(0) := not mgtTxHeader(0);
                v.HdrOut(1) := not mgtTxHeader(1);
                v.DataOut   := mgtTxData; 
                 v.ErrorFlag := "0000010"; 
              end if;
            when INDX_NUMBER_ERRR => 
               if (r_Err.FreeCntr = r_Err.TimeErrorPosition) then 
                 v.HdrOut := mgtTxHeader;
                 v.DataOut(53) := not(mgtTxData(53));
                 v.ErrorFlag := "0000100"; 
                end if ;
             when SINGLE_CTRL_TYPE_ERR => 
                 if(r_Err.FreeCntr = r_Err.TimeErrorPosition) then 
                   v.HdrOut :=  mgtTxHeader; 
                   v.DataOut(57) := not(mgtTxData(57));
                   v.ErrorFlag := "0001000"; 
                  end if; 
             when DOUBLE_CTRL_TYPE_ERR => 
                 if(r_Err.FreeCntr = r_Err.TimeErrorPosition) then 
                   v.HdrOut :=  mgtTxHeader; 
                   v.DataOut(57) := not(mgtTxData(57));
                   v.DataOut(58) := not(mgtTxData(58));
                 v.ErrorFlag := "0010000"; 
                  end if; 
             when SINGLE_DATA_ERR => 
                 if(r_Err.FreeCntr = r_Err.TimeErrorPosition) then 
                   v.HdrOut :=  mgtTxHeader; 
                   v.DataOut(63) := not(mgtTxData(63));
                 v.ErrorFlag := "0100000"; 
                  end if; 
             when DOUBLE_DATA_ERR => 
                 if(r_Err.FreeCntr = r_Err.TimeErrorPosition) then 
                   v.HdrOut :=  mgtTxHeader; 
                   v.DataOut(63) := not(mgtTxData(63));
                   v.DataOut(62) := not(mgtTxData(62));
                 v.ErrorFlag := "1000000"; 
                  end if; 
              when others => 
               -- Outputs 
               v.DataOut := mgtTxData;      
               v.HdrOut  := mgtTxHeader;
                 v.ErrorFlag := (others => '0'); 
            end case;
    -- Register the variable for next clock cycle 
          rin_Err  <= v;
		  
	-- Outputs 
--
     mgtRxHeader <= r_Err.HdrOut;
	 mgtRxData   <= r_Err.DataOut;
  end process ErrorComb; 


  ErrorSeq: process (mgtClk) is 
  begin 
    if (rising_edge(mgtClk)) then 
       r_Err <= rin_Err;
    end if;
  end process ErrorSeq;

end Behavioral;
