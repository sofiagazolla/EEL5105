library ieee;
use ieee.std_logic_1164.all;

entity Reg8bits is port (
	CLK,RST,ENable: in std_logic;	
	D: in std_logic_vector(7 downto 0);
	Q: out std_logic_vector(7 downto 0));
end Reg8bits;

architecture behv of Reg8bits is
begin
	process(CLK,RST)
	begin
		if (RST = '1') then
			Q <= "00000000";
		elsif (CLK'event and CLK = '1') then
			if (ENable = '1') then
				Q <= D;
			end if;
		end if;
	end process;

end behv;