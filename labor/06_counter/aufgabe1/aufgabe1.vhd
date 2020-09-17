LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY aufgabe1 IS
	PORT (
		SW : IN std_logic_vector(17 DOWNTO 0);
		LEDR : OUT std_logic_vector(17 DOWNTO 0);
		LEDG : OUT std_logic_vector(7 DOWNTO 0);
		HEX0 : OUT std_logic_vector(6 DOWNTO 0));
END aufgabe1;

ARCHITECTURE LogicFunction OF aufgabe1 IS
BEGIN
	LEDR <= SW;
	d : ENTITY work.htb(LogicFunction)
		PORT MAP(
			INPUT => SW(3 DOWNTO 0),
			OUTPUT => HEX0);

END LogicFunction;