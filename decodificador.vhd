library ieee;
use ieee.std_logic_1164.all;

entity decodificador is
	port(Binario:in std_logic_vector(3 downto 0);
			LedHex: out std_logic_vector(6 downto 0);
			pisca: in std_logic);
	end decodificador;
	
architecture decodificador of decodificador is
	begin
	LedHex(0)<=((not Binario(3) and Binario(2) and not Binario(0)) or 
	(not Binario(3) and not Binario(2) and not Binario(1) and Binario(0)) or
	(Binario(3) and not Binario(2) and Binario(1) and Binario(0)) or 
	(Binario(2) and Binario(1) and not Binario(0))) or pisca;
	
	LedHex(1)<=((not Binario(3) and Binario(2) and not Binario(1) and Binario(0)) or 
	(Binario(3) and Binario(2) and Binario(1) and Binario(0)) or
	(not Binario(3) and Binario(2) and Binario(1) and not Binario(0))) or pisca;
	
	LedHex(2)<=((Binario(3) and Binario(2) and not Binario(1) and not Binario(0)) or 
	(not Binario(3) and not Binario(2) and Binario(1) and not Binario(0))) or pisca;
	
	LedHex(3)<=((not Binario(2) and not Binario(1) and Binario(0)) or 
	(not Binario(3) and Binario(2) and not Binario(1) and not Binario(0)) or
	(Binario(3) and not Binario(2) and Binario(0)) or 
	(not Binario(3) and Binario(2) and Binario(1) and Binario(0)) or 
	(Binario(3) and Binario(2) and Binario(1) and not Binario(0))) or pisca;
	
	LedHex(4)<=((Binario(0)) or 
	(not Binario(3) and Binario(2) and not Binario(1)) or
	(Binario(3) and Binario(2) and Binario(1))) or pisca;
	
	LedHex(5)<=((not Binario(3) and not Binario(2) and Binario(0)) or 
	(not Binario(3) and not Binario(2) and Binario(1)) or
	(not Binario(3) and Binario(1) and Binario(0)) or 
	(Binario(3) and Binario(2) and not Binario(1)) or
	(not Binario(2) and Binario(1) and Binario(0))) or pisca;	
	
	LedHex(6)<= ((not Binario(3) and not Binario(2) and not Binario(1)) or
	(not Binario(3) and Binario(2) and Binario(1) and Binario(0)) or
	(Binario(3) and not Binario(2) and Binario(1))) or pisca;

	end decodificador;