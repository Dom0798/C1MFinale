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
# Use: make [TARGET] [PLATFORM-OVERRIDES] [FUNCTION-OVERRIDE] [DEBUG-OVERRIDE]
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
# Function Overrride:
#	FUNCTION = (COURSE1)

# Debug Overrride:
#	DEBUG = (VERBOSE)
#------------------------------------------------------------------------------
include sources.mk

#DEBUG Override
ifeq ($(DEBUG), VERBOSE)
	DF = -D$(DEBUG)
endif

#Function Override
FUNCTION = 
ifeq ($(FUNCTION), COURSE1)
	CF = -D$(FUNCTION) 
endif

# Platform Overrides
#------------------------------------------------------------------------------
ifeq ($(PLATFORM), MSP432)
	PF = -D$(PLATFORM)
else ifeq ($(PLATFORM), HOST)
	PF = -D$(PLATFORM)
endif

# Architectures Specific Flags
#------------------------------------------------------------------------------
LINKER_FILE = msp432p401r.lds
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
	LDFLAGS = -Wall -Werror -g -O0 -std=c99 -Wl,-Map=$(TARGET).map -T$(LINKER_FILE)
else
	CC = gcc
	LDFLAGS = -Wall -Werror -g -O0 -std=c99 -Wl,-Map=$(TARGET).map
endif
LD = arm-none-eabi-ld
CFLAGS = -mcpu=$(CPU) -march=$(ARCH) -m$(STATE) -mfloat-abi=$(ABI) -mfpu=$(FPU) --specs=$(SPECS)

#Target and file conversions
#------------------------------------------------------------------------------
TARGET = c1m4
OBJS = $(SOURCES:.c=.o)
LIBS = $(INCLUDES)
DEPS = $(SOURCES:.c=.d)
PRE = $(SOURCES:.c=.i)
ASM = $(SOURCES:.c=.asm)

#File builds as user wants
#------------------------------------------------------------------------------
%.i : %.c
ifeq ($(PLATFORM), MSP432)
	$(CC) -E $< $(CFLAGS) $(LIBS) $(PF) $(DF) $(CF) $(LDFLAGS) -MD -o $@
else
	$(CC) -E $< $(LIBS) $(PF) $(DF) $(CF) $(LDFLAGS) -MD -o $@
endif

%.asm : %.c
ifeq ($(PLATFORM), MSP432)
	$(CC) $(LIBS) $(PF) $(DF) $(CF) -c $< $(CFLAGS) $(LDFLAGS) -MD -o $@
	arm-none-eabi-objdump -S $@
else
	$(CC) $(LIBS) -c $(PF) $(DF) $(CF) $< $(LDFLAGS) -MD -o $@
	objdump -S $@
endif

%.o : %.c
ifeq ($(PLATFORM), MSP432)
	$(CC) $(LIBS) $(PF) $(DF) $(CF) -c $< $(CFLAGS) $(LDFLAGS) -MD -o $@
else
	@echo "Compiling $< to $@..."
	@$(CC) $(LIBS) $(PF) $(DF) $(CF) -c $< $(LDFLAGS) -MD -o $@
endif

#Build all files
#------------------------------------------------------------------------------
.PHONY: build
build: all

.PHONY: all
all: $(TARGET).out

$(TARGET).out: $(OBJS)
ifeq ($(PLATFORM), MSP432)
	@echo "Using: $(PLATFORM)"
	@echo "Using: $(FUNCTION)"
	@echo "Debug: $(DEBUG)"
	@echo "Building $(OBJS) to $@..."
	@$(CC) $(OBJS) $(PF) $(DF) $(CF) $(LIBS) $(CFLAGS) $(LDFLAGS) -o $@
	@echo Size of code:
	arm-none-eabi-size -Btd $@
else
	@echo "\nCompiling for: $(PLATFORM)"
	@echo "Using: $(FUNCTION)"
	@echo "Debug: $(DEBUG)"
	@echo "Building $(OBJS) to $@..."
	@$(CC) $(OBJS) $(PF) $(DF) $(CF) $(LIBS) $(LDFLAGS) -o $@
	@echo "\nSize of code:"
	@size -Btd $@
endif

#Compile all files
#------------------------------------------------------------------------------
.PHONY: compile-all
compile-all: call

.PHONY: call
call: $(TARGET)c.out

$(TARGET)c.out: $(OBJS)
ifeq ($(PLATFORM), MSP432)
	$(CC) -c $(OBJS) $(PF) $(DF) $(CF) $(LIBS) $(CFLAGS) $(LDFLAGS) -o $@
else
	$(CC) -c $(OBJS) $(PF) $(DF) $(CF) $(LIBS) $(LDFLAGS) -o $@
endif

#Remove generated files
#------------------------------------------------------------------------------
.PHONY: clean
clean:
	@ rm -f $(OBJS) $(TARGET).map $(TARGET).out $(DEPS) $(PRE) $(ASM) ./src/*.out ./src/*.map
	@echo "\n***All files generated removed***\n"
	
