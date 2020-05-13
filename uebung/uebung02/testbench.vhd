-- Testbench of Multiplexer

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY testbench IS
    -- empty
END testbench;

ARCHITECTURE tb OF testbench IS

    -- DUT component
    COMPONENT mux IS
        PORT (
            in0, in1 : IN std_logic_vector (7 DOWNTO 0);
            sel : IN std_logic;
            out0 : OUT std_logic_vector (7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL tb_in0, tb_in1, tb_out0 : std_logic_vector (7 DOWNTO 0);
    SIGNAL tb_sel : std_logic;

BEGIN

    -- Connect DUT
    DUT : mux PORT MAP(tb_in0, tb_in1, tb_sel, tb_out0);

    PROCESS
    BEGIN

        ASSERT false REPORT "Running testbench" SEVERITY note;

        -- Clear inputs
        tb_in0 <= x"00";
        tb_in1 <= x"00";
        tb_sel <= '0';
        WAIT FOR 1 ns;

        FOR in0 IN 16#0# TO 16#ff# LOOP
            FOR in1 IN 16#0# TO 16#ff# LOOP
                tb_in0 <= std_logic_vector(to_unsigned(in0, tb_in0'length));
                tb_in1 <= std_logic_vector(to_unsigned(in1, tb_in1'length));
                tb_sel <= '0';
                WAIT FOR 1 ns;
                ASSERT(tb_out0 = std_logic_vector(to_unsigned(in0, tb_in0'length)))
                REPORT "Test Case " & INTEGER'IMAGE(in0) & ", " & INTEGER'IMAGE(in1) & ", sel=0 failed" SEVERITY error;

                tb_sel <= '1';
                WAIT FOR 1 ns;
                ASSERT(tb_out0 = std_logic_vector(to_unsigned(in1, tb_in0'length)))
                REPORT "Test Case " & INTEGER'IMAGE(in0) & ", " & INTEGER'IMAGE(in1) & ", sel=1 failed" SEVERITY error;
            END LOOP;
        END LOOP;
        ASSERT false REPORT "Test done." SEVERITY note;
        WAIT;

    END PROCESS;

END tb;