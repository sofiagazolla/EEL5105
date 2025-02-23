library ieee;
use ieee.std_logic_1164.all;

entity testbench is port (
   clock: in std_logic;
   reset: in std_logic;
   x: out std_logic_vector (2 downto 0)
   );
end testbench;

architecture tb of testbench is
    signal A: std_logic_vector (2 downto 0);
    signal rst: std_logic;
    signal meuclock: std_logic := '0';
    component FSM1 is port ( 
        clock: in std_logic;
        reset: in std_logic;
        x: out std_logic_vector (2 downto 0)
   );
    end component;
begin
    DUT : FSM1 port map (clock => meuclock, reset => rst, x => A);
    meuclock <= not meuclock after 5 ns;
    rst <= '0', '1' after 100 ns, '0' after 200 ns, '1' after 300 ns;
    end tb;