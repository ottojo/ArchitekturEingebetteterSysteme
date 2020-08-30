LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY display IS
    PORT (
        INPUT : IN std_logic_vector(3 DOWNTO 0);
        OUTPUT : OUT std_logic_vector(0 TO 6)
    );
END display;

ARCHITECTURE LogicFunction OF display IS
BEGIN
    WITH INPUT SELECT
        OUTPUT <= "0000001" WHEN X"0",
        "1001111" WHEN X"1",
        "0010010" WHEN X"2",
        "0000110" WHEN X"3",
        "1001100" WHEN X"4",
        "0100100" WHEN X"5",
        "0100000" WHEN X"6",
        "0001111" WHEN X"7",
        "0000000" WHEN X"8",
        "0000100" WHEN X"9",
        "0001000" WHEN X"A",
        "1100000" WHEN X"B",
        "1110010" WHEN X"C",
        "1000010" WHEN X"D",
        "0110000" WHEN X"E",
        "0111000" WHEN X"F",
        "0000001" WHEN OTHERS;
END LogicFunction;