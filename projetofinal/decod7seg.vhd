library IEEE;
use IEEE.Std_Logic_1164.all;

entity decod7seg is
port (X:  in std_logic_vector(3 downto 0);
      Y:  out std_logic_vector(6 downto 0) );
end decod7seg;

architecture decod of decod7seg is
begin 
  Y <= "1000000" when X = "0000" else    -- 0
       "1111001" when X = "0001" else    -- 1
       "0100100" when X = "0010" else    -- 2
       "0110000" when X = "0011" else    -- 3
       "0011001" when X = "0100" else    -- 4
       "0010010" when X = "0101" else    -- 5
       "0000010" when X = "0110" else    -- 6
       "1111000" when X = "0111" else    -- 7
       "0000000" when X = "1000" else    -- 8
       "0010000" when X = "1001" else    -- 9
       "0001000" when X = "1010" else    -- A
       "0000011" when X = "1011" else    -- B
       "1000110" when X = "1100" else    -- C
       "0100001" when X = "1101" else    -- D
       "0000110" when X = "1110" else    -- E
       "0001110" when X = "1111" else    -- F
       "1111111";
end decod;
