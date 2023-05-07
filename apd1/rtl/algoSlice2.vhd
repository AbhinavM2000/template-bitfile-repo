library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiStreamPkg.all;

entity algoSlice2 is
  port (
    axisClk        : in  sl;
    AxiStreamInGA  : in  AxiStreamMasterArray(0 to 15);
    AxiStreamInGB  : in  AxiStreamMasterArray(0 to 7);
    AxiStreamOutGA : out AxiStreamMasterArray(0 to 7);
    AxiStreamOutGB : out AxiStreamMasterArray(0 to 7)
    );
end algoSlice2;

architecture rtl of algoSlice2 is

  signal sAxiStreamInGA       : AxiStreamMasterArray(0 to 15);
  signal sAxiStreamInGADly20  : AxiStreamMasterArray(0 to 15);
  signal sAxiStreamInGADly100 : AxiStreamMasterArray(0 to 15);

  signal sAxiStreamInGB : AxiStreamMasterArray(0 to 7);

  signal sAxiStreamGBproc : AxiStreamMasterArray(0 to 7);
  signal sAxiStreamGBdly  : AxiStreamMasterArray(0 to 7);

begin

-----------------------------------------------------------
-- input delay adjustments

  -- 20 dly
  genIGADly20 : for i in 0 to 15 generate
    U_AxiStreamRegBank : entity work.AxiStreamRegBank
      generic map (
        PATH_REG_CNT_G => 20
        )
      port map(
        axisClk      => axisClk,
        axiStreamIn  => AxiStreamInGA(i),
        axiStreamOut => sAxiStreamInGADly20(i)
        );
  end generate;

  -- 100 dly
  genIGADly100 : for i in 0 to 15 generate
    U_AxiStreamRegBank : entity work.AxiStreamRegBank
      generic map (
        PATH_REG_CNT_G => 100
        )
      port map(
        axisClk      => axisClk,
        axiStreamIn  => AxiStreamInGA(i),
        axiStreamOut => sAxiStreamInGADly100(i)
        );
  end generate;

  -- no delay for IGB
  sAxiStreamInGB <= AxiStreamInGB;

-----------------------------------------------------------
-- output group processing

  -- Group B processing
  genOGB : for i in 0 to 7 generate
    sAxiStreamGBproc(i).tData <= (sAxiStreamInGADly100(i*2).tData or
                                  sAxiStreamInGADly100(i*2+1).tData) xor
                                 sAxiStreamInGB(i).tData;
  end generate;

-----------------------------------------------------------
-- output delay adjustments

  -- 20 dly
  genOGBDly : for i in 0 to 7 generate
    U_AxiStreamRegBank : entity work.AxiStreamRegBank
      generic map (
        PATH_REG_CNT_G => 20
        )
      port map(
        axisClk      => axisClk,
        axiStreamIn  => sAxiStreamGBproc(i),
        axiStreamOut => sAxiStreamGBDly(i)
        );
  end generate;

-----------------------------------------------------------
  -- output assignment 
  genOGA : for i in 0 to 7 generate
    axiStreamOutGA(i) <= sAxiStreamInGADly20(i*2);
  end generate;

  axiStreamOutGB <= sAxiStreamGBdly;

end rtl;
