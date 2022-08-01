library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


Library surf;
use surf.StdRtlPkg.all;
use surf.TextUtilPkg.all;

library apx_fs;

use apx_fs.IridisCSPPkg.all;
--  CSP simulation Pakage 
use work.CSPSimulationPkg.all; 
use work.CSPSimTypePkg.all; 
use apx_fs.APxLinkBufPkg.all;
library std; 
use std.textio.all;

package CSPSimCtrlPkg is  

  -- VIVADO Sim 
 file  SimLog:    text open  WRITE_MODE  is    "../../../../../../common/SimAPxFS/Wave/SimLog.txt";
----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
 procedure  DataGenCfg (signal  CNTR_FRAME_x_ORBIT    : out  integer; 
                        signal  CNTR_FRAME_LENGTH     : out  integer range 1 to 10000; 
                        signal  CNTR_FRAME_USR_LENGTH : out  integer range 1 to 10000);
----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
 procedure   LinkRxInfo  (signal iridisSfRxStat  : in  tIridisSfRxStat;
                          signal iridisSfTxCtrl  : in tIridisSfTxCtrl) ; 
----------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
 procedure  RxCountersStatus (signal iridisSfRxStat: in  tIridisSfRxStat); 
------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
  procedure HdrError(signal IridisTxCtrl: inout tIridisSfTxCtrl); 
----------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
  procedure CrcError(signal IridisTxCtrl: inout tIridisSfTxCtrl); 
----------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
  procedure CtlCodeError(signal IridisTxCtrl: inout tIridisSfTxCtrl); 
----------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
  procedure ICFieldError(signal IridisTxCtrl: inout tIridisSfTxCtrl); 
----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 

  procedure TxClearSticky(signal iridisSfTxCtrl: out tIridisSfTxCtrl); 
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------ 
  function CntrMaxNumFramexOrbit(TMInterval: natural := 18) return integer; 
------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
  procedure RxClearSticky(signal iridisSfRxCtrl: inout tIridisSfRxCtrl); 
------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
  function CntrFrameMaxFunc (TMInterval: natural := 18;
            ClkRatio   : natural := 1) return integer;
------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
   function NumberOfDataWordsxFrameFunc (NumDataWords: natural := 100)return integer ;
------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
  procedure  DataGenStart ( signal  bc0     : in  sl;
                            signal StartGen: out sl);
------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
   procedure  ErrorCnfg ( constant TypeOfError   : in ErrorType := NORMAL; 
                           constant ErrorPosition : in integer := 300;
					              	   signal cfgErr        : out  ConfigErrorType );
----------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
  procedure CtrlPulse  ( constant  NumberOfClkCycles_C: in integer;
                             signal TxCtrlStrobeAux : out sl);
------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
   procedure IridisTxCtrlSet (constant IdleMethod:  in sl; 
                              constant resyncDly :  in slv (15 downto 0);
                              constant LinkInfo1 :  in slv (31 downto 0);
                              constant LinkInfo2 :  in slv (31 downto 0);
                              constant ClrMask   :  in slv (7  downto 0); 
                              signal TxIridisCtrl : out tIridisSfTxCtrl);
------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
   procedure IridisRxCtrlSet (constant IndxCorrBlockEn:  in sl; 
                              constant mgtRstEn     :  in sl;
                              constant AOAEn        :  in sl;
                              constant resync       :  in sl;    -- Type of Rst, needs a pulse 
                              constant resyncDly    :  in slv (15  downto 0); 
                              constant releaseDly   :  in slv (15  downto 0); 
                              constant ClrMask      :  in slv (7   downto 0); 
                              signal RxIridisCtrl : out tIridisSfRxCtrl);
----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
   procedure RxSyncRecovery ( signal IridisSfRxCtrl : inout tIridisSfRxCtrl; 
                              signal IridisSfRxStat : in tIridisSfRxStat);
----------------------------------------------------------------------------------------- 
    procedure LinkBufRst ( signal linkBufCtrlTb : out tLinkBufCtrl); 
 ---------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
    procedure LinkBufCfgMode ( signal linkBufCtrlTb : out tLinkBufCtrl; 
                              constant linkBufMode : in sl  ); 
 ---------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
  procedure  show (constant str: in string); -- Information (simulation and note) shown on screen and  sim_logfile   
----------------------------------------------------------------------------------------- 
end package CSPSimCtrlPkg; 
----------------------------------------------------------------------------------------- 

 package body  CSPSimCtrlPkg is 

----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 

 procedure  DataGenCfg (signal  CNTR_FRAME_x_ORBIT    : out  integer; 
                        signal  CNTR_FRAME_LENGTH     : out  integer range 1 to 10000; 
                        signal  CNTR_FRAME_USR_LENGTH : out  integer range 1 to 10000) is

              begin 
			   show("====================================================================");
			   show("           Data Generator Config                                    "); 
			   show("====================================================================");
			   show(" TM                  : " &str(CHAN_TM_INTERVAL_SIM_C)); 
			   show(" CLOCK RATIO         : " &str(CHAN_CLK_RATIO_SIM_C));
			   show(" FRAME LENGTH        : " &str(CHAN_FRAME_LENGTH_SIM_C));
			   show(" THROTTLE VECTOR     : " &str(CHAN_THROTTLE_VECTOR_SIM_C));
               CNTR_FRAME_x_ORBIT <= CntrMaxNumFramexOrbit(CHAN_TM_INTERVAL_SIM_C);                    -- Comment: Number of Frames per Obit 
               CNTR_FRAME_LENGTH <= CntrFrameMaxFunc(CHAN_TM_INTERVAL_SIM_C,CHAN_CLK_RATIO_SIM_C);     --Comment:  Frame Length (TM, Clock Ratio) 
	           wait for  50 ns; 
               CNTR_FRAME_USR_LENGTH  <= NumberOfDataWordsxFrameFunc(CHAN_FRAME_LENGTH_SIM_C);
     end DataGenCfg;  
   
   
----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
   procedure  LinkRxInfo ( signal  iridisSfRxStat  : in  tIridisSfRxStat;
                           signal   iridisSfTxCtrl  : in tIridisSfTxCtrl )  is 
            variable RxlocInfo, TxlocInfo: slv (31 downto 0) := (others => '0'); 
     begin 

       if (iridisSfRxStat.linkInfo(0) /=  iridisSfTxCtrl.linkInfo(0)) then 
             report  "Bad Link ID: " & hstr(iridisSfRxStat.linkInfo(0)) severity error; 
       else 
         show("Link ID: " &  hstr(iridisSfRxStat.linkInfo(0)) & "  Expected Link ID: " & hstr(iridisSfTxCtrl.linkInfo(0))); 
        end if;

    end LinkRxInfo; 
----------------------------------------------------------------------------------------- 
--  ------------------------------------------------------------------------------------
   procedure RxCountersStatus (signal iridisSfRxStat: in tIridisSfRxStat) is 
      variable  locCounter : integer := 0;
   begin 
      show("====================================================================");
      show("====          S T A T U S    C O U N T E R s                ======= ");
      show("====================================================================");
       locCounter := to_integer(unsigned(iridisSfRxStat.FFOPos)); 
       show("First Position of Orbit detected  at: "&str(locCounter)  & " counts");
       wait for 1ns; 
       locCounter := to_integer(unsigned(iridisSfRxStat.CRCErrCnt)); 
       show("Number of CRC Errors: " & str(locCounter));
       wait for 1ns; 
       locCounter := to_integer(unsigned(iridisSfRxStat.ICErrCnt)); 
       show("Number or IC Error: " & str(locCounter)) ;
       wait for 1ns; 
       locCounter := to_integer(unsigned(iridisSfRxStat.LinkResyncCnt)); 
      show(" Link  Resync  Counter: "&str(locCounter));
	    show("====================================================================");
     end RxCountersStatus; 
------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
  function CntrMaxNumFramexOrbit(TMInterval: natural := 18)
           return integer is 
            variable MaxNumFramexOrbit : integer range 0 to 2000 := 198;
          begin 
             MaxNumFramexOrbit := (3564)/(TMInterval);
			show("====================================================================");
             show(str(MaxNumFramexOrbit) & " Frames per Orbit");
			show("====================================================================");
          return MaxNumFramexOrbit;
   end CntrMaxNumFramexOrbit;

--  -----------------------------------------------------------------------------------
--  ------------------------------------------------------------------------------------
   function CntrFrameMaxFunc (TMInterval: natural := 18;
            ClkRatio   : natural := 1) return integer is 
             variable FrameLength : integer range 0 to 200:= 165;
           begin 
             FrameLength:= (TMInterval * ClkRatio);
  assert (CHAN_FRAME_LENGTH_SIM_C <=  FrameLength) report "Number of words in the frame must be <= TM_INTERVAL * CLK_RATIO" severity failure;
             return FrameLength - 2; 
  end CntrFrameMaxFunc;


------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
   function NumberOfDataWordsxFrameFunc (NumDataWords: natural := 100) 
             return integer is 
             variable DataWordsNum : integer := 2;
             variable IdlesNum     : integer := 10; 
             begin
                DataWordsNum := NumDataWords; 
                assert (DataWordsNum <=  (CHAN_TM_INTERVAL_SIM_C * CHAN_CLK_RATIO_SIM_C)) report "Invalid number of Data Words x Frame" severity failure;
                IdlesNum :=  ((CHAN_TM_INTERVAL_SIM_C * CHAN_CLK_RATIO_SIM_C) - DataWordsNum);
				show("====================================================================");
                show(str(DataWordsNum) & " Data Words  and " & str(IdlesNum) & " Idle Words  per frame");
				show("====================================================================");
               return DataWordsNum-2; 
    end NumberOfDataWordsxFrameFunc;
--  ------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------- 
    procedure HdrError(signal IridisTxCtrl: inout tIridisSfTxCtrl) is 
                begin 
                    IridisTxCtrl.ClrMask.hdrErrForce <= '1';
                    IridisTxCtrl.TxCtrlStrobe <= '1' ; 
                    wait for AxiStreamPeriod * 2; 
                    IridisTxCtrl.TxCtrlStrobe <= '0' ; 
					          wait for AxiStreamPeriod * 2; 
					          IridisTxCtrl.ClrMask.hdrErrForce <= '0';
					show("Double Header Error  inserted "); 
    end HdrError; 
------------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
    procedure CrCError(signal IridisTxCtrl: inout tIridisSfTxCtrl) is 
                begin 
                    IridisTxCtrl.ClrMask.crcErrForce    <= '1';
                    IridisTxCtrl.TxCtrlStrobe <= '1' ; 
                    wait for AxiStreamPeriod * 2; 
                    IridisTxCtrl.TxCtrlStrobe <= '0' ; 
					          wait for AxiStreamPeriod * 2; 
					          IridisTxCtrl.ClrMask.crcErrForce    <= '0';
					show("CRC  Error  inserted "); 
    end CrCError; 
------------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
    procedure CtlCodeError(signal IridisTxCtrl: inout tIridisSfTxCtrl) is 
                begin 
                    IridisTxCtrl.ClrMask.ctlcodeErrForce <= '1';
                    IridisTxCtrl.TxCtrlStrobe <= '1' ; 
                    wait for AxiStreamPeriod * 2; 
                    IridisTxCtrl.TxCtrlStrobe <= '0' ; 
					          wait for AxiStreamPeriod * 2; 
					          IridisTxCtrl.ClrMask.ctlcodeErrForce<= '0';
					show("Control Code Double Bit Error inserted (p0, d3) "); 
    end CtlCodeError; 
----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
    procedure ICFieldError(signal IridisTxCtrl: inout tIridisSfTxCtrl) is 
                begin 
                    IridisTxCtrl.ClrMask.ctlcodeErrForce <= '1';
                    IridisTxCtrl.TxCtrlStrobe <= '1' ; 
                    wait for AxiStreamPeriod * 2; 
                    IridisTxCtrl.TxCtrlStrobe <= '0' ; 
					          wait for AxiStreamPeriod * 2; 
					          IridisTxCtrl.ClrMask.ctlcodeErrForce<= '0';
					show("IC counter Error inserted "); 
    end ICFieldError; 
----------------------------------------------------------------------------------------- 
     procedure TxClearSticky (signal iridisSfTxCtrl : out  tIridisSfTxCtrl) is 
----------
           begin 
                    iridisSfTxCtrl.ClrMask.ffoPositionErr <= '1';
                    iridisSfTxCtrl.ClrMask.ffoDetected    <= '1';
                    iridisSfTxCtrl.ClrMask.sofPositionErr <= '1';
                    iridisSfTxCtrl.ClrMask.sofMissingErr  <= '1';
                    iridisSfTxCtrl.ClrMask.eofPositionErr <= '1';
                    iridisSfTxCtrl.ClrMask.eofMissingErr  <= '1';
                    iridisSfTxCtrl.ClrMask.fifoOvrErr     <= '1';
                    iridisSfTxCtrl.ClrMask.fifoUdfErr     <= '1';
                    iridisSfTxCtrl.TxCtrlStrobe           <= '1';
                    wait for AxiStreamPeriod * 2; 
                    iridisSfTxCtrl.TxCtrlStrobe           <= '0';
                    wait for AxiStreamPeriod * 2; 
                    iridisSfTxCtrl.ClrMask.ffoPositionErr <= '0';
                    iridisSfTxCtrl.ClrMask.ffoDetected    <= '0';
                    iridisSfTxCtrl.ClrMask.sofPositionErr <= '0';
                    iridisSfTxCtrl.ClrMask.sofMissingErr  <= '0';
                    iridisSfTxCtrl.ClrMask.eofPositionErr <= '0';
                    iridisSfTxCtrl.ClrMask.eofMissingErr  <= '0';
                    iridisSfTxCtrl.ClrMask.fifoOvrErr     <= '0';
                    iridisSfTxCtrl.ClrMask.fifoUdfErr     <= '0';
        end TxClearSticky;
  
----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 

     procedure RxClearSticky(signal iridisSfRxCtrl: inout tIridisSfRxCtrl) is 
        begin 
             iridisSfRxCtrl.ClrMask.uccErr         <= '1';
             iridisSfRxCtrl.ClrMask.iimErr         <= '1';
             iridisSfRxCtrl.ClrMask.ffoMissingErr  <= '1';
             iridisSfRxCtrl.ClrMask.ffoPositionErr <= '1'; 
             iridisSfRxCtrl.ClrMask.eofPositionErr <= '1';
             iridisSfRxCtrl.ClrMask.eofMissingErr  <= '1';
             iridisSfRxCtrl.ClrMask.fifoOvrErr     <= '1';
             iridisSfRxCtrl.ClrMask.fifoUdfErr     <= '1';
             iridisSfRxCtrl.RxCtrlStrobe           <= '1';
             wait for AxiStreamPeriod * 2; 
			 show (" Clear Rx Sticky flags ");
             iridisSfRxCtrl.RxCtrlStrobe           <= '0';
             wait for AxiStreamPeriod * 2; 
            iridisSfRxCtrl.ClrMask.uccErr         <= '0';
            iridisSfRxCtrl.ClrMask.iimErr         <= '0';   
            iridisSfRxCtrl.ClrMask.ffoMissingErr  <= '0';   
            iridisSfRxCtrl.ClrMask.ffoPositionErr <= '0';   
            iridisSfRxCtrl.ClrMask.eofPositionErr <= '0';   
            iridisSfRxCtrl.ClrMask.eofMissingErr  <= '0';   
            iridisSfRxCtrl.ClrMask.fifoOvrErr     <= '0';   
            iridisSfRxCtrl.ClrMask.fifoUdfErr     <= '0';   
         end RxClearSticky;
----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
  procedure DataGenStart (signal bc0     : in  sl;
                          signal StartGen: out sl) is
            begin 
              wait until (rising_edge(bc0)); 
              StartGen <= '1'; 
              wait  for AxiStreamPeriod * 2; 
			  show("====================================================================");
               show("Start Frame Transmission");
			  show("====================================================================");
              StartGen  <= '0';
  end DataGenStart;
 
-- ----------------------------------------------------------------------------------------- 
  ------------------------------------------------------------------------------------
    procedure  ErrorCnfg ( constant TypeOfError : in ErrorType := NORMAL; 
                           constant ErrorPosition : in integer := 300;
						   signal cfgErr : out  ConfigErrorType )
                        is 
                        begin 
	                       cfgErr.ErrorPosition <= ErrorPosition;
	                       cfgErr.TypeError <= TypeOfError;--;

    end ErrorCnfg;
 
------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
  procedure CtrlPulse  ( constant  NumberOfClkCycles_C: in integer;
                         signal   TxCtrlStrobeAux : out sl)
            is 
            begin
            TxCtrlStrobeAux <= '1';
             wait for  AxiStreamPeriod * NumberOfClkCycles_C;   
            TxCtrlStrobeAux <= '0';
  end CtrlPulse;
-- -- 
------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
   procedure IridisTxCtrlSet (constant IdleMethod:  in sl; 
                              constant resyncDly :  in slv (15 downto 0);
                              constant LinkInfo1 :  in slv (31 downto 0);
                              constant LinkInfo2 :  in slv (31 downto 0);
                              constant ClrMask   :  in slv (7  downto 0); 
                              signal TxIridisCtrl : out tIridisSfTxCtrl)
             is 
             begin 
                TxIridisCtrl.IdleMethod  <= IdleMethod; 
                TxIridisCtrl.resyncDly   <= resyncDly; 
                TxIridisCtrl.linkInfo(0) <= LinkInfo1; 
                TxIridisCtrl.linkInfo(1) <= LinkInfo2; 
                TxIridisCtrl.ClrMask.ffoPositionErr    <= ClrMask(0);
                TxIridisCtrl.ClrMask.ffoDetected       <= ClrMask(1);
                TxIridisCtrl.ClrMask.sofPositionErr     <= ClrMask(2);
                TxIridisCtrl.ClrMask.sofMissingErr      <= ClrMask(3);
                TxIridisCtrl.ClrMask.eofPositionErr     <= ClrMask(4);
                TxIridisCtrl.ClrMask.eofMissingErr      <= ClrMask(5);
                TxIridisCtrl.ClrMask.fifoOvrErr         <= ClrMask(6);
                TxIridisCtrl.ClrMask.fifoUdfErr         <= ClrMask(7);
      show("====================================================================");
      show ("Set  IridisTxCtrl config");
      show("====================================================================");
   if IdleMethod = '0' then 
     show(" Idle Method    : 1");
  else 
     show(" Idle Method    : 2");
   end if;
     show(" Resync Dly     : " & hstr(resyncDly));
     show(" Link Info 1    : " & hstr(LinkInfo1));
     show(" Link Info 2    : " & hstr(LinkInfo2));
     show("====================================================================");
  end IridisTxCtrlSet;
------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------- 
   procedure IridisRxCtrlSet (constant IndxCorrBlockEn:  in sl; 
                              constant mgtRstEn     :  in sl;
                              constant AOAEn        :  in sl;
                              constant resync       :  in sl;    -- Type of Rst, needs a pulse 
                              constant resyncDly    :  in slv (15  downto 0); 
                              constant releaseDly   :  in slv (15  downto 0); 
                              constant ClrMask      :  in slv (7   downto 0); 
                              signal RxIridisCtrl : out tIridisSfRxCtrl)
             is
               variable locTest : integer :=  0;
             begin 
                RxIridisCtrl.ICBlockEn      <= IndxCorrBlockEn;        --IC enable
                RxIridisCtrl.mgtRstEn       <= mgtRstEn;               --enable MGT resets on resyncs
                RxIridisCtrl.AOAEn         <= AOAEn;                  --enable Automatic Orbit Alignment
                RxIridisCtrl.resync         <=  resync;                --resync command
                RxIridisCtrl.resyncDly      <= resyncDly;              --delay from TCDS BC0 to resync release at channel in algo clocks
                RxIridisCtrl.releaseDly     <= releaseDly;             --delay from TCDS BC0 to Rx FIFO reads at channel in algo clocks
                RxIridisCtrl.ClrMask.uccErr            <= ClrMask(0);  --unknown control code error
                RxIridisCtrl.ClrMask.iimErr            <= ClrMask(1);  --invalid idle method (method #1) error
                RxIridisCtrl.ClrMask.ffoMissingErr     <= ClrMask(2);  --FFO not detected at start of orbit position
                RxIridisCtrl.ClrMask.ffoPositionErr    <= ClrMask(3);  --FFO encountered in unexpected position
                RxIridisCtrl.ClrMask.eofPositionErr    <= ClrMask(4);  --EOF (from CRCV control word) encountered in unexpected position
                RxIridisCtrl.ClrMask.eofMissingErr     <= ClrMask(5);  --EOF (from CRCV control word) not in expected position
                RxIridisCtrl.ClrMask.fifoOvrErr        <= ClrMask(6);  --FIFO overrun error
                RxIridisCtrl.ClrMask.fifoUdfErr        <= ClrMask(7);  --FIFO underrun error
       show("====================================================================");
       show("Set default IridisRxCtrl config");
       show("====================================================================");
       if IndxCorrBlockEn = '0' then 
        show(" Index Corrector           : Disabled ");
       else 
        show(" Index Corrector           : Enabled ");
       end if;
       if mgtRstEn  = '0' then 
        show(" MGT reset on Resync       : Disabled ");
       else 
        show(" MGT reset on Resync       : Enabled ");
        end if;
       if AOAEn  = '0' then 
        show(" Automatic Orbit Alignment : Disabled ");
       else 
        show(" Automatic Orbit Alignment : Enabled ");
      end if;
       if resync  = '0' then 
        show(" Resync Command            : Disabled ");
       else 
        show(" Resync Command            : Enabled ");
        end if;
        show(" Resync Dly               : " & hstr(resyncDly));
        show(" Release Dly              : " & hstr(releaseDly));
      show("====================================================================");
	  -- 
	  -- 
	 end IridisRxCtrlSet;

----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
    
   procedure RxSyncRecovery ( signal IridisSfRxCtrl : inout tIridisSfRxCtrl; 
                              signal IridisSfRxStat : in tIridisSfRxStat) 
             is 
             begin
			  null;
             show("====================================================================");
	           show(" **********  Rx Resync Command **********"); 
	           show("====================================================================");
                 IridisSfRxCtrl.resync <= '1'; 
			     wait for AxiStreamPeriod * 4; 
			     IridisSfRxCtrl.resync <= '0';
	             wait for 180 us; 
	             RxCountersStatus(IridisSfRxStat);
	             wait for 10 ns; 
	             RxClearSticky(IridisSfRxCtrl);
	             wait for 500 ns; 
	             RxCountersStatus(IridisSfRxStat);
             end RxSyncRecovery;
----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
   procedure LinkBufRst (signal linkBufCtrlTb : out tLinkBufCtrl) 
        is 
           begin 
             show("====================================================================");
	           show(" **********  Link Buffer Reset                            **********"); 
	           show("====================================================================");
              linkBufCtrlTb.fsmrst <= '1'; 
              wait for 50 ns; 
              linkBufCtrlTb.fsmrst <= '0'; 
          end LinkBufRst; 
      
----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
 
 procedure LinkBufCfgMode ( signal linkBufCtrlTb : out tLinkBufCtrl; 
                              constant linkBufMode : in sl  )
        is 
           begin 
             wait for 1 ns; 
              linkBufCtrlTb.mode <= linkBufMode; 
          end LinkBufCfgMode; 
      
    -- =====================================================
	-- = S H O W   t h e  T I M E  screen  and  text file  =
    -- =====================================================
	    procedure  show (constant  str : in string )
		   is 
		      variable l1: line; 
			  variable l2: line; 
		  begin 
		  
		-- ============================================================
		--   W  r i t e   i n   t h e   s i m u l a t i o n  F I L E   =
		-- ============================================================
		     write (l1, string'("At : " ));
		     write (l1, now);
		     write (l1, string'("(")); 
		     write (l1, now/AxiStreamPeriod ); 
		     write (l1, string'("clocks),")); 
		     write (l1, str); 
		     writeline (SimLog, l1); 
		-- =============================================================
		-- = W R I T E   I N  T H E  S I M U L A T O R    S C R  E E N =
		--==============================================================
		      write (l2, string'("At: "));
		      write (l2, now);
		      write (l2,string'("("));
		      write (l2, now/AxiStreamPeriod );
		      write (l2, string '(" Clocks)." ));
		      write (l2,str); 
		      writeline (output, l2); 
		end show; 
		
----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
    
 

----------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------- 
end package body CSPSimCtrlPkg; 
