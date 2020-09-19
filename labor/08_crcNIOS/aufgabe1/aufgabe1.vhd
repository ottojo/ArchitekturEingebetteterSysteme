LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY aufgabe1 IS
    PORT (
        SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
        LEDG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        HEX6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        CLOCK_50 : IN STD_LOGIC);
END aufgabe1;

ARCHITECTURE Structural OF aufgabe1 IS
    SIGNAL Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL DataOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL display : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

    LEDR(6 DOWNTO 0) <= DataOut(6 DOWNTO 0);
    LEDR(14 DOWNTO 7) <= DataOut(31 DOWNTO 24);

    -- Switches:
    -- R W A | 31 30 29 28 27 26 25 24 | 6 5 4 3 2 1 0

    Data(23 DOWNTO 7) <= (OTHERS => '0');
    Data(6 DOWNTO 0) <= SW(6 DOWNTO 0);
    Data(31 DOWNTO 24) <= SW(14 DOWNTO 7);

    DigitOut0 : ENTITY work.htb(LogicFunction) PORT MAP (display(3 DOWNTO 0), HEX6);
    DigitOut1 : ENTITY work.htb(LogicFunction) PORT MAP (display(7 DOWNTO 4), HEX7);
    display(6 DOWNTO 0) <= DataOut(31 DOWNTO 25);

    CRC : ENTITY work.crc(Behavior)
        PORT MAP(
            DataBusIn => Data,
            DataBusOut => DataOut,
            Clock => CLOCK_50,
            Reset => SW(17),
            Write => SW(16),
            Address => SW(15));
END Structural;