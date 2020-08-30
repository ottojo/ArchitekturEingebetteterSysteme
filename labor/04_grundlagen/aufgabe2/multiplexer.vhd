LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY multiplexer IS
    PORT (
        IN1 : IN std_logic_vector(0 TO 2);
        IN2 : IN std_logic_vector(0 TO 2);
        IN3 : IN std_logic_vector(0 TO 2);
        IN4 : IN std_logic_vector(0 TO 2);
        IN5 : IN std_logic_vector(0 TO 2);
        SEL : IN std_logic_vector(0 TO 2);
        RESULT : OUT std_logic_vector(0 TO 2)
    );
END multiplexer;

ARCHITECTURE LogicFunction OF multiplexer IS
BEGIN
    WITH SEL SELECT
        RESULT <= IN1 WHEN "000",
        IN2 WHEN "100",
        IN3 WHEN "010",
        IN4 WHEN "110",
        IN5 WHEN "001",
        IN1 WHEN OTHERS;
END LogicFunction;