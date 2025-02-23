library ieee;
use ieee.std_logic_1164.all;
entity testbench is
end testbench;
architecture tb of testbench is
    signal A: std_logic_vector (1 downto 0);
    signal rst: std_logic;
    signal meuclock: std_logic := '0';
    signal B1: std_logic;
    component estado is port ( 
        clock: in std_logic;
        reset: in std_logic;
        B: in std_logic;
        x: out std_logic_vector (1 downto 0)
   );
    end component;
begin
    DUT : estado port map (clock => meuclock, reset => rst, x => A, B => B1);
    meuclock <= not meuclock after 5 ns;
    B1 <= '0', '1' after 10 ns, '0' after 120 ns, '1' after 300 ns;
    rst <= '0', '1' after 80 ns, '0' after 100 ns, '1' after 300 ns;
    end tb;