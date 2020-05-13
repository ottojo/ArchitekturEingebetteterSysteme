-- Multiplexer in VHDL
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux IS
    GENERIC (N : INTEGER);
    PORT (
        in0, in1, in2, in3, in4 : IN std_logic_vector (N - 1 DOWNTO 0);
        sel : IN std_logic_vector (2 DOWNTO 0);
        out0 : OUT std_logic_vector (N - 1 DOWNTO 0)
    );
END mux;

ARCHITECTURE dataflow OF mux IS
BEGIN
    PROCESS (sel)
    BEGIN
        CASE(sel) IS
            WHEN "000" => out0 <= in0;
            WHEN "001" => out0 <= in1;
            WHEN "010" => out0 <= in2;
            WHEN "011" => out0 <= in3;
            WHEN "100" => out0 <= in4;
            WHEN OTHERS => out0 <= in4;
        END CASE;
    END PROCESS;
END dataflow;