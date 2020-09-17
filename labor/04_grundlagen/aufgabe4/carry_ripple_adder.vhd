LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY carry_ripple_adder IS
    GENERIC (
        BIT_WIDTH : INTEGER := 4
    );
    PORT (
        a : IN std_logic_vector(BIT_WIDTH - 1 DOWNTO 0);
        b : IN std_logic_vector(BIT_WIDTH - 1 DOWNTO 0);
        ci : IN std_logic;
        s : OUT std_logic_vector(BIT_WIDTH - 1 DOWNTO 0);
        co : OUT std_logic
    );
END carry_ripple_adder;

ARCHITECTURE LogicFunction OF carry_ripple_adder IS
    -- Carry input for each adder, needed to connect adders
    -- Length is one more than number of adders, for carry output
    SIGNAL c_inputs : std_logic_vector(BIT_WIDTH DOWNTO 0);
BEGIN
    gen : FOR i IN 0 TO BIT_WIDTH - 1 GENERATE
        adder : work.fulladder PORT MAP(a => a(i), b => b(i), ci => c_inputs(i), s => s(i), co => c_inputs(i + 1));
    END GENERATE;
    c_inputs(0) <= ci;
    co <= c_inputs(BIT_WIDTH);
END LogicFunction;