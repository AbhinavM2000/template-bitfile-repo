library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiStreamPkg.all;

entity algoSlice1 is
  port (
    axisClk        : in  sl;
    AxiStreamInGA  : in  AxiStreamMasterArray(0 to 15);
    AxiStreamInGB  : in  AxiStreamMasterArray(0 to 3);
    AxiStreamOutGA : out AxiStreamMasterArray(0 to 3);
    AxiStreamOutGB : out AxiStreamMasterArray(0 to 7)
    );
end algoSlice1;

architecture rtl of algoSlice1 is

  signal sAxiStreamInGA    : AxiStreamMasterArray(0 to 15);
  signal sAxiStreamInGADly : AxiStreamMasterArray(0 to 15);
  signal sAxiStreamInGB    : AxiStreamMasterArray(0 to 3);

  signal sAxiStreamGAproc : AxiStreamMasterArray(0 to 3);
  signal sAxiStreamGAdly  : AxiStreamMasterArray(0 to 3);

  signal sAxiStreamGBproc : AxiStreamMasterArray(0 to 7);
  signal sAxiStreamGBdly  : AxiStreamMasterArray(0 to 7);

begin

-----------------------------------------------------------
-- input delay adjustments
  -- dly 10
  genIGADly : for i in 0 to 15 generate
    U_AxiStreamRegBank : entity work.AxiStreamRegBank
      generic map (
        PATH_REG_CNT_G => 10
        )
      port map(
        axisClk      => axisClk,
        axiStreamIn  => AxiStreamInGA(i),
        axiStreamOut => sAxiStreamInGADly(i)
        );
  end generate;

  -- no delay for IGB
  sAxiStreamInGB <= AxiStreamInGB;

-----------------------------------------------------------
-- output group processing

  -- Group A processing
  genOGA : for i in 0 to 3 generate
    sAxiStreamGAproc(i).tData <= sAxiStreamInGADly(i*4).tData or
                                 sAxiStreamInGB(i).tData;
  end generate;

  -- Group B processing
  genOGB : for i in 0 to 7 generate
    sAxiStreamGBproc(i).tData <= sAxiStreamInGADly(i*2).tData or
                                 sAxiStreamInGADly(i*2+1).tData or
                                 sAxiStreamInGB(i/2).tData;
  end generate;

-----------------------------------------------------------
-- output delay adjustments
  genOGADly : for i in 0 to 3 generate
    U_AxiStreamRegBank : entity work.AxiStreamRegBank
      generic map (
        PATH_REG_CNT_G => 40
        )
      port map(
        axisClk      => axisClk,
        axiStreamIn  => sAxiStreamGAproc(i),
        axiStreamOut => sAxiStreamGAdly(i)
        );
  end generate;

  genOGBDly : for i in 0 to 7 generate
    U_AxiStreamRegBank : entity work.AxiStreamRegBank
      generic map (
        PATH_REG_CNT_G => 50
        )
      port map(
        axisClk      => axisClk,
        axiStreamIn  => sAxiStreamGBproc(i),
        axiStreamOut => sAxiStreamGBDly(i)
        );
  end generate;

-----------------------------------------------------------
  -- output assignment 
  axiStreamOutGA <= sAxiStreamGAdly;
  axiStreamOutGB <= sAxiStreamGBdly;

end rtl;
