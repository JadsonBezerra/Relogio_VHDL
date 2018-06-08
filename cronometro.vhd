library ieee;
use ieee.std_logic_1164.all;

entity cronometro is 
	port (clock1,enable1,zerar1,config,strt,set : in std_logic;
			modo:  in integer range 0 to 2;
			miliSegundos1:out std_logic_vector(3 downto 0);
			miliSegundos2:out std_logic_vector(3 downto 0);
			Segundos1:out std_logic_vector(3 downto 0);
			Segundos2:out std_logic_vector(3 downto 0);
			Minutos1:out std_logic_vector(3 downto 0);
			Minutos2:out std_logic_vector(3 downto 0));
			end cronometro;
			
architecture cronometro of cronometro is
	component contador is 
	port (clock,enable,zerar : in std_logic;
			max: in std_logic_vector(3 downto 0);
			cont:out std_logic_vector(3 downto 0));
	end component;
	component divF is 
	port (clock_in:in std_logic;
			divisor: in integer;
			clear: in std_logic;
			clock_out: out std_logic;
			enable: in std_logic);
	end component;
	signal clock_use: std_logic;
	signal miliSegundos1Sig: std_logic_vector(3 downto 0);
	signal miliSegundos2Sig: std_logic_vector(3 downto 0);
	signal Segundos1Sig: std_logic_vector(3 downto 0);
	signal Segundos2Sig: std_logic_vector(3 downto 0);
	signal Minutos1Sig: std_logic_vector(3 downto 0);
	signal Minutos2Sig: std_logic_vector(3 downto 0);
	signal reset:std_logic:='0';
	signal strtStop:std_logic:='0';
	signal taNoModoCerto:std_logic:='0';
begin		
	process(modo,strt)
		begin
			if(modo=2) then 
				taNoModoCerto<='1';
				if(strt='0' and strt'EVENT) then
					strtStop<=not strtStop;
				end if;
			else 
				taNoModoCerto<='0';
			end if;
	end process;
	miliSegundos1<=miliSegundos1Sig;
	miliSegundos2<=miliSegundos2Sig;
	Segundos1<=Segundos1Sig;
	Segundos2<=Segundos2Sig;
	Minutos1<=Minutos1Sig;
	Minutos2<=Minutos2Sig;
	DIV1: divF port map(clock1,249999,'0',clock_use,'1');
	MS1: contador port map(clock_use,tanoModoCerto and strtStop,
	not zerar1,"1001",miliSegundos1Sig);
	MS2: contador port map(miliSegundos1Sig(3),enable1,not zerar1,"1001",miliSegundos2Sig);
	S1: contador port map(miliSegundos2Sig(3),enable1,not zerar1,"1001",Segundos1Sig);
	S2: contador port map(Segundos1Sig(3),enable1,not zerar1,"0101",Segundos2Sig);
	M1: contador port map(Segundos2Sig(2),enable1,not  zerar1,"1001",Minutos1Sig);
	M2: contador port map(Minutos1Sig(3),enable1,not zerar1,"0101",Minutos2Sig);

end cronometro;