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
#include "platform.h"

/* Size of the Data Set */
#define SIZE (40)

/*void main() {

  unsigned char test[SIZE] = { 34, 201, 190, 154,   8, 194,   2,   6,
                              114,  88,  45,  76, 123,  87,  25,  23,
                              200, 122, 150, 90,   92,  87, 177, 244,
                              201,   6,  12,  60,   8,   2,   5,  67,
                                7,  87, 250, 230,  99,   3, 100,  90};

  sort_array(test, SIZE);
  print_array(test,SIZE);
  print_statistics(test, SIZE);

}*/

/*Implementation File Code Here */
void sort_array(unsigned char *array, char lenght){
  unsigned char act = 0;
  for (int j=0; j < lenght; j++){
    for (int i = 0; i < lenght; i++){
      if (array[i] < array[i + 1]){
        act = array[i];
        array[i] = array[i + 1];
        array[i +1] = act;
      }
    }  
  }
  return;
}

void print_array(unsigned char *array, char lenght){
  #if defined (VERBOSE)  
    for (int i = 0; i < lenght; i++){
      if ((i == 7)|(i == 14)|(i == 21)|(i == 28)|(i == 39)){
        return PRINTF("Element %d: %d\n", i, array[i]);
      }
      else return PRINTF("Element %d: %d  ", i, array[i]); 
    }
  #endif
  return;
}

unsigned char find_median(unsigned char *array, char lenght){
  if (SIZE % 2 == 0){
    return array[SIZE/2];
  }
  else{
    unsigned char x = ceil(SIZE/2);
    unsigned char y = floor(SIZE/2);
    return (unsigned char) (array[x]+array[y])/2;
  }
}

unsigned char find_maximum(unsigned char *array, char lenght){
  return array[0];
}

unsigned char find_minimum(unsigned char *array, char lenght){
  return array[SIZE-1];
}

unsigned char find_mean(unsigned char *array, char lenght){
  unsigned char sum = 0;
  for (int i = 0; i < lenght; i++){
    sum += array[i];
  }
  return (unsigned char) sum/(SIZE-1);
}

void print_statistics(unsigned char *array, char lenght){
  PRINTF("\nArray Statistics:\n");
  PRINTF("Median: %d\n", find_median(array, lenght));
  PRINTF("Max: %d\n", find_maximum(array, lenght));
  PRINTF("Min: %d\n", find_minimum(array, lenght));
  PRINTF("Mean: %d\n", find_mean(array, lenght));
  return;
}

