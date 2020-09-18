--- Binary to BCD, based on the implemtation given on Wikipedia:
--- https://en.wikipedia.org/w/index.php?title=Double_dabble&oldid=957927512

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY bin2bcd_12bit IS
    PORT (
        binIN : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
        ones : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        tens : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        hundreds : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        thousands : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
END bin2bcd_12bit;

ARCHITECTURE Behavioral OF bin2bcd_12bit IS

BEGIN

    bcd1 : PROCESS (binIN)

        -- temporary variable
        VARIABLE temp : STD_LOGIC_VECTOR (11 DOWNTO 0);

        -- variable to store the output BCD number
        -- organized as follows
        -- thousands = bcd(15 downto 12)
        -- hundreds = bcd(11 downto 8)
        -- tens = bcd(7 downto 4)
        -- units = bcd(3 downto 0)
        VARIABLE bcd : UNSIGNED (15 DOWNTO 0) := (OTHERS => '0');

        -- by
        -- https://en.wikipedia.org/wiki/Double_dabble

    BEGIN
        -- zero the bcd variable
        bcd := (OTHERS => '0');

        -- read input into temp variable
        temp(11 DOWNTO 0) := binIN;

        -- cycle 12 times as we have 12 input bits
        -- this could be optimized, we do not need to check and add 3 for the 
        -- first 3 iterations as the number can never be >4
        FOR i IN 0 TO 11 LOOP

            IF bcd(3 DOWNTO 0) > 4 THEN
                bcd(3 DOWNTO 0) := bcd(3 DOWNTO 0) + 3;
            END IF;

            IF bcd(7 DOWNTO 4) > 4 THEN
                bcd(7 DOWNTO 4) := bcd(7 DOWNTO 4) + 3;
            END IF;

            IF bcd(11 DOWNTO 8) > 4 THEN
                bcd(11 DOWNTO 8) := bcd(11 DOWNTO 8) + 3;
            END IF;

            -- thousands can't be >4 for a 12-bit input number
            -- so don't need to do anything to upper 4 bits of bcd

            -- shift bcd left by 1 bit, copy MSB of temp into LSB of bcd
            bcd := bcd(14 DOWNTO 0) & temp(11);

            -- shift temp left by 1 bit
            temp := temp(10 DOWNTO 0) & '0';

        END LOOP;

        -- set outputs
        ones <= STD_LOGIC_VECTOR(bcd(3 DOWNTO 0));
        tens <= STD_LOGIC_VECTOR(bcd(7 DOWNTO 4));
        hundreds <= STD_LOGIC_VECTOR(bcd(11 DOWNTO 8));
        thousands <= STD_LOGIC_VECTOR(bcd(15 DOWNTO 12));

    END PROCESS bcd1;

END Behavioral;