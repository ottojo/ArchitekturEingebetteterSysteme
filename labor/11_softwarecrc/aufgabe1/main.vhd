-- CLOCK_50 is the system clock.
-- KEY0 is the active-low system reset.
-- SDRAM ports correspond to the signals in Figure 2; their names are those
-- used in the DE2-115 User Manual.
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY main IS
    PORT (
        KEY : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        CLOCK_50 : IN STD_LOGIC;
        DRAM_DQ : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        DRAM_ADDR : OUT STD_LOGIC_VECTOR (12 DOWNTO 0);
        DRAM_BA : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
        DRAM_CAS_N, DRAM_RAS_N, DRAM_CLK : OUT STD_LOGIC;
        DRAM_CKE, DRAM_CS_N, DRAM_WE_N : OUT STD_LOGIC;
        DRAM_DQM : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END main;
ARCHITECTURE Structure OF main IS
    COMPONENT nios_system
        PORT (
            clk_clk : IN STD_LOGIC;
            reset_reset : IN STD_LOGIC;
            sdram_clk_clk : OUT STD_LOGIC;
            sdram_wire_addr : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
            sdram_wire_ba : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            sdram_wire_cas_n : OUT STD_LOGIC;
            sdram_wire_cke : OUT STD_LOGIC;
            sdram_wire_cs_n : OUT STD_LOGIC;
            sdram_wire_dq : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            sdram_wire_dqm : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            sdram_wire_ras_n : OUT STD_LOGIC;
            sdram_wire_we_n : OUT STD_LOGIC);
    END COMPONENT;
BEGIN
    -- Instantiate the Nios II system entity generated by the Qsys tool.
    NiosII : nios_system
    PORT MAP(
        clk_clk => CLOCK_50,
        reset_reset => NOT KEY(0),
        sdram_clk_clk => DRAM_CLK,
        sdram_wire_addr => DRAM_ADDR,
        sdram_wire_ba => DRAM_BA,
        sdram_wire_cas_n => DRAM_CAS_N,
        sdram_wire_cke => DRAM_CKE,
        sdram_wire_cs_n => DRAM_CS_N,
        sdram_wire_dq => DRAM_DQ,
        sdram_wire_dqm => DRAM_DQM,
        sdram_wire_ras_n => DRAM_RAS_N,
        sdram_wire_we_n => DRAM_WE_N);
END Structure;