LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY aufgabe2 IS
	PORT (
		SW : IN std_logic_vector(0 TO 17);
		LEDR : OUT std_logic_vector(0 TO 17);
		LEDG : OUT std_logic_vector(0 TO 7));
END aufgabe2;

ARCHITECTURE LogicFunction OF aufgabe2 IS
BEGIN
	LEDR(0 TO 17) <= SW(0 TO 17);
	my_mux : ENTITY work.multiplexer(LogicFunction)
		PORT MAP(
			IN1 => SW(0 TO 2),
			IN2 => SW(3 TO 5),
			IN3 => SW(6 TO 8),
			IN4 => SW(9 TO 11),
			IN5 => SW(12 TO 14),
			SEL => SW(15 TO 17),
			RESULT => LEDG(0 TO 2));
END LogicFunction;