-- Multiplexer in VHDL
library IEEE;
use IEEE.std_logic_1164.all;

entity mux is
    port(
            in0, in1, sel: in std_logic;
            out0: out std_logic
    );
end mux;

architecture dataflow of mux is
begin
    out0 <= in1 when sel = '1'
            else in0;
end dataflow;
