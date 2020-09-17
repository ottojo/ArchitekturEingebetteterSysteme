-- A gated D latch
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY d_latch IS
    PORT (
        Clk : IN STD_LOGIC;
        D : IN STD_LOGIC;
        Q : OUT STD_LOGIC);
END d_latch;

ARCHITECTURE Structural OF d_latch IS
    SIGNAL R, S, R_g, S_g, Qa, Qb : STD_LOGIC;
    ATTRIBUTE KEEP : BOOLEAN;
    ATTRIBUTE KEEP OF R_g, S_g, Qa, Qb : SIGNAL IS TRUE;
BEGIN
    S <= D;
    R <= NOT D;
    R_g <= NOT (R AND Clk);
    S_g <= NOT (S AND Clk);
    Qa <= NOT (S_g AND Qb);
    Qb <= NOT (R_g AND Qa);
    Q <= Qa;
END Structural;