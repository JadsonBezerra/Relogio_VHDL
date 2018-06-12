library ieee;
use ieee.std_logic_1164.all;

entity alarme is
	port (clock1,enable1,zerar1,config,strt,set : in std_logic;
			modo:in integer range 0 to 2;
			Minutos1:in std_logic_vector(3 downto 0);
			Minutos2:in std_logic_vector(3 downto 0);
			Horas1:in std_logic_vector(3 downto 0);
			Horas2:in std_logic_vector(3 downto 0);
			Minutos1Display:out std_logic_vector(3 downto 0);
			Minutos2Display:out std_logic_vector(3 downto 0);
			Horas1Display:out std_logic_vector(3 downto 0);
			Horas2Display:out std_logic_vector(3 downto 0);
			piscarH:out std_logic;
			piscarM:out std_logic;
			taNaHora: out std_logic);
			end alarme;
			
architecture alarme of alarme is
	component contador is 
	port (clock,enable,zerar : in std_logic;
			max : in std_logic_vector(3 downto 0);
			cont:out std_logic_vector(3 downto 0));
	end component;
	
	component divF is 
	port (clock_in:in std_logic;
			divisor: in integer;
			clear: in std_logic;
			clock_out: out std_logic;
			enable: in std_logic);
	end component;
	
	signal Minutos1Sig: std_logic_vector(3 downto 0);
	signal Minutos2Sig: std_logic_vector(3 downto 0);
	signal Horas1Sig: std_logic_vector(3 downto 0);
	signal Horas2Sig: std_logic_vector(3 downto 0);
	signal MinHor: integer range 0 to 2:=1;
	signal reset: std_logic:='0';
	signal resetaux: std_logic:='0';
	signal clockM: std_logic:='0';
	signal clockH: std_logic:='0';
	signal acabou: std_logic;
	signal piscadorM: std_logic:='1';
	signal piscadorH: std_logic:='1';
	signal enableH,enableM: std_logic;
	signal ativado: std_logic:='0';
	begin
		process(config,modo,clock1)
		begin
		if(modo=1) then
			case MinHor is
				when 0 =>
					clockM<= not strt;
					clockH<=clockH;
					piscarM<=piscadorM;
					piscarH<='1';
					enableM<='1';
					enableH<='0';
				when 1 =>
					clockM<=clockM;
					clockH<=not strt;
					piscarM<='1';
					piscarH<=piscadorH;
					enableM<='0';
					enableH<='1';
				when 2=>
					piscarH<='1';
					piscarM<='1';
					enableM<='0';
					enableH<='0';
			end case;
			if config='1' then 
				minHor<=0;
			elsif(set='0' and set'EVENT) then 
				if MinHor = 2 then 
					MinHor<=2;
				else 
					MinHor <= MinHor + 1;
				end if;
			end if;
		else
			enableM<='0';
			enableH<='0';
		end if;
	end process;
	process(clock1)
		begin
		if(modo=1) then 
			tanaHora<=ativado;
		else
			if(clock1='0' and clock1'EVENT) then 
				if reset= '1' then
					reset<='0';
				elsif(Horas2Sig="0010" and Horas1Sig="0100") then 
					reset <='1';
				elsif(Horas2Sig=Horas2 and Horas1Sig=Horas1 and Minutos2Sig=Minutos2 and Minutos1Sig=Minutos1) then 
					taNaHora<='1';
				else
					taNaHora<='0';
				end if;
			elsif(clock1='1' and clock1'EVENT) then
				resetaux<= reset;
			end if;
		end if;
		end process;
	
	process(config,zerar1)
		begin
			if(config='1') then 
				if(zerar1='0' and zerar1'EVENT) then
					ativado<=not ativado;
				end if;
			end if;
	end process;
		
	acabou<= reset and not resetaux;
	DIV1: divF port map(clock1,50000000,'0',piscadorH,'1');
	DIV2: divF port map(clock1,50000000,'0',piscadorM,'1');
	M1: contador port map(clockM,enableM,acabou,"1001",Minutos1Sig);
	M2: contador port map(Minutos1Sig(3),enableM,acabou,"0101",Minutos2Sig);
	H1: contador port map(clockH,enableH,acabou,"1001",Horas1Sig);
	H2: contador port map(Horas1Sig(3),enableH,acabou,"0010",Horas2Sig);
	minutos1Display<=minutos1Sig;
	minutos2Display<=minutos2Sig;
	horas1Display<=horas1Sig;
	horas2Display<=horas2Sig;
end alarme;
