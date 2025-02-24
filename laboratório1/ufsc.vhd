library ieee;
use ieee.std_logic_1164.all;

entity ufsc is
port(
	HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7	: out std_logic_vector(6 downto 0)
	);
end ufsc;

architecture rtl of ufsc is
begin

    HEX3 <= "1000001"; 
    HEX2 <= "0001110"; 
    HEX1 <= "0010010"; 
    HEX0 <= "1000110"; 

end rtl;