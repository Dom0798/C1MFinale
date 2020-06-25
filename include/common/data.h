/**
 * @file data.h
 * @brief Header for functions in data.c
 *
 *
 * @author Domenico Morales
 * @date 24/06/2020
 *
 */
#ifndef __DATA_H__
#define __DATA_H__
#include <stdint.h>
#include <stdlib.h>
 /**
 * @brief Int to ASCII
 *
 * Turns a int number to an ASCII string
 *
 * @param data Int number
 * @param ptr Pointer where it is saved the conversion
 * @param base Base of conversion
 *
 * @return return the length of pointer
 */
 uint8_t my_itoa(int32_t data, uint8_t * ptr, uint32_t base);

 /**
 * @brief ASCII to Int
 *
 * Turns ASCII string to Int number
 *
 * @param ptr ASCII array number
 * @param digits Number of digits to convert
 * @param base Base of conversion
 *
 * @return return value of number
 */
 int32_t my_atoi(uint8_t * ptr, uint8_t digits, uint32_t base);
 
#endif /* __DATA_H__ */
