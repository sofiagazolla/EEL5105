library ieee;
use ieee.std_logic_1164.all;
entity testbench is
end testbench;

architecture tb of testbench is
    signal SB, SC : std_logic;
    signal SG, SS : std_logic_vector (7 downto 0);
    signal meuclock: std_logic := '0';
    
    component registrador is port ( 
        CLK,EN,RST: in std_logic;
	    D: in std_logic_vector(7 downto 0);
	    Q: out std_logic_vector(7 downto 0));
    end component;

begin
    DUT : registrador port map (CLK => meuclock, EN => SB, RST => SC, D => SG, Q => SS);
    meuclock <= not meuclock after 5 ns;
    SC <= '0', '1' after 15 ns;
    SB <= '0', '1' after 5 ns;
    SG <= "00000000", "11111111" after 10 ns, "00000000" after 20 ns, "11111111" after 30 ns, "00000000" after 50 ns, "11111111" after 60 ns;
    end tb;