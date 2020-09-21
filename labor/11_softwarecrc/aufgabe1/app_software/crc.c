#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#define N 7
#define DEBUG

bool msb(uint32_t reg)
{
    if (reg & 0b10000000000000000000000000000000)
    {
        return true;
    }
    else
    {
        return false;
    }
}

void printBin(uint32_t n)
{
    printf("0b");
    for (int i = 0; i < 32; i++)
    {
        if (msb(n) == true)
        {
            printf("1");
        }
        else
        {
            printf("0");
        }
        n <<= 1;
        if (i == N - 1)
        {
            printf("|");
        }
    }
    printf("\n");
}

uint8_t topNbits(uint32_t in)
{
    in >>= 32 - N;
    return in & 0xFF;
}

/**
 * In-place CRC-7
 */
void crc7(uint32_t *reg, uint8_t polynomial)
{
#ifdef DEBUG
    printf("Input reg: ");
    printBin(*reg);
#endif
    uint32_t positionedPolynomial = polynomial;
    positionedPolynomial <<= 32 - N;
#ifdef DEBUG
    printf("Positioned polynomial: ");
    printBin(positionedPolynomial);
#endif
    for (int i = 0; i < 32; i++)
    {
#ifdef DEBUG
        printf("-\nReg at start:    ");
        printBin(*reg);
#endif
        if (msb(*reg) == 1)
        {
            *reg ^= positionedPolynomial;
#ifdef DEBUG
            printf("Reg after xor:   ");
            printBin(*reg);
#endif
            *reg <<= 1;
        }
        else
        {
            *reg <<= 1;
        }
#ifdef DEBUG
        printf("Reg after shift: ");
        printBin(*reg);
#endif
    }
}

uint8_t getCRC7(uint32_t payload, uint8_t poly)
{
    crc7(&payload, poly);
    return topNbits(payload);
}

bool checkCRC7(uint32_t payload, uint8_t checksum, uint8_t polynomial)
{
    payload <<= N;
    payload |= checksum;
#ifdef DEBUG
    printf("pl+crc: 0x%x\n", payload);
    printBin(payload);
#endif

    uint8_t crc = getCRC7(payload, polynomial);

    if (crc == 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}

int main()
{
#ifdef DEBUG
    uint32_t payload = 0xCAFE;
    uint8_t poly = 0b10001001;
    uint8_t checksum = getCRC7(payload, poly);
    printf("Checksum: 0x%x   ", checksum);
    printBin(checksum);
    printf("Valid? %d\n", checkCRC7(payload, checksum, poly));
    payload ^= 0b10000;
    printf("Valid after flipping bit? %d\n", checkCRC7(payload, checksum, poly));
#endif
}