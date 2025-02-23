library IEEE;
use IEEE.Std_Logic_1164.all;

entity half is
port (A: in std_logic;
      B: in std_logic;
      S: out std_logic;
      C: out std_logic
      );
end half;

architecture circuito_logico of half is
  signal D,E,F: std_logic;
begin 
  S <= A xor B;
  C <= A and B; 
end circuito_logico;
