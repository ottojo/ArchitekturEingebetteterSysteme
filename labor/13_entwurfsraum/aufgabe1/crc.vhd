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
    PROCESS (Clock, Reset)
        VARIABLE Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
        VARIABLE G : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE enable : STD_LOGIC;
    BEGIN
        IF (Reset = '1') THEN
            -- Reset
            Data := (OTHERS => '0');
            DataBusOut <= Data;
            G := (OTHERS => '0');
            enable := '0';
        ELSIF RISING_EDGE(Clock) THEN
            IF Write = '1' THEN
                -- Input
                IF Address = '1' THEN
                    -- control
                    G := DataBusIn(31 DOWNTO 24);
                    enable := DataBusIn(0);
                ELSE
                    -- Data
                    Data := DataBusIn;
                END IF;
            ELSIF enable = '1' THEN
                -- Calculation
                FOR i IN 0 TO 31 LOOP
                    IF Data(31) = '1' THEN
                        Data(31 DOWNTO 25) := Data(31 DOWNTO 25) XOR G(6 DOWNTO 0);
                    END IF;
                    Data := std_logic_vector(shift_left(unsigned(Data), 1));
                END LOOP;
                Data(6 DOWNTO 0) := Data(31 DOWNTO 25);
                Data(31 DOWNTO 7) := (OTHERS => '0');
                enable := '0';
            END IF;

            -- Set correct output depending on address
            IF Address = '0' THEN
                DataBusOut <= Data;
            ELSE
                DataBusOut <= (OTHERS => '0');
                DataBusOut(31 DOWNTO 24) <= G;
                DataBusOut(0) <= enable;
            END IF;
        END IF;
    END PROCESS;
END Behavior;