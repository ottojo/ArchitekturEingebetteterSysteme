LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY flipflop IS
    PORT (
        D, Clk : IN STD_LOGIC;
        Q : OUT STD_LOGIC);
END flipflop;
ARCHITECTURE Behavior OF flipflop IS
BEGIN
    PROCESS (D, Clk)
    BEGIN
        IF RISING_EDGE(Clk) THEN
            Q <= D;
        END IF;
    END PROCESS;
END Behavior;