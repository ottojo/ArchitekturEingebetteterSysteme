LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY htb IS
    PORT (
        INPUT : IN std_logic_vector(3 DOWNTO 0);
        OUTPUT : OUT std_logic_vector(0 TO 6)
    );
END htb;

ARCHITECTURE LogicFunction OF htb IS
BEGIN
    WITH INPUT SELECT
        OUTPUT <= "1000000" WHEN X"0",
        "1111001" WHEN X"1",
        "0100100" WHEN X"2",
        "0110000" WHEN X"3",
        "0011001" WHEN X"4",
        "0010010" WHEN X"5",
        "0000010" WHEN X"6",
        "1111000" WHEN X"7",
        "0000000" WHEN X"8",
        "0010000" WHEN X"9",
        "0001000" WHEN X"A",
        "0000011" WHEN X"B",
        "0100111" WHEN X"C",
        "0100001" WHEN X"D",
        "0000110" WHEN X"E",
        "0001110" WHEN X"F",
        "1000000" WHEN OTHERS;
END LogicFunction;