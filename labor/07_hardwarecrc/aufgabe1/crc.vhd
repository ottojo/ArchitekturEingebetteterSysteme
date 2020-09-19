-- CRC-7 (8bit Generator)
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY crc IS
    PORT (
        G : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Generator polynomial
        DataBusIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DataBusOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Clock : IN STD_LOGIC;
        Enable : IN STD_LOGIC;
        Done : OUT STD_LOGIC
    );
END crc;

ARCHITECTURE Behavior OF crc IS
BEGIN
    PROCESS (Clock)
        VARIABLE reg : STD_LOGIC_VECTOR(31 DOWNTO 0);
    BEGIN
        IF RISING_EDGE(Clock) THEN
            IF Enable = '1' THEN
                Done <= '0';
                reg := DataBusIn;
                FOR i IN 0 TO 31 LOOP
                    IF reg(31) = '1' THEN
                        reg := std_logic_vector(shift_left(unsigned(reg), 1));
                        reg(31 DOWNTO 25) := reg(31 DOWNTO 25) XOR G(6 DOWNTO 0);
                    ELSE
                        reg := std_logic_vector(shift_left(unsigned(reg), 1));
                    END IF;
                END LOOP;
                DataBusOut <= reg;
                Done <= '1';
            END IF;
        END IF;
    END PROCESS;
END Behavior;