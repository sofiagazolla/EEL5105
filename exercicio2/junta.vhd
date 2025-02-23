library IEEE;
use IEEE.Std_Logic_1164.all;

entity junta is
port (B: in std_logic_vector(7 downto 0);
      A: out std_logic_vector(6 downto 0);
      C: out std_logic_vector(6 downto 0);
      D: out std_logic_vector(6 downto 0)
     );
end junta;

architecture soma4 of junta is
 signal S1: std_logic_vector (7 downto 0);
 signal S2: std_logic_vector (7 downto 0);
 signal s22: std_logic_vector (7 downto 0);
 signal S3: std_logic_vector (11 downto 0); 

 
 component soma8 is
  port (A:  in std_logic_vector(7 downto 0);
      B:  in std_logic_vector(7 downto 0);
      S:  out std_logic_vector(7 downto 0)
     );
 end component; 
 
 component div4 is
  port (B:  in std_logic_vector(7 downto 0);
      S:  out std_logic_vector(7 downto 0)
     );
 end component;
 
  component binbcd is
  port (
        bin_in: in std_logic_vector (7 downto 0);
        bcd_out: out std_logic_vector (11 downto 0)
    );
 end component;
 
  component bcd7seg is
  port (bcd_in:  in std_logic_vector(3 downto 0);
      out_7seg:  out std_logic_vector(6 downto 0)
     );
 end component;
 
begin
    
SOMA1: soma8 port map (B, B, S1);
DIVISAO: div4 port map (B, S2);
SOMA2: soma8 port map (S1, S2, S22);
CONVERTE: binbcd port map (S22, S3);
CONVERTE1: bcd7seg port map (S3(3 downto 0), A);
CONVERTE2: bcd7seg port map (S3(7 downto 4), C);
CONVERTE3: bcd7seg port map (S3(11 downto 8), D);

end soma4;