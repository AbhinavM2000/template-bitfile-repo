--====================================================================
-- Simple counter to produce a strobe once per orbit based on a bunch
-- clock.
--====================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.tcds2_bx_and_orbit_pkg.all;

--==================================================

entity orbit_strobe_generator is
  port (
    reset_i : in std_logic;

    -- LHC bunch clock input.
    bunch_clock_i : in std_logic;
    -- LHC strobe input (for alignment).
    orbit_strobe_i : in std_logic;
    -- Expected BX number of incoming strobe.
    expected_strobe_bx_i : in bx_num;
    -- Desired BX number of outgoing strobe.
    desired_strobe_bx_i : in bx_num;
    -- Current bunch crossing number output (after alignment).
    bx_number_o : out bx_num;
    -- Current orbit number output (after alignment).
    orbit_number_o : out orbit_num;
    -- Local strobe output (after alignment).
    orbit_strobe_o : out std_logic
  );
end entity orbit_strobe_generator;

--==================================================

architecture arch of orbit_strobe_generator is

  signal bx_cnt : bx_num;
  signal orbit_cnt : orbit_num;
  signal orbit : std_logic := '0';

  attribute mark_debug : string;
  attribute mark_debug of reset_i : signal is "true";
  attribute mark_debug of bunch_clock_i : signal is "true";
  attribute mark_debug of orbit_strobe_i : signal is "true";
  attribute mark_debug of expected_strobe_bx_i : signal is "true";
  attribute mark_debug of desired_strobe_bx_i : signal is "true";
  attribute mark_debug of bx_number_o : signal is "true";
  attribute mark_debug of orbit_number_o : signal is "true";
  attribute mark_debug of orbit_strobe_o : signal is "true";
  attribute mark_debug of bx_cnt : signal is "true";
  attribute mark_debug of orbit_cnt : signal is "true";
  attribute mark_debug of orbit : signal is "true";

begin
  process (bunch_clock_i) is
  begin
    if rising_edge(bunch_clock_i) then
      if reset_i = '1' then
        bx_cnt <= C_LHC_MIN_BX_NUM;
        orbit_cnt <= (others => '0');
        orbit <= '0';
      else
        -- Update BX number. Enforce orbit alignment if necessary.
        if orbit_strobe_i = '1' then
          bx_cnt <= next_bx(expected_strobe_bx_i);
        else
          bx_cnt <= next_bx(bx_cnt);
        end if;
        -- See if orbit strobe needs to fire.
        if next_bx(bx_cnt) = desired_strobe_bx_i then
          orbit <= '1';
          orbit_cnt <= orbit_cnt + 1;
        else
          orbit <= '0';
          orbit_cnt <= orbit_cnt;
        end if;
      end if;
    end if;

    bx_number_o    <= bx_cnt;
    orbit_number_o <= orbit_cnt;
    orbit_strobe_o <= orbit;

  end process;

end architecture arch;

--====================================================================
