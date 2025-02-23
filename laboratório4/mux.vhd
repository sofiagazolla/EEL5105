library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux is
port (A:  in std_logic_vector(3 downto 0);
      B:  in std_logic_vector(3 downto 0);
      C:  in std_logic ;
      F:  out std_logic_vector(3 downto 0) );
end mux;

architecture decod of mux is
begin 
  F <= A when C = '0' else 
       B ;
end decod;