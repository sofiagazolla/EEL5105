library IEEE;
use IEEE.Std_Logic_1164.all;

entity halfadder is
port (A: in std_logic;
      B: in std_logic;
      S: out std_logic;
      Cout: out std_logic
      );
end halfadder;

architecture circuito_logico of halfadder is
  signal D,E,F: std_logic;
begin 
  S <= A xor B;
  Cout <= A and B; 
end circuito_logico;