library IEEE;
use IEEE.Std_Logic_1164.all;

entity fulladder is
port (A: in std_logic;
      B: in std_logic;
      Cin: in std_logic;
      S: out std_logic;
      Cout: out std_logic
      );
end fulladder;

architecture circuito_logico of fulladder is
  signal D,E,F: std_logic;
begin 
  D <= A xor B;
  S <= D xor Cin;
  E <= D and Cin; 
  F <= A and B;
  Cout <= E or F;
end circuito_logico;