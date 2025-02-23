library IEEE;
use IEEE.Std_Logic_1164.all;
entity somador is
port (A,B: in std_logic_vector(3 downto 0);
      S: out std_logic_vector(4 downto 0)
     );
end somador;
architecture soma4 of somador is
 signal C0,C1,C2: std_logic;
 component halfadder is
  port (A: in std_logic;
        B: in std_logic;
        S: out std_logic;
        Cout: out std_logic);
 end component; 
component fulladder is
  port (A: in std_logic;
        B: in std_logic;
        Cin: in std_logic;
        S: out std_logic;
        Cout: out std_logic);
 end component;
begin
 HA: halfadder port map (A(0),B(0),S(0),C0);
 FA1: fulladder port map (A(1),B(1),C0,S(1),C1);
 FA2: fulladder port map (A(2),B(2),C1,S(2),C2);
 FA3: fulladder port map (A(3),B(3),C2,S(3),S(4));
end soma4;
