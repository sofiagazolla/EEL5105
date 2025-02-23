library ieee;
use ieee.std_logic_1164.all;
entity testbench is
end testbench;
architecture tb of testbench is
    signal SA, SB, SC, SG, SS : std_logic;
    component full is port ( 
      A,B,C: in std_logic;
      G,S: out std_logic );
    end component;
begin
    DUT : full port map (A => SA, B => SB, C => SC, G => SG, S => SS);
    SA <= '0', '1' after 40 ns;
    SB <= '0', '1' after 20 ns, '0' after 40 ns, '1' after 60 ns;
    SC <= '0', '1' after 10 ns, '0' after 20 ns, '1' after 30 ns, '0' after 40 ns, '1' after 50 ns, '0' after 60 ns, '1' after 70 ns, '0' after 80 ns;
    end tb;