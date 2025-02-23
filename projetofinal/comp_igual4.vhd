library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comp_igual4 is
    port (
        soma : in std_logic_vector(3 downto 0); 
        status: out std_logic
    );
end comp_igual4;

architecture behv of comp_igual4 is 
begin
    process(soma)
    begin
        if soma = "0100" then  -- Verifica se a soma do número de 1s é igual a 4 
            status <= '1';  
        else
            status <= '0'; 
        end if;
    end process;
end behv;