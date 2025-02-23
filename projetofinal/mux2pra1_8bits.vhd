library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2pra1_8bits is
    Port (
        sel : in std_logic; -- Determina qual vai ser a saída 
        x, y  : in std_logic_vector(7 downto 0); -- São as duas opções de saída 
        saida : out std_logic_vector(7 downto 0) 
    );
end mux2pra1_8bits;

architecture mux of mux2pra1_8bits is
begin
    process(sel, x, y)
    begin
        if sel = '1' then
            saida <= x; -- Se o sel for 1, a saída vai ser X
        else
            saida <= y; -- Se o sel for 0, a saída vai ser Y
        end if;
    end process;
end mux;
