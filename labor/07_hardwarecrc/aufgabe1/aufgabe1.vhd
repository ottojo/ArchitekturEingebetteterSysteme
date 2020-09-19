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
    SIGNAL G : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL DataOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL display : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Enable : STD_LOGIC;
BEGIN

    LEDR <= SW;
    G <= "10100101";
    Data(31 DOWNTO 8) <= x"00abcd";
    Data(7 DOWNTO 0) <= SW(7 DOWNTO 0);

    DigitIn0 : ENTITY work.htb(LogicFunction) PORT MAP (Data(3 DOWNTO 0), HEX0);
    DigitIn1 : ENTITY work.htb(LogicFunction) PORT MAP (Data(7 DOWNTO 4), HEX1);
    DigitIn2 : ENTITY work.htb(LogicFunction) PORT MAP (Data(11 DOWNTO 8), HEX2);
    DigitIn3 : ENTITY work.htb(LogicFunction) PORT MAP (Data(15 DOWNTO 12), HEX3);
    DigitIn4 : ENTITY work.htb(LogicFunction) PORT MAP (Data(19 DOWNTO 16), HEX4);
    DigitIn5 : ENTITY work.htb(LogicFunction) PORT MAP (Data(23 DOWNTO 20), HEX5);

    DigitOut0 : ENTITY work.htb(LogicFunction) PORT MAP (display(3 DOWNTO 0), HEX6);
    DigitOut1 : ENTITY work.htb(LogicFunction) PORT MAP (display(7 DOWNTO 4), HEX7);

    display(6 DOWNTO 0) <= DataOut(31 DOWNTO 25);

    CRC : ENTITY work.crc(Behavior)
        PORT MAP(
            G => G,
            DataBusIn => Data,
            DataBusOut => DataOut,
            Clock => CLOCK_50,
            Enable => SW(16),
            Done => LEDG(0));
END Structural;