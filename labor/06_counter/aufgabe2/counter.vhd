LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY counter IS
    PORT (
        CLOCK_50 : IN STD_LOGIC;
        HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END counter;

ARCHITECTURE behavior OF counter IS
    SIGNAL clk_1 : STD_LOGIC; -- 10 Hz clock
    SIGNAL number_signal : STD_LOGIC_VECTOR(11 DOWNTO 0); -- Output number
    SIGNAL thousands : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL hundreds : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL tens : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL ones : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

    Digit0 : ENTITY work.htb(LogicFunction) PORT MAP (ones, HEX0);
    Digit1 : ENTITY work.htb(LogicFunction) PORT MAP (tens, HEX1);
    Digit2 : ENTITY work.htb(LogicFunction) PORT MAP (hundreds, HEX2);
    Digit3 : ENTITY work.htb(LogicFunction) PORT MAP (thousands, HEX3);

    bcd : ENTITY work.bin2bcd_12bit(Behavioral)
        PORT MAP(number_signal, ones, tens, hundreds, thousands);

    -- Make a 10 Hz, 50% duty cycle clock
    PROCESS (CLOCK_50, clk_1)
        VARIABLE count : INTEGER RANGE 0 TO 2500000;
    BEGIN
        IF RISING_EDGE(CLOCK_50) THEN
            IF count = 2500000 THEN
                clk_1 <= NOT clk_1;
                count := 0;
            ELSE
                count := count + 1;
            END IF;
        END IF;
    END PROCESS;

    -- Increment the number each clock cycle
    PROCESS (clk_1)
        VARIABLE number : INTEGER RANGE 0 TO 999;
    BEGIN
        IF RISING_EDGE(clk_1) THEN
            IF number = 999 THEN
                number := 0;
            ELSE
                number := number + 1;
            END IF;
        END IF;
        number_signal <= conv_std_logic_vector(number, 12);
    END PROCESS;
END behavior;