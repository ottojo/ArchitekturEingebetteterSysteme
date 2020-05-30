LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY device IS
    PORT (
        SW : IN STD_LOGIC_VECTOR(0 TO 17);
        LEDR : OUT STD_LOGIC_VECTOR(0 TO 17);
        LEDG : OUT STD_LOGIC_VECTOR(0 TO 7));
END device;

ARCHITECTURE LogicFunction OF device IS
BEGIN
    my_mux : ENTITY work.multiplexer(LogicFunction) PORT MAP(IN1 => SW(0), IN2 => SW(1), SEL => SW(2), RESULT => LEDR(0));
END LogicFunction;