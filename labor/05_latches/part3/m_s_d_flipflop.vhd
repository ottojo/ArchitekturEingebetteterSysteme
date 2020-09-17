-- master-slave D flip-flop
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ms_d_flipflop IS
    PORT (
        Clk : IN STD_LOGIC;
        D : IN STD_LOGIC;
        Q : OUT STD_LOGIC);
END ms_d_flipflop;

ARCHITECTURE Structural OF ms_d_flipflop IS
    SIGNAL Qm : STD_LOGIC;
BEGIN
    master_latch : work.d_latch
    PORT MAP(
        D => D,
        Clk => NOT Clk,
        Q => Qm
    );

    slave_latch : work.d_latch
    PORT MAP(
        D => Qm,
        Clk => Clk,
        Q => Q
    );
END Structural;