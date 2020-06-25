/**
 * @file 
 * @brief 
 *
 *
 * @author 
 * @date 
 *
 */
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include "data.h"

uint8_t my_itoa(int32_t data, uint8_t * ptr, uint32_t base){
  bool Neg = false;
  uint8_t length = 0;
  if ((data < 0) & (base == 10)){
    Neg = true;
    data = data * -1;
  }
  *ptr = 0;
  length++;
  while (data !=0){
    int mod = data % base;
    if (mod > 9){
      *(ptr+length) = mod + 65;
    }
    else{
      *(ptr+length) = mod + 48;
    }
    data = data / base;
    length++;
  }
  if (Neg){
    *(ptr) = 45;
    length++;
  }
  return length;
}

int32_t my_atoi(uint8_t * ptr, uint8_t digits, uint32_t base){
  int32_t value;
  int32_t sign = 1;
  int32_t pot = 1;
  if (*ptr == '-'){
    sign = -1;
    ptr++;
  }
  for (int i = digits -1; i > 0; i--){
    value += *(ptr+i) * pot;
    pot = pot * base;
  }
  value = value * sign;
  return value;
}
 
