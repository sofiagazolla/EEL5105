-- faz a conexão entre o controle e o datapath.

library IEEE;
use IEEE.Std_Logic_1164.all;

entity usertop is
port (
--CLOCK_50:in std_logic; -- para uso na placa
CLK_500Hz:in std_logic; -- para uso no emulador
CLK_1Hz: in std_logic; -- Adiciona o clock de 1Hz como entrada
KEY:in std_logic_vector(3 downto 0);
SW:in std_logic_vector(17 downto 0);
LEDR:out std_logic_vector(17 downto 0);
HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7: out std_logic_vector(6 downto 0)
);
end entity;

architecture arc of usertop is

component datapath is
port (
SW: in std_logic_vector(9 downto 0);
CLOCK_50, CLK_1Hz: in std_logic;
R1, R2, E1, E2, E3, E4, E5: in std_logic;
sw_erro, end_game, end_time, end_round: out std_logic;
HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: out std_logic_vector(6 downto 0);
LEDR: out std_logic_vector(9 downto 0)
);
end component;

component controle is
port
(
BTN1, BTN0, clock_50: in std_logic;
sw_erro, end_game, end_time, end_round: in std_logic;
R1, R2, E1, E2, E3, E4, E5: out std_logic
);
end component;

component ButtonSync is
	port
	(
		KEY0, KEY1, CLK: in std_logic;
		BTN0, BTN1: out std_logic
	);
end component;

	signal R1, R2, E1, E2, E3, E4, E5: std_logic;   -- sinais de controle
	signal sw_erro, end_game, end_time, end_round: std_logic;   -- sinais de status
	signal btn0, btn1: std_logic;   -- botões sincronizados

begin

PM_datapath: datapath port map(
											SW => SW(9 downto 0),
											CLOCK_50 => CLK_500hz, -- CLOCK_50 na placa e CLK_500Hz no emulador
											CLK_1Hz => CLK_1Hz,  -- deixar assim para possível uso no emulador
											R1 => R1,
											R2 => R2,
											E1 => E1,
											E2 => E2,
											E3 => E3,
											E4 => E4,
											E5 => E5,
											sw_erro => sw_erro,
											end_game => end_game,
											end_time => end_time,
											end_round => end_round,
											HEX0 => HEX0,
											HEX1 => HEX1,
											HEX2 => HEX2,
											HEX3 => HEX3,
											HEX4 => HEX4,
											HEX5 => HEX5,
											LEDR => LEDR(9 downto 0)
);

PM_controle: controle port map(
											BTN1 => btn1,
											BTN0 => btn0,
											clock_50 => CLK_500hz, -- CLOCK_50 na placa e CLK_500Hz no emulador
											sw_erro => sw_erro,
											end_game => end_game,
											end_time => end_time,
											end_round => end_round,
											R1 => R1,
											R2 => R2,
											E1 => E1,
											E2 => E2,
											E3 => E3,
											E4 => E4,
											E5 => E5
);

PM_ButtonSync: ButtonSync port map(
												KEY0 => KEY(0), 
												KEY1 => KEY(1), 
												CLK => CLK_500hz, -- CLOCK_50 na placa e CLK_500Hz no emulador
												BTN0 => btn0,
												BTN1 => btn1
);

end architecture;