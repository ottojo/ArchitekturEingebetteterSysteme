LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ding IS
    PORT (
        DataBusIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DataBusOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Clock : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Address : IN STD_LOGIC;
        Write : IN STD_LOGIC
    );
END ding;

ARCHITECTURE Behavior OF ding IS
BEGIN
    PROCESS (Clock, Reset)
        VARIABLE data : STD_LOGIC_VECTOR(31 DOWNTO 0);
        VARIABLE increment : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE enable : STD_LOGIC;
    BEGIN
        IF (Reset = '1') THEN
            -- Reset
            data := (OTHERS => '0');
            DataBusOut <= data;
            increment := (OTHERS => '0');
            enable := '0';
        ELSIF RISING_EDGE(Clock) THEN
            IF Write = '1' THEN
                -- Input
                IF Address = '1' THEN
                    -- control
                    increment := DataBusIn(31 DOWNTO 24);
                    enable := DataBusIn(0);
                ELSE
                    -- data
                    data := DataBusIn;
                END IF;
            ELSIF enable = '1' THEN
                -- Calculation
                data := std_logic_vector(unsigned(data) + unsigned(increment));
                enable := '0';
            END IF;

            -- Set correct output depending on address
            IF Address = '0' THEN
                DataBusOut <= data;
            ELSE
                DataBusOut <= (OTHERS => '0');
                DataBusOut(31 DOWNTO 24) <= increment;
                DataBusOut(0) <= enable;
            END IF;
        END IF;
    END PROCESS;
END Behavior;