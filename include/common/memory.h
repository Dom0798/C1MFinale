/******************************************************************************
 * Copyright (C) 2017 by Alex Fosdick - University of Colorado
 *
 * Redistribution, modification or use of this software in source or binary
 * forms is permitted as long as the files maintain this copyright. Users are 
 * permitted to modify this and use it to learn about the field of embedded
 * software. Alex Fosdick and the University of Colorado are not liable for any
 * misuse of this material. 
 *
 *****************************************************************************/
/**
 * @file memory.h
 * @brief Abstraction of memory read and write operations
 *
 * This header file provides an abstraction of reading and
 * writing to memory via function calls. 
 *
 * @author Alex Fosdick
 * @date April 1 2017
 *
 */
#ifndef __MEMORY_H__
#define __MEMORY_H__
/**
 * @brief Sets a value of a data array 
 *
 * Given a pointer to a char data set, this will set a provided
 * index into that data set to the value provided.
 *
 * @param ptr Pointer to data array
 * @param index Index into pointer array to set value
 * @param value value to write the the locaiton
 *
 * @return void.
 */
void set_value(char * ptr, unsigned int index, char value);

/**
 * @brief Clear a value of a data array 
 *
 * Given a pointer to a char data set, this will clear a provided
 * index into that data set to the value zero.
 *
 * @param ptr Pointer to data array
 * @param index Index into pointer array to set value
 *
 * @return void.
 */
void clear_value(char * ptr, unsigned int index);

/**
 * @brief Returns a value of a data array 
 *
 * Given a pointer to a char data set, this will read the provided
 * index into that data set and return the value.
 *
 * @param ptr Pointer to data array
 * @param index Index into pointer array to set value
 *
 * @return Value to be read.
 */
char get_value(char * ptr, unsigned int index);

/**
 * @brief Sets data array elements to a value
 *
 * Given a pointer to a char data set, this will set a number of elements
 * from a provided data array to the given value. The length is determined
 * by the provided size parameter.
 *
 * @param ptr Pointer to data array
 * @param value value to write the the locaiton
 * @param size Number of elements to set to value
 *
 * @return void.
 */
void set_all(char * ptr, char value, unsigned int size);

/**
 * @brief Clears elements in a data array
 *
 * Given a pointer to a char data set, this will set a clear a number
 * of elements given the size provided. Clear means to set to zero. 
 *
 * @param ptr Pointer to data array
 * @param size Number of elements to set to zero
 *
 * @return void.
 */
void clear_all(char * ptr, unsigned int size);

/**
 * @brief Moves bytes of data
 *
 * The src data, that fits in length, will be moved to dst. Cares about overlapping.
 *
 * @param src Pointer to source
 * @param dst Pointer to destination
 * @param lenght Number of bytes
 *
 * @return pointer to dst
 */
uint8_t * my_memmove(uint8_t * src, uint8_t * dst, size_t length);

/**
 * @brief Copies bytes of data
 *
 * The src data, that fits in lenght, will be copied to dst. Does not care about overlapping.
 *
 * @param src Pointer to source
 * @param dst Pointer to destination
 * @param lenght Number of bytes
 *
 * @return pointer to dst
 */
uint8_t * my_memcopy(uint8_t * src, uint8_t * dst, size_t length);

/**
 * @brief Set values of memory location
 *
 * The value should be set to all the location within the lenght
 *
 * @param src Pointer to source
 * @param lenght Number of bytes
 * @param value Value to set
 *
 * @return pointer to src
 */
uint8_t * my_memset(uint8_t * src, size_t length, uint8_t value);

/**
 * @brief Set values of memory location to zero
 *
 * Zero out all the memory locations
 *
 * @param src Pointer to source
 * @param lenght Number of bytes
 *
 * @return pointer to src
 */
uint8_t * my_memzero(uint8_t * src, size_t length);

/**
 * @brief Reverse the memory location
 *
 * Reverse the order of all bytes at memory location
 *
 * @param src Pointer to source
 * @param lenght Number of bytes
 *
 * @return pointer to src
 */
uint8_t * my_reverse(uint8_t * src, size_t length);

/**
 * @brief Allocate in dynamic memory
 *
 * Given a number of words, it allocates them in dynamic memory
 *
 * @param lenght Number of words
 *
 * @return pointer to memory if succesful, null if not
 */
int32_t * reserve_words(size_t length);

/**
 * @brief Free dynamic memory allocation
 *
 * Frees space in dynamic memory of a previous allocation
 *
 * @param src Pointer to source
 *
 * @return none
 */
void free_words(int32_t * src);

#endif /* __MEMORY_H__ */
