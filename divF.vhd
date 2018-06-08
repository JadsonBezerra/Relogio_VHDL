library ieee;
use ieee.std_logic_1164.all;

entity divF is
	port (clock_in:in std_logic;
	divisor: in integer;
	clear: in std_logic;
	clock_out: out std_logic;
	enable:in std_logic);
end divF;

architecture divF of divF is
signal contagem : integer range 0 to 50000000:=1;
signal estado : std_logic;

begin
	process(clock_in,enable,clear)
	begin
		if(clear='1') then
		estado<='0';
		elsif(clock_in='0'and clock_in 'EVENT and enable='1') then
			if contagem = divisor then
				estado <= not estado;
				contagem <= 1;
			else
				contagem <= contagem + 1;
			end if;
		end if;
	end process;
	clock_out<=estado;
end divF;