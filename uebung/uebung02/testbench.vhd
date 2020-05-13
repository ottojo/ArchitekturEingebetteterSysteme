-- Testbench of Multiplexer

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY testbench IS
    -- empty
END testbench;

ARCHITECTURE tb OF testbench IS
    CONSTANT W : INTEGER := 3;

    -- DUT component
    COMPONENT mux IS
        GENERIC (N : INTEGER);
        PORT (
            in0, in1, in2, in3, in4 : IN std_logic_vector (N - 1 DOWNTO 0);
            sel : IN std_logic_vector (2 DOWNTO 0);
            out0 : OUT std_logic_vector (N - 1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL tb_in0, tb_in1, tb_in2, tb_in3, tb_in4, tb_out0 : std_logic_vector (W - 1 DOWNTO 0);
    SIGNAL tb_sel : std_logic_vector (2 DOWNTO 0);

BEGIN

    -- Connect DUT
    DUT : mux
    GENERIC MAP(N => W)
    PORT MAP(tb_in0, tb_in1, tb_in2, tb_in3, tb_in4, tb_sel, tb_out0);

    PROCESS
    BEGIN

        ASSERT false REPORT "Running testbench" SEVERITY note;

        -- Clear inputs
        tb_in0 <= std_logic_vector(to_unsigned(0, tb_in0'length));
        tb_in1 <= std_logic_vector(to_unsigned(0, tb_in1'length));
        tb_in2 <= std_logic_vector(to_unsigned(0, tb_in2'length));
        tb_in3 <= std_logic_vector(to_unsigned(0, tb_in3'length));
        tb_in4 <= std_logic_vector(to_unsigned(0, tb_in4'length));
        tb_sel <= std_logic_vector(to_unsigned(0, tb_sel'length));
        WAIT FOR 1 ns;

        FOR in0 IN 0 TO (2 ** W) - 1 LOOP
            FOR in1 IN 0 TO (2 ** W) - 1 LOOP
                FOR in2 IN 0 TO (2 ** W) - 1 LOOP
                    FOR in3 IN 0 TO (2 ** W) - 1 LOOP
                        FOR in4 IN 0 TO (2 ** W) - 1 LOOP
                            tb_in0 <= std_logic_vector(to_unsigned(in0, tb_in0'length));
                            tb_in1 <= std_logic_vector(to_unsigned(in1, tb_in1'length));
                            tb_in2 <= std_logic_vector(to_unsigned(in2, tb_in2'length));
                            tb_in3 <= std_logic_vector(to_unsigned(in3, tb_in3'length));
                            tb_in4 <= std_logic_vector(to_unsigned(in4, tb_in4'length));
                            tb_sel <= "000";
                            WAIT FOR 1 ns;
                            ASSERT(tb_out0 = std_logic_vector(to_unsigned(in0, tb_in0'length)))
                            REPORT "Test Case " & INTEGER'IMAGE(in0) & ", " & INTEGER'IMAGE(in1) & ", " & INTEGER'IMAGE(in2) & ", " & INTEGER'IMAGE(in3) & ", " & INTEGER'IMAGE(in4) & ", sel=0 failed" SEVERITY error;

                            tb_sel <= "001";
                            WAIT FOR 1 ns;
                            ASSERT(tb_out0 = std_logic_vector(to_unsigned(in1, tb_in0'length)))
                            REPORT "Test Case " & INTEGER'IMAGE(in0) & ", " & INTEGER'IMAGE(in1) & ", " & INTEGER'IMAGE(in2) & ", " & INTEGER'IMAGE(in3) & ", " & INTEGER'IMAGE(in4) & ", sel=1 failed" SEVERITY error;

                            tb_sel <= "010";
                            WAIT FOR 1 ns;
                            ASSERT(tb_out0 = std_logic_vector(to_unsigned(in2, tb_in0'length)))
                            REPORT "Test Case " & INTEGER'IMAGE(in0) & ", " & INTEGER'IMAGE(in1) & ", " & INTEGER'IMAGE(in2) & ", " & INTEGER'IMAGE(in3) & ", " & INTEGER'IMAGE(in4) & ", sel=2 failed" SEVERITY error;

                            tb_sel <= "011";
                            WAIT FOR 1 ns;
                            ASSERT(tb_out0 = std_logic_vector(to_unsigned(in3, tb_in0'length)))
                            REPORT "Test Case " & INTEGER'IMAGE(in0) & ", " & INTEGER'IMAGE(in1) & ", " & INTEGER'IMAGE(in2) & ", " & INTEGER'IMAGE(in3) & ", " & INTEGER'IMAGE(in4) & ", sel=3 failed" SEVERITY error;

                            tb_sel <= "100";
                            WAIT FOR 1 ns;
                            ASSERT(tb_out0 = std_logic_vector(to_unsigned(in4, tb_in0'length)))
                            REPORT "Test Case " & INTEGER'IMAGE(in0) & ", " & INTEGER'IMAGE(in1) & ", " & INTEGER'IMAGE(in2) & ", " & INTEGER'IMAGE(in3) & ", " & INTEGER'IMAGE(in4) & ", sel=4 failed" SEVERITY error;
                        END LOOP;
                    END LOOP;
                END LOOP;
            END LOOP;
        END LOOP;
        ASSERT false REPORT "Test done." SEVERITY note;
        WAIT;

    END PROCESS;

END tb;