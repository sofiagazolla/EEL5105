library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comp is
    port (
        seq_user : in STD_LOGIC_VECTOR(9 downto 0); 
        seq_reg : in STD_LOGIC_VECTOR(9 downto 0); 
        seq_mask : out STD_LOGIC_VECTOR(9 downto 0) 
    );
end comp;

architecture behv of comp is
begin
    process(seq_reg)
    begin
        for i in 0 to 9 loop
            seq_mask(i) <= seq_user(i) and seq_reg(i); -- Compara bit a bit da sequência que o usuário digitou com a sequência escolhida no início do jogo
        end loop;
    end process;

end behv;