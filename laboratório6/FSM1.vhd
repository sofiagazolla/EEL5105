library ieee;
use ieee.std_logic_1164.all;

entity FSM1 is port (
   clock: in std_logic;
   reset: in std_logic;
   x: out std_logic_vector (2 downto 0)
   );
end FSM1;

architecture fsm1arq of FSM1 is
   type ESTADOS is (Off, On1, On2, On3);
   signal EAtual, PEstado: ESTADOS;

begin
	process(clock,reset)
	begin
	    if (reset = '1') then
			EAtual <= Off;
        elsif (clock'event AND clock = '1') then 
         	EAtual <= PEstado;
	    end if;
	end process;
	
    process(EAtual)
	begin
		case EAtual is
			when Off => Pestado <= On1;
                     	x <= "111"; 
			when On1 => Pestado <= On2;
						x <= "011";
			when On2 => Pestado <= On3;
			            x <= "001";
			when On3 => Pestado <= Off;
			            x <= "000";
		end case;
	end process;
end fsm1arq;