library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity counter_time is port ( 
  enable, reset, clock: in std_logic;
    load: in std_logic_vector(3 downto 0);
    end_time: out std_logic;
    tempo: out std_logic_vector(3 downto 0)
  );
end counter_time;

architecture behv of counter_time is
  signal cnt: std_logic_vector(3 downto 0) := "0000";
begin
  process(Clock, reset)
  begin
    if reset = '1' then
        cnt <= "0000";
    elsif (Clock'event and Clock = '1') then
        if (enable = '1') then
           cnt <= cnt + "0001";
        end if;
    end if;
  end process;
  tempo <= cnt;
  end_time <= '1' when cnt = load else
         '0';
end behv;