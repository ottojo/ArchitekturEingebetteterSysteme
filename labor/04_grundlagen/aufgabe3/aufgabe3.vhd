LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY aufgabe3 IS
	PORT (
		SW : IN std_logic_vector(17 DOWNTO 0);
		LEDR : OUT std_logic_vector(17 DOWNTO 0);
		LEDG : OUT std_logic_vector(7 DOWNTO 0);
		HEX0 : OUT std_logic_vector(0 TO 6));
END aufgabe3;

ARCHITECTURE LogicFunction OF aufgabe3 IS
BEGIN
	LEDR <= SW;
	d : ENTITY work.display(LogicFunction)
		PORT MAP(
			INPUT => SW(3 DOWNTO 0),
			OUTPUT => HEX0);

END LogicFunction;