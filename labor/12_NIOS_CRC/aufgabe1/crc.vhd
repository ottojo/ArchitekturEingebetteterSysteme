-- CRC-7 (8bit Generator)
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY crc IS
    PORT (
        DataBusIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DataBusOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Clock : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Address : IN STD_LOGIC;
        Write : IN STD_LOGIC
    );
END crc;

ARCHITECTURE Behavior OF crc IS
BEGIN

    PROCESS (Clock, Write, Address)
        VARIABLE reg : STD_LOGIC_VECTOR(31 DOWNTO 0);
        VARIABLE Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
        VARIABLE Enable : STD_LOGIC;
        VARIABLE G : STD_LOGIC_VECTOR(7 DOWNTO 0);
    BEGIN
        -- TODO: Reset
        IF RISING_EDGE(Clock) THEN
            IF Write = '1' THEN
                -- Input
                IF Address = '1' THEN
                    -- Set generator and enable bit
                    G := DataBusIn(31 DOWNTO 24);
                    Enable := DataBusIn(0);
                ELSE
                    -- Read input data
                    Data := DataBusIn;
                END IF;
            ELSIF Enable = '1' THEN
                -- Calculate CRC
                reg := Data;
                FOR i IN 0 TO 31 LOOP
                    IF reg(31) = '1' THEN
                        reg := std_logic_vector(shift_left(unsigned(reg), 1));
                        reg(31 DOWNTO 25) := reg(31 DOWNTO 25) XOR G(6 DOWNTO 0);
                    ELSE
                        reg := std_logic_vector(shift_left(unsigned(reg), 1));
                    END IF;
                END LOOP;
                Data := reg;
                Enable := '0';
            END IF;

            -- Set correct output depending on address
            IF Address = '0' THEN
                DataBusOut <= Data;
            ELSE
                DataBusOut <= (OTHERS => '0');
                DataBusOut(31 DOWNTO 24) <= G;
                DataBusOut(0) <= Enable;
            END IF;
        END IF;
    END PROCESS;
END Behavior;