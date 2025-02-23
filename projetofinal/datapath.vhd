-- Datapath, fazendo a conexao entre cada componente

library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity datapath is
port (
-- Entradas de dados
SW: in std_logic_vector(9 downto 0);
CLOCK_50, CLK_1Hz: in std_logic;
-- Sinais de controle
R1, R2, E1, E2, E3, E4, E5: in std_logic;
-- Sinais de status
sw_erro, end_game, end_time, end_round: out std_logic;
-- Saidas de dados
HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: out std_logic_vector(6 downto 0);
LEDR: out std_logic_vector(9 downto 0)
);
end datapath;

architecture arc of datapath is
--============================================================--
--                      COMPONENTS                            -- 
--============================================================--
-------------------DIVISOR DE FREQUENCIA------------------------

component Div_Freq is
	port (	    clk: in std_logic;
				reset: in std_logic;
				CLK_1Hz: out std_logic
			);
end component;

------------------------CONTADORES------------------------------

component counter_time is
port(Enable, Reset, CLOCK: in std_logic;
		load: in std_logic_vector(3 downto 0);
		end_time: out std_logic;
		tempo: out std_logic_vector(3 downto 0)
		);
end component;

component counter0to10 is
port(
    Enable, Reset, CLOCK: in std_logic;
	Round: out std_logic_vector(3 downto 0);
	end_round: out std_logic
	);
			
end component;

-------------------ELEMENTOS DE MEMORIA-------------------------

component reg4bits is 
port(
    CLK, RST, enable: in std_logic;
    D: in std_logic_vector(3 downto 0);
    Q: out std_logic_vector(3 downto 0)
    );
end component;

component reg8bits is 
port (
	CLK, RST, enable: in std_logic;
	D: in std_logic_vector(7 downto 0);
	Q: out std_logic_vector(7 downto 0)
);
end component;

component reg10bits is 
port(
	CLK, RST, enable: in std_logic;
	D: in std_logic_vector(9 downto 0);
	Q: out std_logic_vector(9 downto 0)
    );
end component;

component ROM is
port(
    address : in std_logic_vector(3 downto 0);
    data : out std_logic_vector(9 downto 0) 
    );
end component;

---------------------MULTIPLEXADORES----------------------------


component mux2pra1_4bits is
port(
    sel: in std_logic;
	x, y: in std_logic_vector(3 downto 0);
	saida: out std_logic_vector(3 downto 0)
    );
end component;

component mux2pra1_7bits is
port (sel: in std_logic;
		x, y: in std_logic_vector(6 downto 0);
		saida: out std_logic_vector(6 downto 0)
);
end component;

component mux2pra1_8bits is
port(
    sel: in std_logic;
	x, y: in std_logic_vector(7 downto 0);
	saida: out std_logic_vector(7 downto 0)
    );
end component;

component mux2pra1_10bits is
port(
    sel: in std_logic;
	x, y: in std_logic_vector(9 downto 0);
	saida: out std_logic_vector(9 downto 0)
    );
end component;

----------------------DECODIFICADOR-----------------------------

component decod7seg is
port(
    X: in std_logic_vector(3 downto 0);
    Y: out std_logic_vector(6 downto 0)
    );
end component;

-------------------COMPARADORES E SOMA--------------------------

component comp is
port (
    seq_user: in std_logic_vector(9 downto 0);
    seq_reg: in std_logic_vector(9 downto 0);
    seq_mask: out std_logic_vector(9 downto 0)
    );
end component;

component comp_igual4 is
port(
    soma: in std_logic_vector(3 downto 0);
    status: out std_logic
    );
end component;

component soma is
port(
    seq: in std_logic_vector(9 downto 0);
    soma_out: out std_logic_vector(3 downto 0)
    );
end component;


--============================================================--
--                  	SIGNALS                           	--
--============================================================--

signal selMux23, selMux45, end_time_round, clk_1, enableRegFinal, gameover, not_error, final: std_logic; --1 bit
signal Round, Level_time, Level_code, SaidaCountT, SomaDigitada, SomaSelDig, SaidaHex4, RegFinalMenos, RegFinalMais: std_logic_vector (3 downto 0); -- 4 bits
signal decMuxCode, decMuxRound, muxMux2, muxMux3, decMux4, Tempo, t, r, n, SaidaHex3, MuxHex2 , MuxHex2_2 , SaidaDecod: std_logic_vector (6 downto 0);
signal SomaSelDig_estendido, RegFinal, saidareg1, pontuacao, concatena: std_logic_vector(7 downto 0); -- 8 bits
signal SeqDigitada, ComparaSelDig, SelecionadaROM: std_logic_vector(9 downto 0); -- 10 bits

begin

concatena <= "1010" & somaSelDig (3 downto 0); -- Concatena a saída do soma, que verifica se tem 4 números 4, com "1010"

selMux23 <= (E1 or E2); -- Relacionado ao mux tanto do HEX5 quanto do HEX4

selMux45 <= (R1 xor R2); -- Relacionado tanto ao mux do HEX3 quanto do HEX2

enableRegFinal <= (E5 or E4);-- Faz o or que entra no Enable do último registrador

end_time <= end_time_round; -- Verifica se o tempo terminou ou não

-- Divide a saída do registrador de 8 bits em duas:

Level_code <= saidareg1(3 downto 0); -- Os quatro bits menos significativos estabelecem qual a sequência que o jogador vai ter

Level_Time <= saidareg1(7 downto 4); -- Os quatro bits mais significativos estabelecem o tempo que o jogador vai ter 

-- Divide a saída do segundo registrador de 8 bits em duas:

RegFinalMenos <= RegFinal(3 downto 0); -- Passa os 4 bits menos significativos da saída do último registrador para o HEX0

RegFinalMais <= RegFinal(7 downto 4); -- Passa os 4 bits mais significativos da saída do último registrador para o HEX1

-- Associados ao final do jogo. 
end_game <= gameover ; -- O gameover indica que uma das condições de terminar o jogo foi atingida

final <= gameover and not_error and not(end_time_round); -- Quando todos esses forem 1, o jogo será terminado da maneira correta

pontuacao <= "000" & final & (Round); -- Calcula a pontuação total do jogo

--DIV: Div_Freq port map (CLOCK_50, R2, CLK_1); -- Para teste no emulador, comentar essa linha e usar o CLK_1Hz

------------------------CONTADORES------------------------------

contadorrodada: counter0to10 port map (E3, R2, CLOCK_50, round, end_round); -- Vai contando a rodada para ver se já chegou na décima rodada ou não
contadortempo: counter_time port map (E2, R1, CLK_1Hz, level_time, end_time_round, SaidaCountT); -- Vai contando o tempo para ver se ocorre end_time ou não

-------------------ELEMENTOS DE MEMORIA-------------------------

registadortempoenivel: reg8bits port map (CLOCK_50, R2, E1, sw(7 downto 0),  saidareg1); -- Define qual vai ser o tempo limite e qual a sequência da rodada
registadorsequencia: reg10bits port map (CLOCK_50, R2, E2, sw(9 downto 0), seqdigitada); -- Verifica, em todas as rodadas, a sequência que o jogador digitou
registradorfinal: reg8bits port map (CLOCK_50, R2, enableRegFinal, SomaSelDig_estendido, RegFinal); -- 

---------------------MULTIPLEXADORES----------------------------
--Associados aos LEDS
ledssequencia: mux2pra1_10bits port map (e5, "0000000000", SelecionadaROM, LEDR ); -- Determina o que deve ser exibido nos leds: Nada se a sequência não tiver sido adivinhada e a própria sequência se ela for adivinhada ou se der game over

--Associados aos HEX 1 e 0 
muxpontuacaoeacertos: mux2pra1_8bits port map (E5, pontuacao, concatena, SomaSelDig_estendido); -- Passa a pontuação e os acertos para o HEX0 e o HEX1

-- Associados ao HEX2
rodadaatual: mux2pra1_7bits port map (E1, MuxHex2, "1111111", decMuxCode); -- Ou mostra o número da rodada atual (Saída do counter0to10) ou não mostra nada
selecaonivel: mux2pra1_7bits port map (selMux45, MuxHex2_2, decMuxCode, HEX2); -- Mostra o nível que está sendo escolhido no começo do jogo

-- Associados ao HEX3
muxn: mux2pra1_7bits port map (E1, "0101011", "1111111", SaidaHex3); -- Ou mostra o n ou não mostra nada
muxrodada: mux2pra1_7bits port map (selMux45, "0101111", SaidaHex3, hex3); -- Ou mostra o r (rodada) ou mostra o n (nível)

-- Associados ao HEX4 
muxtempo: mux2pra1_4bits port map (e2, SaidaCountT, level_time, SaidaHex4 ); -- Faz a contagem do tempo no HEX4
muxhex4: mux2pra1_7bits port map (selMux23, SaidaDecod, "1111111", hex4); -- Mostra ou a saída do decodificador ou nada

-- Associados ao HEX5
muxt: mux2pra1_7bits port map (selMux23,"0000111", "1111111", hex5); -- Mostra ou o t ou não mostra nada 

-------------------COMPARADORES E SOMA--------------------------

selecionaseq: ROM port map (Level_code, SelecionadaROM);  -- A saída seleciona a sequência baseada na entrada

--Verifica se a sequência que o jogador digitou é válida
conta1s: soma port map (SeqDigitada, SomaDigitada);  -- Conta o número de uns que tem na sequência inserida pelo jogador
verifica4: comp_igual4 port map (SomaDigitada, not_error); -- Verifica se tem 4 uns na sequência
sw_erro <= not(not_error);

--Verifica se o jogador acertou
comparaseq: comp port map (SelecionadaROM, SeqDigitada, ComparaSelDig); -- Verifica se o jogador acertou a sequência ou não
quantosacertos: soma port map (ComparaSelDig, SomaSelDig); -- Vê quantas posições de 1 o jogador acertou
acertou: comp_igual4 port map (SomaSelDig, gameover); -- Se o jogador já acertou todas as posições, o jogo acaba

---------------------DECODIFICADORES----------------------------

decodtempo: decod7seg port map (SaidaHex4, SaidaDecod); -- Exibe a contagem do tempo

numerorodada: decod7seg port map (Round, MuxHex2_2); -- Escreve o número da rodada atual no HEX2
sequenciaescolhida: decod7seg port map (Level_code, MuxHex2); -- Mostra qual o número da sequência que está sendo escolhida no começo do jogo

decodificadorhex1: decod7seg port map (RegFinalMais, hex1);  -- saida hex1
decodificadorhex0: decod7seg port map (RegFinalMenos, hex0); -- saida hex0
   	 
end arc;