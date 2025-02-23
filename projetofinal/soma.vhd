library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity soma is port ( 
    seq: in std_logic_vector(9 downto 0);
    soma_out: out std_logic_vector(3 downto 0)
  );
end soma;

architecture conta1 of soma is
begin
    process(seq)
        variable contaum : integer := 0;  -- Cria uma variável para armazenar o número de 0s na conta
    
    begin
        contaum := 0; -- Zera a variável
        for i in seq'range loop -- Percorre a entrada, bit a bit 
            if seq(i) = '1' then -- Se o bit for igual a 1, adiciona um ao contador
                contaum := contaum + 1;
            end if;
        end loop;
        soma_out <= std_logic_vector(to_unsigned(contaum, 4)); -- Converte o número de 1s em um número de 4 bits 
    end process;

end conta1;