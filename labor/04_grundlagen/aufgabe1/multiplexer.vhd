LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY multiplexer IS
    PORT (
        IN1 : IN std_logic;
        IN2 : IN std_logic;
        SEL : IN std_logic;
        RESULT : OUT std_logic
    );
END multiplexer;

ARCHITECTURE LogicFunction OF multiplexer IS
BEGIN
    WITH SEL SELECT
        RESULT <= IN1 WHEN '0',
        IN2 WHEN '1',
        IN1 WHEN OTHERS;
END LogicFunction;