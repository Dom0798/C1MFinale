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
 * @file stats.c
 * @brief Assignment Week 1
 *
 * Assignment for the Week 1 of the Introduction to the Embedded Systems Software and Development Course. Given an array, sort it and give the statistics such as min, max, median and mean.
 *
 * @author Domenico Morales
 * @date 17/06/2020
 *
 */
 
#include "stats.h"
#include <math.h>
#include "course1.h"
#include "platform.h"
#include "memory.h"
#include "data.h"

/* Size of the Data Set */
#define SIZE (40)

/*Implementation File Code Here */
void sort_array(unsigned char *array, char length){
  int act = 0;
  for (int j=0; j < length; j++){
    for (int i = j; i < length; i++){
      if (array[j] < array[i]){
        act = array[i];
        array[i] = array[j];
        array[j] = act;
      }
    }  
  }
  return;
}

void print_array(unsigned char *array, char length){
  #ifdef VERBOSE  
  for (int i = 0; i < length; i++){
    PRINTF(" %d ", array[i]); 
  }
  #endif
  return;
}

unsigned char find_median(unsigned char *array, char length){
  if (length % 2 == 0){
    return array[length/2];
  }
  else{
    unsigned char x = ceil(length/2);
    unsigned char y = floor(length/2);
    return (array[x]+array[y])/2;
  }
}

unsigned char find_maximum(unsigned char *array, char length){
  return array[0];
}

unsigned char find_minimum(unsigned char *array, char length){
  return array[length-1];
}

unsigned char find_mean(unsigned char *array, char length){
  int sum = 0;
  for (int i = 0; i < length; i++){
    sum += array[i];
  }
  return sum/(length);
}
void print_statistics(unsigned char *array, char length){
  PRINTF("\nArray Statistics:\n");
  PRINTF("Median: %d\n", find_median(array, length));
  PRINTF("Max: %d\n", find_maximum(array, length));
  PRINTF("Min: %d\n", find_minimum(array, length));
  PRINTF("Mean: %d\n", find_mean(array, length));
  return;
}

