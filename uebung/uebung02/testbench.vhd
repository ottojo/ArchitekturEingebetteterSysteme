-- Testbench of Multiplexer

library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
    -- empty
end testbench;

architecture tb of testbench is

    -- DUT component
    component mux is
        port(
            in0, in1, sel: in std_logic;
             out0: out std_logic
         );
    end component;

    signal tb_in0, tb_in1, tb_sel, tb_out0: std_logic;

begin

    -- Connect DUT
    DUT: mux port map (tb_in0, tb_in1, tb_sel, tb_out0);

    process
    begin

        assert false report "Running testbench" severity note;

        -- Clear inputs
        tb_in0 <= '0';
        tb_in1 <= '0';
        tb_sel <= '0';
        wait for 1 ns;

        -- Test case: 0, 0, sel=0
        tb_in0 <= '0';
        tb_in1 <= '0';
        tb_sel <= '0';
        wait for 1 ns;
        assert(tb_out0 = '0') report "Test Case 0, 0, sel=0 failed" severity error;

        -- Test case: 1, 0, sel=0
        tb_in0 <= '1';
        tb_in1 <= '0';
        tb_sel <= '0';
        wait for 1 ns;
        assert(tb_out0 = '1') report "Test Case 1, 0, sel=0 failed" severity error;

        -- Test case: 0, 1, sel=0
        tb_in0 <= '0';
        tb_in1 <= '1';
        tb_sel <= '0';
        wait for 1 ns;
        assert(tb_out0 = '0') report "Test Case 0, 1, sel=0 failed" severity error;

        -- Test case: 1, 0, sel=0
        tb_in0 <= '1';
        tb_in1 <= '1';
        tb_sel <= '0';
        wait for 1 ns;
        assert(tb_out0 = '1') report "Test Case 1, 1, sel=0 failed" severity error;

        -- Test case: 1, 0, sel=0
        tb_in0 <= '0';
        tb_in1 <= '0';
        tb_sel <= '1';
        wait for 1 ns;
        assert(tb_out0 = '0') report "Test Case 0, 0, sel=1 failed" severity error;

        -- Test case: 1, 0, sel=0
        tb_in0 <= '1';
        tb_in1 <= '0';
        tb_sel <= '1';
        wait for 1 ns;
        assert(tb_out0 = '0') report "Test Case 1, 0, sel=1 failed" severity error;

        -- Test case: 1, 0, sel=0
        tb_in0 <= '0';
        tb_in1 <= '1';
        tb_sel <= '1';
        wait for 1 ns;
        assert(tb_out0 = '1') report "Test Case 0, 1, sel=1 failed" severity error;

        -- Test case: 1, 0, sel=0
        tb_in0 <= '1';
        tb_in1 <= '1';
        tb_sel <= '1';
        wait for 1 ns;
        assert(tb_out0 = '1') report "Test Case 1, 1, sel=1 failed" severity error;

        assert false report "Test done." severity note;
        wait;

    end process;

end tb;
