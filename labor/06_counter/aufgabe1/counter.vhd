LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY counter IS
    PORT (
        CLOCK_50 : IN STD_LOGIC;
        HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END counter;

ARCHITECTURE behavior OF counter IS
    SIGNAL clk_1 : STD_LOGIC; -- 1 Hz clock
    SIGNAL number_signal : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Output number
BEGIN

    Digit0 : ENTITY work.htb(LogicFunction) PORT MAP (number_signal, HEX0);

    -- Make a 1 Hz, 50% duty cycle clock
    PROCESS (CLOCK_50, clk_1)
        VARIABLE count : INTEGER RANGE 0 TO 25000000;
    BEGIN
        IF RISING_EDGE(CLOCK_50) THEN
            IF count = 25000000 THEN
                clk_1 <= NOT clk_1;
                count := 0;
            ELSE
                count := count + 1;
            END IF;
        END IF;
    END PROCESS;

    -- Increment the number each clock cycle
    PROCESS (clk_1)
        VARIABLE number : INTEGER RANGE 0 TO 9;
    BEGIN
        IF RISING_EDGE(clk_1) THEN
            IF number = 9 THEN
                number := 0;
            ELSE
                number := number + 1;
            END IF;
        END IF;
        number_signal <= conv_std_logic_vector(number, 4);
    END PROCESS;
END behavior;