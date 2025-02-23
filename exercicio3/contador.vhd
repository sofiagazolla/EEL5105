library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;
entity contador is port ( 
  CLK, EN, CLEAR: in std_logic;
  S: out std_logic_vector(4 downto 0);
  MAX: out std_logic);
end contador;
architecture behv of contador is
  signal cnt: std_logic_vector(4 downto 0) := "00000";
begin
    process(CLK)
    begin
        if (CLEAR = '1') then
            cnt <= "00000";
        elsif (CLK'event and CLK = '1') then
            if (EN = '1') then 
                if cnt /= "10011" then 
                    cnt <= cnt + "00001";
                end if;
            end if;
        end if;
    end process;
    S <= cnt;
    MAX <= '1' when cnt = "10011" else 
          '0';
end behv;