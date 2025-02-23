--Bloco de controle, tem a descrição de funcionamento da máquina de estados. Garante que tudo funciona como deve, saídas e transições de um estado para outro.

library ieee;
use ieee.std_logic_1164.all;

entity controle is
port
(
BTN1, BTN0, clock_50: in std_logic;
sw_erro, end_game, end_time, end_round: in std_logic; -- Status que são saídas do datapath e entrada no controle
R1, R2, E1, E2, E3, E4, E5: out std_logic -- Resets e Enables que são saídas do controle e entradas no datapath
);
end entity;

architecture arc of controle is
	type State is (Start, Setup, Play, Count_Round, Check, Waits, Result); -- Estados
	signal EA, PE: State := Start; -- EA: estado atual, PE: proximo estado

begin
process(clock_50,btn0)
  begin
    if (btn0 = '0') then -- Quando o botão key0 é apertado
	  EA <= start; -- O estado atual vira start
	elsif (clock_50'event AND clock_50 = '1') then 
  	  EA <= PE; -- Estado atual vira o próximo estado
	end if;
  end process;
process(EA, btn1, sw_erro, end_game, end_time, end_round) -- Sensibilidade, ao mudarem de valor, disparam a execução do processo.(Atualiza)
  begin
    R1 <= '0';
    R2 <= '0';
    E1 <= '0';
    E2 <= '0';
    E3 <= '0';
    E4 <= '0';
    E5 <= '0';
    case EA is
      when start =>
         R1 <= '1'; -- Reseta o contador de tempo (counter_time)
         R2 <= '1'; -- Reseta o div freq
         E1 <= '0';
         E2 <= '0';
         E3 <= '0';
         E4 <= '0';
         E5 <= '0';
         if (btn1 = '0' ) then -- Aperta o key1
		  PE<= setup;
		 else
		  PE <= start;
		 end if;
	  when setup => 
		  R1 <= '0';
          R2 <= '0';
          E1 <= '1'; -- Habilita o registrador que guarda o valor inicial e o tempo
          E2 <= '0';
          E3 <= '0';
          E4 <= '0';
          E5 <= '0';
		  if (btn1 ='0') then
		    PE <= play;
		  else
			PE <= setup;
		end if;
	 when play =>
         R1 <= '0';
         R2 <= '0';
         E1 <= '0';
         E2 <= '1'; -- Habilita o counter_time para realizar a contagem do tempo
         E3 <= '0';
         E4 <= '0';
         E5 <= '0';
         if (end_time = '1' ) then
		  PE <= result;
		 elsif (btn1 = '0') then
		  PE <= count_round;
		 else
		  PE <= play;
		 end if;
	 when count_round =>
         R1 <= '0';
         R2 <= '0';
         E1 <= '0';
         E2 <= '0';
         E3 <= '1'; -- Habilita counter_round para incrementar o número de rodadas
         E4 <= '0';
         E5 <= '0';
         pe <= check;
	 when check =>
         R1 <= '0';
         R2 <= '0';
         E1 <= '0';
         E2 <= '0';
         E3 <= '0';
         E4 <= '1'; -- Habilita a comparação para verificar sw_erro, end_round e end_game (check)
         E5 <= '0';
         if ((sw_erro = '1') or (end_round ='1') or (end_game ='1') ) then
		  PE <= result;
		 else
		  PE <= waits;
		 end if;
	 when waits =>
         R1 <= '1'; -- Reseta o counter_time para resetar o tempo a cada rodada
         R2 <= '0';
         E1 <= '0';
         E2 <= '0';
         E3 <= '0';
         E4 <= '0';
         E5 <= '0';
         if (btn1 = '0' ) then
		  PE<= play;
		 else
		  PE <= waits;
		 end if;
	 when result =>
         R2 <= '0';
         E1 <= '0';
         E2 <= '0';
         E3 <= '0';
         E4 <= '0';
         E5 <= '1'; -- Habilita o registrador final para armazenar e mostrar os resultados no display e leds
         if (btn1 = '0' ) then
		  PE<= start;
		 else
		  PE <= result;
		 end if;
		 
	
    end case;
 end process;
end architecture arc;
