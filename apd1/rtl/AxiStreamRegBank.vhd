--shift register delay process for an axiStream

library ieee;
use IEEE.STD_LOGIC_1164.all;

library surf;
use surf.StdRtlPkg.all;
use surf.AxiStreamPkg.all;

entity AxiStreamRegBank is
  generic (
    TPD_G          : time    := 1ns;
    PATH_REG_CNT_G : natural := 2
    );
  port (
    axisClk      : in  sl;
    axiStreamIn  : in  AxiStreamMasterType;
    axiStreamOut : out AxiStreamMasterType
    );
end entity AxiStreamRegBank;

architecture rtl of AxiStreamRegBank is

  signal axiStreamRegPath : AxiStreamMasterArray(0 to PATH_REG_CNT_G);

begin

  --registered shift process
  process (axisclk)
  begin
    if (rising_edge(axisClk)) then
      for i in 0 to PATH_REG_CNT_G-1 loop
        axiStreamRegPath(i+1) <= axiStreamRegPath(i);  --shift stream 1 register
      end loop;
      axiStreamRegPath(0) <= axiStreamIn;              --assign first element
    end if;
  end process;

                                        --combinatorial assignment for output stream
  axiStreamOut <= axiStreamRegPath(PATH_REG_CNT_G-1);

end rtl;

