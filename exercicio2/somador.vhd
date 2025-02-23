library IEEE;
use IEEE.Std_Logic_1164.all;
entity somador is
port (A,B: in std_logic_vector(3 downto 0);
      S: out std_logic_vector(4 downto 0)
     );
end somador;
architecture soma4 of somador is
 signal C0,C1,C2: std_logic;
 component soma8 is
  port (B:  in std_logic_vector(7 downto 0);
      S:  out std_logic_vector(7 downto 0)
     );
 end component; 
component div4 is
  port (B:  in std_logic_vector(7 downto 0);
      D:  out std_logic_vector(7 downto 0)
     );
 end component;
begin
 S8: soma8 port map (A, B, S(7 downto 0), C0);
 D4: div4 port map (A, B, C0, S(8 downto 8), C1);
end soma4;
