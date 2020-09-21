## Hardware CRC Integration
Da das Integrieren der Hardware CRC nicht auf Anhieb wie in der Anleitung
funktioniert hat (Resultierende Checksumme war immer `0x00`), wurde zum Debuggen
eine VHDL Komponente mit ähnlicher Schnittstelle konstruiert:
```vhdl
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ding IS
    PORT (
        DataBusIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DataBusOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Clock : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Address : IN STD_LOGIC;
        Write : IN STD_LOGIC
    );
END ding;

ARCHITECTURE Behavior OF ding IS
BEGIN
    PROCESS (Clock, Reset)
        VARIABLE data : STD_LOGIC_VECTOR(31 DOWNTO 0);
        VARIABLE increment : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE enable : STD_LOGIC;
    BEGIN
        IF (Reset = '1') THEN
            -- Reset
            data := (OTHERS => '0');
            DataBusOut <= data;
            increment := (OTHERS => '0');
            enable := '0';
        ELSIF RISING_EDGE(Clock) THEN
            IF Write = '1' THEN
                -- Input
                IF Address = '1' THEN
                    -- control
                    increment := DataBusIn(31 DOWNTO 24);
                    enable := DataBusIn(0);
                ELSE
                    -- data
                    data := DataBusIn;
                END IF;
            ELSIF enable = '1' THEN
                -- Calculation
                data := std_logic_vector(unsigned(data) + unsigned(increment));
                enable := '0';
            END IF;

            -- Set correct output depending on address
            IF Address = '0' THEN
                DataBusOut <= data;
            ELSE
                DataBusOut <= (OTHERS => '0');
                DataBusOut(31 DOWNTO 24) <= increment;
                DataBusOut(0) <= enable;
            END IF;
        END IF;
    END PROCESS;
END Behavior;
```

Die Komponente hat wie die CRC zwei Register, wobei im ersten die Daten, auf
denen gearbeitet wird stehen, und im zweiten eine Konfiguration und ein `enable`
Signal. Statt der CRC-Berechnung wird hier eine einfache Addition durchgeführt,
wobei der eine Summand die Daten und der andere Summand die 8-Bit Konfiguration
(Polynom beim CRC) ist.

Die Komponente wurde dann in ein QSys Modul integriert, und zur Konfiguration
hinzugefügt.
Für das Lesen und Schreiben der Register werden die Makros `IOWR_32DIRECT` und
`IORD_32DIRECT` aus dem `io.h` Header verwendet:
```c
#include <stdio.h>
#include <io.h>
#include <stdint.h>

#define DING_BASE 0x10004000
int main()
{
    // Write initial value to data register
    volatile uint32_t initialValue = 0xFF0;
    IOWR_32DIRECT(DING_BASE, 0, initialValue);
    // Read it back
    printf("Written: 0x%x\n", IORD_32DIRECT(DING_BASE, 0));

    uint8_t increment = 3;
    // Write increment to config register
    IOWR_32DIRECT(DING_BASE, 4, increment << 24);
    // Read it back
    printf("Written to config: 0x%x\n", IORD_32DIRECT(DING_BASE, 4));

    for (int i = 0; i < 10; i++)
    {
        // Command is increment and enable bit
        volatile uint32_t command = (increment << 24) | 1;
        IOWR_32DIRECT(DING_BASE, 4, command);
        printf("Written to config: 0x%x\n", command);

        // Wait for computation to complete (enable bit reset)
        volatile uint32_t res = command;
        while (res & 1)
        {
            res = IORD_32DIRECT(DING_BASE, 4);
        }

        // Read result
        res = IORD_32DIRECT(DING_BASE, 0);
        printf("Result: 0x%x\n", res);
    }
}
```

Wie zu erwarten, inkrementiert die Hardware-Komponente den internen Wert bei
jedem Aktivieren des `enable` bits um den eingestellten Wert.
