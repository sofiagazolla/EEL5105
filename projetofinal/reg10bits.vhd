library ieee;
use ieee.std_logic_1164.all;

entity Reg10bits is port (
	CLK,RST,ENable: in std_logic;	
	D: in std_logic_vector(9 downto 0);
	Q: out std_logic_vector(9 downto 0));
end Reg10bits;

architecture behv of Reg10bits is
begin
	process(CLK,RST)
	begin
		if (RST = '1') then
			Q <= "0000000000";
		elsif (CLK'event and CLK = '1') then
			if (ENable = '1') then
				Q <= D;
			end if;
		end if;
	end process;

end behv;