#******************************************************************************
# Copyright (C) 2017 by Alex Fosdick - University of Colorado
#
# Redistribution, modification or use of this software in source or binary
# forms is permitted as long as the files maintain this copyright. Users are 
# permitted to modify this and use it to learn about the field of embedded
# software. Alex Fosdick and the University of Colorado are not liable for any
# misuse of this material. 
#
#*****************************************************************************

#------------------------------------------------------------------------------
# Simple makefile for HOST and MSP432 microcontroller
#
# Use: make [TARGET] [PLATFORM-OVERRIDES]
#
# Build Targets:
#      <FILE>.o - Builds <FILE>.o object file
#      <FILE>.i - Builds <FILE>.i preprocessed file
#      <FILE>.asm - Builds <FILE>.asm assembly file
#      build - Builds and links all source files
#      compile-all - Compiles all the source files
#      clean - removes all generated files
#
# Platform Overrides:
#      PLATFORM = Platform where it is going to compile (HOST, MSP432)
#
#------------------------------------------------------------------------------
include sources.mk

# Platform Overrides
#------------------------------------------------------------------------------
PLATFORM = MSP432
ifeq ($(PLATFORM), MSP432)
	PF = -DMSP432
else
	PF = -DHOST
endif

# Architectures Specific Flags
#------------------------------------------------------------------------------
LINKER_FILE = ../msp432p401r.lds
CPU = cortex-m4
ARCH = armv7e-m
SPECS = nosys.specs
STATE = thumb
FPU = fpv4-sp-d16
ABI = hard

# Compiler Flags and Defines
#------------------------------------------------------------------------------
ifeq ($(PLATFORM), MSP432)
	CC = arm-none-eabi-gcc
	LDFLAGS = -Wall -Werror -g -O0 -std=c99 -Wl,-Map=$(TARGET).map -T$(LINKER_FILE) -D$(PLATFORM)
else
	CC = gcc
	LDFLAGS = -Wall -Werror -g -O0 -std=c99 -Wl,-Map=$(TARGET).map -D$(PLATFORM)
endif
LD = arm-none-eabi-ld
CFLAGS = -mcpu=$(CPU) -march=$(ARCH) -m$(STATE) -mfloat-abi=$(ABI) -mfpu=$(FPU) --specs=$(SPECS)

#Target and file conversions
#------------------------------------------------------------------------------
TARGET = c1m2
OBJS = $(SOURCES:.c=.o)
LIBS = $(INCLUDES)
DEPS = $(SOURCES:.c=.d)
PRE = $(SOURCES:.c=.i)
ASM = $(SOURCES:.c=.asm)

#File builds as user wants
#------------------------------------------------------------------------------
%.i : %.c
ifeq ($(PLATFORM), MSP432)
	$(CC) -E $< $(CFLAGS) $(LIBS) $(PF) $(LDFLAGS) -MD -o $@
else
	$(CC) -E $< $(LIBS) $(PF) $(LDFLAGS) -MD -o $@
endif

%.asm : %.c
ifeq ($(PLATFORM), MSP432)
	$(CC) $(LIBS) $(PF) -c $< $(CFLAGS) $(LDFLAGS) -MD -o $@
	arm-none-eabi-objdump -S $@
else
	$(CC) $(LIBS) -c $(PF) $< $(LDFLAGS) -MD -o $@
	objdump -S $@
endif

%.o : %.c
ifeq ($(PLATFORM), MSP432)
	$(CC) $(LIBS) $(PF) -c $< $(CFLAGS) $(LDFLAGS) -MD -o $@
else
	$(CC) $(LIBS) $(PF) -c $< $(LDFLAGS) -MD -o $@
endif

#Build all files
#------------------------------------------------------------------------------
.PHONY: build
build: all

.PHONY: all
all: $(TARGET).out

$(TARGET).out: $(OBJS)
ifeq ($(PLATFORM), MSP432)
	$(CC) $(OBJS) $(PF) $(LIBS) $(CFLAGS) $(LDFLAGS) -o $@
	arm-none-eabi-size -Btd $@
else
	$(CC) $(OBJS) $(PF) $(LIBS) $(LDFLAGS) -o $@
	size -Btd $@
endif

#Compile all files
#------------------------------------------------------------------------------
.PHONY: compile-all
compile-all: call

.PHONY: call
call: $(TARGET)c.out

$(TARGET)c.out: $(OBJS)
ifeq ($(PLATFORM), MSP432)
	$(CC) -c $(OBJS) $(PF) $(LIBS) $(CFLAGS) $(LDFLAGS) -o $@
else
	$(CC) -c $(OBJS) $(PF) $(LIBS) $(LDFLAGS) -o $@
endif

#Remove generated files
#------------------------------------------------------------------------------
.PHONY: clean
clean:
	rm -f $(OBJS) $(DEPS) $(PRE) $(ASM) $(TARGET).out $(TARGET).map
	
