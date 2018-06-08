library ieee;
use ieee.std_logic_1164.all;

entity contador is 
	port (clock,enable,zerar : in std_logic;
			max: in std_logic_vector(3 downto 0);
			cont:out std_logic_vector(3 downto 0));
			end contador;
			
architecture contador of contador is
	component divF is 
	port  (clock_in:in std_logic;
	divisor: in integer;
	clear: in std_logic;
	clock_out: out std_logic;
	enable:in std_logic);
	
	end component;
	signal contSignal: std_logic_vector(3 downto 0);
	signal reset:std_logic:='0';
	signal resetaux:std_logic:='0';
begin
	process(clock,contSignal,reset)
	begin
		if(clock ='0' and clock 'EVENT) then
			if contSignal = max then
				reset <= '1';
			else
				reset <= zerar;
			end if;
		elsif(clock ='1' and clock 'EVENT) then 
			resetaux<=reset;
			
		end if;
	end process;
	cont<=contSignal;
	DIV1: divF port map(clock,1,(zerar) or (reset and not resetaux),contSignal(0),enable);
	DIV2: divF port map(contSignal(0),1,(zerar) or (reset and not resetaux),contSignal(1),enable);
	DIV3: divF port map(contSignal(1),1,(zerar) or (reset and not resetaux),contSignal(2),enable);
	DIV4: divF port map(contSignal(2),1,(zerar) or (reset and not resetaux),contSignal(3),enable);
	
end contador;