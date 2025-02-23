library IEEE;
use IEEE.Std_Logic_1164.all;

entity halffull is
port (A: in std_logic;
      B: in std_logic;
      C: in std_logic;
      D: in std_logic;
      S: out std_logic;
      R: out std_logic;
      T: out std_logic
      );
end halffull;

architecture circuito_logico of halffull is
 signal E,F,G,H: std_logic;
begin 
  S <= B xor D;
  E <= D and B;
  F <= A xor C; 
  G <= F and E;
  H <= C and A;
  R <= F xor E; 
  T <= G or H;
  end circuito_logico;
