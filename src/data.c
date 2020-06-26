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
#include "stats.h"
#include "course1.h"
#include "platform.h"
#include "memory.h"
#include "data.h"

uint8_t my_itoa(int32_t data, uint8_t * ptr, uint32_t base){
  bool Neg = false;
  uint32_t length = 0;
  if ((data < 0)){
    Neg = true;
    data = data * -1;
  }
  while (data != 0){
    uint8_t mod = data % base;
    length++;
    if (mod > 9){
      *(ptr+length) = mod + 'A';
    }
    else{
      *(ptr+length) = mod + '0';
    }
    data = data / base;
  }
  if (Neg){
    length++;
    *(ptr+length) = '-';
  }
  length++;
  *(ptr) = '\0';
  my_reverse(ptr,length);
  return length;
}

int32_t my_atoi(uint8_t * ptr, uint8_t digits, uint32_t base){
  int32_t value = 0;
  int32_t sign = 1;
  int32_t pow = 1;
  int32_t fs = 0;
  if (*(ptr) == '-'){
    sign = -1;
    fs = -1;
    ptr++;
  }
  for (int i = digits-2+fs; i >= 0; i--){
    value +=  pow * (*(ptr+i) - '0');
    pow *= base;
  }
  value = value * sign;
  return value;
}
 
