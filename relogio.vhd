library ieee;
use ieee.std_logic_1164.all;

entity relogio is 
	port (clock1,modo,reset,config,strt,set : in std_logic;
			Segundos1:out std_logic_vector(6 downto 0);
			Segundos2:out std_logic_vector(6 downto 0);
			Minutos1:out std_logic_vector(6 downto 0);
			Minutos2:out std_logic_vector(6 downto 0);
			Horas1:out std_logic_vector(6 downto 0);
			Horas2:out std_logic_vector(6 downto 0);
			teste_modo: out std_logic_vector(1 downto 0);
			taNaHora:out std_logic);
			end relogio;
			
architecture  relogio of relogio is
	component divF is
		port(clock_in:in std_logic;
			divisor: in integer;
			clear: in std_logic;
			clock_out: out std_logic);
	end component;
	component horario is
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
			end component;
			
	component alarme is 
		port (clock1,enable1,zerar1,config,strt,set : in std_logic;
			modo:  in integer range 0 to 2;
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
			end component;
			
	component cronometro is
		port (clock1,enable1,zerar1,config,strt,set: in std_logic;
			modo:  in integer range 0 to 2;
			miliSegundos1:out std_logic_vector(3 downto 0);
			miliSegundos2:out std_logic_vector(3 downto 0);
			Segundos1:out std_logic_vector(3 downto 0);
			Segundos2:out std_logic_vector(3 downto 0);
			Minutos1:out std_logic_vector(3 downto 0);
			Minutos2:out std_logic_vector(3 downto 0));
			end component;
	component decodificador  is
		port(Binario: in std_logic_vector(3 downto 0);
				LedHex:out std_logic_vector (6 downto 0);
				pisca:in std_logic);
		end component;
		
	signal EscolhaModo:integer range 0 to 2:= 0;
	signal Segundos1Sig: std_logic_vector(3 downto 0);
	signal Segundos2Sig: std_logic_vector(3 downto 0);
	signal Minutos1Sig: std_logic_vector(3 downto 0);
	signal Minutos2Sig: std_logic_vector(3 downto 0);
	signal Horas1Sig: std_logic_vector(3 downto 0);
	signal Horas2Sig: std_logic_vector(3 downto 0);
	signal Segundos1SigHorario: std_logic_vector(3 downto 0);
	signal Segundos2SigHorario: std_logic_vector(3 downto 0);
	signal Minutos1SigHorario: std_logic_vector(3 downto 0);
	signal Minutos2SigHorario: std_logic_vector(3 downto 0);
	signal Horas1SigHorario: std_logic_vector(3 downto 0);
	signal Horas2SigHorario: std_logic_vector(3 downto 0);
	signal Segundos1SigCronometro: std_logic_vector(3 downto 0);
	signal Segundos2SigCronometro: std_logic_vector(3 downto 0);
	signal Minutos1SigCronometro: std_logic_vector(3 downto 0);
	signal Minutos2SigCronometro: std_logic_vector(3 downto 0);
	signal Horas1SigCronometro: std_logic_vector(3 downto 0);
	signal Horas2SigCronometro: std_logic_vector(3 downto 0);
	signal Minutos1SigAlarme: std_logic_vector(3 downto 0);
	signal Minutos2SigAlarme: std_logic_vector(3 downto 0);
	signal Horas1SigAlarme: std_logic_vector(3 downto 0);
	signal Horas2SigAlarme: std_logic_vector(3 downto 0);	
	signal HorarioPiscarH:std_logic;
	signal HorarioPiscarM:std_logic;
	signal AlarmePiscarH:std_logic;
	signal AlarmePiscarM:std_logic;
	signal piscarH:std_logic;
	signal piscarM:std_logic;
	signal piscadorH:std_logic;
	signal piscadorM:std_logic;
	
	begin		
		process(clock1,escolhaModo,modo)
			begin
			if(modo='0' and modo'EVENT) then 
				if(escolhaModo=2) then
					escolhaModo<=0;
				else
					escolhaModo<=escolhaModo+1;
				end if;
			end if;
			case escolhaModo is
				when 0=>
					piscadorM<=HorarioPiscarM;
					piscadorH<=HorarioPiscarH;
					teste_modo<= "01";
					segundos1Sig<=segundos1SigHorario;
					segundos2Sig<=segundos2SigHorario;
					minutos1Sig<=minutos1SigHorario;
					minutos2Sig<=minutos2SigHorario;
					horas1Sig<=horas1SigHorario;
					horas2Sig<=horas2SigHorario;
				when 1=>
					piscadorH<=AlarmePiscarH;
					piscadorM<=AlarmePiscarM;
					teste_modo<= "10";
					segundos1Sig<="0000";
					segundos2Sig<="0000";
					minutos1Sig<=minutos1SigAlarme;
					minutos2Sig<=minutos2SigAlarme;
					horas1Sig<=horas1SigAlarme;
					horas2Sig<=horas2SigAlarme;
				when 2=>
					piscadorH<='1';
					piscadorM<='1';
					teste_modo<= "11";
					segundos1Sig<=segundos1SigCronometro;
					segundos2Sig<=segundos2SigCronometro;
					minutos1Sig<=minutos1SigCronometro;
					minutos2Sig<=minutos2SigCronometro;
					horas1Sig<=horas1SigCronometro;
					horas2Sig<=horas2SigCronometro;
			end case;
		end process;
		
		H1: horario port map(clock1,'1',reset,config,strt,set,EscolhaModo,
		segundos1SigHorario,segundos2SigHorario,
		minutos1SigHorario,minutos2SigHorario,
		horas1SigHorario,horas2SigHorario,
		HorarioPiscarH,HorarioPiscarM);
		
		C1: cronometro port map(clock1,'1',reset,config,strt,set,EscolhaModo,
		segundos1SigCronometro,segundos2SigCronometro,
		minutos1SigCronometro,minutos2SigCronometro,
		horas1SigCronometro,horas2SigCronometro);
		
		A1: alarme port map(clock1,'1',reset,config,strt,set,EscolhaModo,
		minutos1SigHorario,minutos2SigHorario,
		horas1SigHorario,horas2SigHorario,
		minutos1SigAlarme,minutos2SigAlarme,
		horas1SigAlarme,horas2SigAlarme,
		AlarmePiscarH,AlarmePiscarM,taNaHora);
		
		D1: decodificador port map(Segundos1Sig,Segundos1,'0');
		D2: decodificador port map(Segundos2Sig,Segundos2,'0');
		D3: decodificador port map(Minutos1Sig,Minutos1,not piscadorM);
		D4: decodificador port map(Minutos2Sig,Minutos2,not piscadorM);
		D5: decodificador port map(horas1Sig,horas1,not piscadorH);
		D6: decodificador port map(horas2Sig,horas2,not piscadorH);
		
end relogio;