library IEEE;
use IEEE.Std_Logic_1164.all;

entity exercicio is
port (A: in std_logic;
      B: in std_logic;
      C: in std_logic;
      D: in std_logic;
      W: out std_logic;
      X: out std_logic;
      Y: out std_logic;
      Z: out std_logic
      );
end exercicio;

architecture circuito_logico of exercicio is
begin 
  W <= ((not A) and C) or ((not A) and B) or (C and (not D)) or (A and (not B) and (not C));
  X <= (not A) or ((not B) and (not C) and (not D));
  Y <= ((not C) and (not D));
  Z <= ((not A) and (not C) and (not D)) or ((not A) and (not B));
end circuito_logico;