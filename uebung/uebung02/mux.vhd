-- Multiplexer in VHDL
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux IS
    PORT (
        in0, in1 : IN std_logic_vector (7 DOWNTO 0);
        sel : IN std_logic;
        out0 : OUT std_logic_vector (7 DOWNTO 0)
    );
END mux;

ARCHITECTURE dataflow OF mux IS
BEGIN
    out0 <= in1 WHEN sel = '1'
        ELSE
        in0;
END dataflow;