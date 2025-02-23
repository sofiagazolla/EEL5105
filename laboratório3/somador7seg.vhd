library ieee;
use ieee.std_logic_1164.all;

entity somador7seg is
port (A,B: in std_logic_vector(3 downto 0);
      A1, A0, B1, B0, S1, S0: out std_logic_vector(6 downto 0)
	);
end somador7seg;

architecture rtl of somador7seg is

    signal concatA, concatB, concatS: std_logic_vector(6 downto 0);
    signal saidasomador: std_logic_vector(4 downto 0);
    
    component somador is 
        port (A,B: in std_logic_vector(3 downto 0);
              S: out std_logic_vector(4 downto 0));
    end component;
    
    component bin7seg99 is 
        port (binaryin: in std_logic_vector (6 downto 0);
            hex1, hex0: out std_logic_vector (6 downto 0));
    end component;


begin
    
    concatA <= "000" & A;
    
    B7A: bin7seg99 port map ( concatA, A1, A0 );
    
    concatB <= "000" & B;
    
    B7B: bin7seg99 port map ( concatB, B1, B0 );
    
    concatS <= "00" & saidasomador;
    
    B7S: bin7seg99 port map ( concatS, S1, S0 );
    
end rtl;
