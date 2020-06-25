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
 * @file stats.h
 * @brief Header for functions in stats.c
 *
 * Header file for the functions used in stats.c such as sort_array, print_array, find_minimum, find_maximum, find_median, find_mean and print_statistics.
 *
 * @author Domenico Morales
 * @date 17/06/2020
 *
 */
#ifndef __STATS_H__
#define __STATS_H__

/**
 * @brief Sort the array
 *
 * Sort the array where the first element is the biggest and the last one is the smallest
 *
 * @param array: name of the array to use
 * @param lenght: lenght of the array
 *
 * @return no return
 */
 void sort_array(unsigned char *array, char length);
 
 /**
 * @brief Print the array
 *
 * Print the array given in an organized way
 *
 * @param array: name of the array to use
 * @param lenght: lenght of the array
 *
 * @return no return
 */
 void print_array(unsigned char *array, char length);
 
 /**
 * @brief Find median
 *
 * Gives the median of the values in an array
 *
 * @param array: name of the array to use
 * @param lenght: lenght of the array
 *
 * @return element in the index of the median; if there are two elements, the mean of those
 */
 unsigned char find_median(unsigned char *array, char length);
 
 /**
 * @brief Find maximum
 *
 * Gives the maximum value in an array
 *
 * @param array: name of the array to use
 * @param lenght: lenght of the array
 *
 * @return return the biggest element
 */
 unsigned char find_maximum(unsigned char *array, char length);
 
 /**
 * @brief Find minimum
 *
 * Gives the minimum value in an array
 *
 * @param array: name of the array to use
 * @param lenght: lenght of the array
 *
 * @return return the smallest element
 */
 unsigned char find_minimum(unsigned char *array, char length);
 
 /**
 * @brief Find mean
 *
 * Gives the mean of the values in an array
 *
 * @param array: name of the array to use
 * @param lenght: lenght of the array
 *
 * @return return mean value
 */
 unsigned char find_mean(unsigned char *array, char length);

 /**
 * @brief Print statistics
 *
 * Prints the statistics: minimum, maximum, median and mean, in an organized way
 *
 * @param array: name of the array to use
 * @param lenght: lenght of the array
 *
 * @return no return
 */
 void print_statistics(unsigned char *array, char length);

#endif /* __STATS_H__ */

