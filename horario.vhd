library ieee;
use ieee.std_logic_1164.all;

entity horario is 
	port (clock1,enable1,zerar1,config,strt,set : in std_logic;
			modo:  in integer range 0 to 2;
			Segundos1:out std_logic_vector(3 downto 0);
			Segundos2:out std_logic_vector(3 downto 0);
			Minutos1:out std_logic_vector(3 downto 0);
			Minutos2:out std_logic_vector(3 downto 0);
			Horas1:out std_logic_vector(3 downto 0);
			Horas2:out std_logic_vector(3 downto 0);
			piscarH:out std_logic;
			piscarM:out std_logic);
			end horario;
			
architecture horario of horario is
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
			enable:in std_logic);
	end component;
	
	signal clockSignal : std_logic:='0';
	signal Segundos1Sig: std_logic_vector(3 downto 0);
	signal Segundos2Sig: std_logic_vector(3 downto 0);
	signal Minutos1Sig: std_logic_vector(3 downto 0);
	signal Minutos2Sig: std_logic_vector(3 downto 0);
	signal Horas1Sig: std_logic_vector(3 downto 0);
	signal Horas2Sig: std_logic_vector(3 downto 0);
	signal reset:std_logic:='0';
	signal resetaux:std_logic:='0';
	signal acabou:std_logic:='0';
	signal MinHor: integer range 0 to 2:=2;
	signal clockS : std_logic:='0';
	signal clockM : std_logic:='0';
	signal clockH : std_logic:='0';
	signal piscadorM: std_logic:='1';
	signal piscadorH: std_logic:='1';
	signal enableS:std_logic;
	signal enableM:std_logic;
	signal enableH:std_logic;
	
begin
	process(config,MinHor,clock1)
		begin
		if(modo=0) then
			case MinHor is
				when 0 =>
					clockS<=clockSignal;
					clockM<= not strt;
					clockH<=clockH;
					piscarM<=piscadorM;
					piscarH<='1';
					enableS<='0';
					enableM<='1';
					enableH<='0';
				when 1 =>
					clockS<=clockSignal;
					clockM<=clockM;
					clockH<=not strt;
					piscarM<='1';
					piscarH<=piscadorH;
					enableS<='0';
					enableM<='0';
					enableH<='1';
				when 2=>
					enableS<='0';
					enableM<='0';
					enableH<='0';
					clockS<=clockSignal;
					clockM<=Segundos2Sig(2);
					clockH<=Minutos2Sig(2);
					piscarM<='1';
					piscarH<='1';
					enableS<='1';
					enableM<='1';
					enableH<='1';
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
			piscarM<='1';
			piscarH<='1';
			clockS<=clockSignal;
			clockM<=Segundos2Sig(2);
			clockH<=Minutos2Sig(2);
			enableS<='1';
			enableM<='1';
			enableH<='1';
		end if;
	end process;
	process(clock1)
		begin
			if(clock1='0' and clock1'EVENT) then
				if reset= '1' then
					reset<='0';
				elsif(Horas2Sig="0010" and Horas1Sig="0100") then 
					reset <='1';
				end if;
			elsif(clock1='1' and clock1'EVENT) then
				resetaux<= reset;
			end if;
		end process;
	acabou<=reset and not resetaux;
	Segundos1<=Segundos1Sig;
	Segundos2<=Segundos2Sig;
	Minutos1<=Minutos1Sig;
	Minutos2<=Minutos2Sig;
	Horas1<=Horas1Sig;
	Horas2<=Horas2Sig;
	DIV3: divF port map(clock1,25000000,'0',piscadorH,'1');
	DIV2: divF port map(clock1,25000000,'0',piscadorM,'1');
	DIV1: divF port map(clock1,25000000,'0',clockSignal,'1');
	S1: contador port map(clockS,enableS,acabou,"1001",Segundos1Sig);
	S2: contador port map(Segundos1Sig(3),enableS,acabou,"0101",Segundos2Sig);
	M1: contador port map(clockM,enableM,acabou,"1001",Minutos1Sig);
	M2: contador port map(Minutos1Sig(3),enableM,acabou,"0101",Minutos2Sig);
	H1: contador port map(clockH,enableH,acabou,"1001",Horas1Sig);
	H2: contador port map(Horas1Sig(3),enableH,acabou,"0010",Horas2Sig);
	
end horario;