library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity test2 is
end test2;
architecture tb of test2 is
    signal SA: std_logic_vector(3 downto 0) := "0000";
    signal SB: std_logic_vector(4 downto 0);
    signal cnt: std_logic_vector(3 downto 0);
    component mult3 is port ( 
      X: in std_logic_vector(3 downto 0);
      Y: out std_logic_vector(4 downto 0) );
    end component;
begin
    DUT : mult3 port map (X => SA, Y => SB);
    process
     constant period: time := 10 ns;
     begin
         for k in 1 to 15 loop
            wait for period;
            SA <= SA + '1';
         end loop;
         wait;
    end process;
end tb;