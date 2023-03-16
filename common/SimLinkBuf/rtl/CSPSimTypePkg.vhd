library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


Library surf;
use surf.StdRtlPkg.all;


package CSPSimTypePkg is 
  -----------------------------------------------------------------------------------
  constant ENABLED  : sl :=  '1'; 
  constant DISABLED : sl :=  '0';
  constant METHOD_1 : sl :=  '0'; 
  constant METHOD_2 : sl :=  '1'; 

  constant  AxiStreamPeriod : time  := 2.7777 ns ;
  
   
   --  Error Signals -- 
   type ErrorType is (
       NORMAL, 
       SINGLE_HDR_ERR, 
       DOUBLE_HDR_ERR, 
       INDX_NUMBER_ERRR, 
       SINGLE_CTRL_TYPE_ERR, 
       DOUBLE_CTRL_TYPE_ERR,
       SINGLE_DATA_ERR, 
       DOUBLE_DATA_ERR);
  --
     type ConfigErrorType is record 
     ErrorPosition : integer ;
     TypeError    : ErrorType;
  end record ConfigErrorType;
--
  type tClkMgrCfg is record
    CLKFBOUT_MULT_F  : real range 1.0 to 64.0;
    CLKOUT0_DIVIDE_F : real range 1.0 to 128.0;
    CLKOUT1_DIVIDE   : integer range 1 to 128;
	CLKOUT2_DIVIDE   : integer range 1 to 128;
  end record;

  type tClkMgrCfgArr is array (integer range <>) of tClkMgrCfg;

end package CSPSimTypePkg ; 
