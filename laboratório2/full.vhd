library IEEE;
use IEEE.Std_Logic_1164.all;

entity full is
port (A: in std_logic;
      B: in std_logic;
      C: in std_logic;
      G: out std_logic;
      S: out std_logic
      );
end full;

architecture circuito_logico of full is
  signal D,E,F: std_logic;
begin 
  D <= A xor B;
  S <= D xor C;
  E <= D and C; 
  F <= A and B;
  G <= E or F;
end circuito_logico;
