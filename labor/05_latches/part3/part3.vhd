LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY part3 IS
    PORT (
        SW : IN std_logic_vector(17 DOWNTO 0);
        LEDR : OUT std_logic_vector(17 DOWNTO 0);
        LEDG : OUT std_logic_vector(7 DOWNTO 0);
        HEX0 : OUT std_logic_vector(0 TO 6));
END part3;
ARCHITECTURE Structural OF part3 IS
BEGIN
    LEDR <= SW;
    flipflop : work.ms_d_flipflop
    PORT MAP(
        D => SW(0),
        Clk => SW(1),
        Q => LEDG(0));
END Structural;