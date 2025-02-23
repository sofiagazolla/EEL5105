library ieee;
use ieee.std_logic_1164.all;
entity testbench is
end testbench;
architecture tb of testbench is
    signal SB, SC, SS : std_logic;
    signal SG: std_logic_vector (4 downto 0);
    signal meuclock: std_logic := '0';
    component contador is port ( 
        CLK, EN, CLEAR: in std_logic;
        S: out std_logic_vector(4 downto 0);
        MAX: out std_logic);
    end component;
begin
    DUT: contador port map (CLK => meuclock, EN => SB, CLEAR => SC, S => SG, MAX => SS);
    meuclock <= not meuclock after 5 ns;
    SB <= '0', '1' after 15 ns;
    SC <= '1', '0' after 40 ns;
    end tb;