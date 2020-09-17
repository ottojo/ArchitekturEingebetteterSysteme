LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fulladder IS
    PORT (
        a : IN std_logic;
        b : IN std_logic;
        ci : IN std_logic;
        s : OUT std_logic;
        co : OUT std_logic
    );
END fulladder;

ARCHITECTURE LogicFunction OF fulladder IS
    SIGNAL ab : std_logic;
BEGIN
    ab <= a XOR b;
    s <= ab XOR ci;
    co <= (ab AND ci) OR (a AND b);
END LogicFunction;