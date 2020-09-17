LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY aufgabe4 IS
    PORT (
        SW : IN std_logic_vector(17 DOWNTO 0);
        LEDR : OUT std_logic_vector(17 DOWNTO 0);
        LEDG : OUT std_logic_vector(7 DOWNTO 0);
        HEX0 : OUT std_logic_vector(0 TO 6));
END aufgabe4;

ARCHITECTURE LogicFunction OF aufgabe4 IS
BEGIN
    LEDR <= SW;
    adder : work.carry_ripple_adder
    GENERIC MAP(BIT_WIDTH => 4)
    PORT MAP(
        a => SW(3 DOWNTO 0),
        b => SW(7 DOWNTO 4),
        ci => SW(8),
        s => LEDG(3 DOWNTO 0),
        co => LEDG(4));

END LogicFunction;