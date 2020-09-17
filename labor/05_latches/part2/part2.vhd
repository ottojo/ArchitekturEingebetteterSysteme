LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY part2 IS
    PORT (
        SW : IN std_logic_vector(17 DOWNTO 0);
        LEDR : OUT std_logic_vector(17 DOWNTO 0);
        LEDG : OUT std_logic_vector(7 DOWNTO 0);
        HEX0 : OUT std_logic_vector(0 TO 6));
END part2;
ARCHITECTURE Structural OF part2 IS
BEGIN
    LEDR <= SW;
    latch : work.d_latch
    PORT MAP(
        D => SW(0),
        Clk => SW(1),
        Q => LEDG(0));
END Structural;