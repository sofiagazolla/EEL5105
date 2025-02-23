library IEEE;
use IEEE.Std_Logic_1164.all;

entity C2to7seg is
port (C2: in std_logic_vector(3 downto 0);
      sinal: out std_logic ;
      s7seg: out std_logic_vector(6 downto 0)
     );
end C2to7seg;

architecture soma4 of C2to7seg is
 signal S1: std_logic_vector (3 downto 0);
 signal S2: std_logic_vector (3 downto 0);
 
 component decod is
  port (C:  in std_logic_vector(3 downto 0);
      F:  out std_logic_vector(6 downto 0) 
      );
 end component; 
 
component mux is
  port (A:  in std_logic_vector(3 downto 0);
      B:  in std_logic_vector(3 downto 0);
      C:  in std_logic ;
      F:  out std_logic_vector(3 downto 0) 
      );
 end component;
 
 component Compl2 is
  port (X:  in std_logic_vector(3 downto 0);
      Y:  out std_logic_vector(3 downto 0)
      );
 end component;
 
begin

sinal <= C2(3);

COMP: Compl2 port map (C2, S1);
LALA: mux port map (C2, S1, C2(3), S2);
LULU: decod port map (S2, s7seg);

end soma4;