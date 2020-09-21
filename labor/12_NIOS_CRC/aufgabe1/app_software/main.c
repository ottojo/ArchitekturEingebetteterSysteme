#include <stdio.h>
#include <io.h>
#include <stdint.h>

#define CRC_BASE 0x10004000
int main()
{
    // Write initial value to data register
    volatile uint32_t initialValue = 0xCAFE;
    IOWR_32DIRECT(CRC_BASE, 0, initialValue);
    // Read it back
    printf("Written: 0x%x\n", IORD_32DIRECT(CRC_BASE, 0));

    uint8_t polynomial = 0b10001001;
    // Write polynomial to config register
    IOWR_32DIRECT(CRC_BASE, 4, polynomial << 24);
    // Read it back
    printf("Written to config: 0x%x\n", IORD_32DIRECT(CRC_BASE, 4));

    // Command is polynomial and enable bit
    volatile uint32_t command = (polynomial << 24) | 1;
    IOWR_32DIRECT(CRC_BASE, 4, command);
    printf("Written to config: 0x%x\n", command);

    // Wait for computation to complete (enable bit reset)
    volatile uint32_t res = command;
    while (res & 1)
    {
        res = IORD_32DIRECT(CRC_BASE, 4);
    }

    // Read result
    res = IORD_32DIRECT(CRC_BASE, 0);
    printf("Result: 0x%x\n", res);
}