library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2pra1_4bits is
    Port (
        sel : in std_logic; 
        x, y  : in std_logic_vector(3 downto 0); 
        saida : out std_logic_vector(3 downto 0) 
    );
end mux2pra1_4bits;

architecture mux of mux2pra1_4bits is
begin
    process(sel, x, y)
    begin
        if sel = '1' then -- Se o sel for 1, a saída vai ser X
            saida <= x; 
        else
            saida <= y; -- Se o sel for 0, a saída vai ser Y
        end if;
    end process;
end mux;
