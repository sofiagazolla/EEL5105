library ieee;
use ieee.std_logic_1164.all;
entity estado is port (
   clock: in std_logic;
   reset: in std_logic;
   B: in std_logic;
   x: out std_logic_vector (1 downto 0)
   );
end estado;
architecture fsm1arq of estado is
   type ESTADOS is (Init, On1, Off1, On2, Off2);
   signal EAtual, Pestado: ESTADOS;
begin
	process(clock,reset)
	begin
	    if (reset = '1') then
			EAtual <= Init;
        elsif (clock'event AND clock = '1') then 
         	EAtual <= PEstado;
	    end if;
	end process;
    process(EAtual,B)
	begin
		case EAtual is
		    when Init => 
		        x <= "10";
		        if B = '0' then 
		            Pestado <= Init;
		        else
		            Pestado <= On1;
		        end if;
			when On1 => Pestado <= Off1;
                     	x <= "01"; 
			when Off1 => Pestado <= On2;
						x <= "00";
			when On2 => Pestado <= Off2;
			            x <= "01";
			when Off2 => 
		        x <= "10";
		        if B = '0' then 
		            Pestado <= Off2;
		        else
		            Pestado <= On1;
		        end if;
		end case;
	end process;
end fsm1arq;