LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY part4 IS
    PORT (
        SW : IN std_logic_vector(17 DOWNTO 0);
        LEDR : OUT std_logic_vector(17 DOWNTO 0);
        LEDG : OUT std_logic_vector(7 DOWNTO 0);
        HEX0 : OUT std_logic_vector(0 TO 6));
END part4;
ARCHITECTURE Structural OF part4 IS
BEGIN
    LEDR <= SW;
    l1 : work.d_latch
    PORT MAP(
        D => SW(0),
        Clk => SW(1),
        Q => LEDG(0));
    ff1 : work.flipflop
    PORT MAP(
        D => SW(0),
        Clk => SW(1),
        Q => LEDG(1));
    ff2 : work.flipflop
    PORT MAP(
        D => SW(0),
        Clk => NOT SW(1),
        Q => LEDG(2));
END Structural;