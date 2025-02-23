library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity counter0to10 is port ( 
  enable, reset, clock: in std_logic;
  round: out std_logic_vector(3 downto 0);
  end_round: out std_logic );
end counter0to10;

architecture behv of counter0to10 is
  signal cnt: std_logic_vector(3 downto 0) := "0000";
begin
  process(CLock)
  begin
  if (reset = '1') then
         cnt <= "0000";
    elsif (CLock'event and CLock = '1') then
        if (enable = '1') then
            if (cnt < "1010") then
                cnt <= cnt + "0001";
        end if;
        end if;
    end if;
  end process;
   round <= cnt;
   end_round <= '1' when cnt = "1010" else
         '0';
end behv;
