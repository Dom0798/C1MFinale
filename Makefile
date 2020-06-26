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
#      scr/<FILE>.o - Builds <FILE>.o object file
#      scr/<FILE>.i - Builds <FILE>.i preprocessed file
#      scr/<FILE>.asm - Builds <FILE>.asm assembly file
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
else ifeq ($(PLATFORM), HOST)
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
	@echo "Building $< to $@..."
	@$(CC) -E $< $(CFLAGS) $(LIBS) $(PF) $(DF) $(CF) $(LDFLAGS) -MD -o $@
	@echo "\nDone!"
else ifeq ($(PLATFORM), HOST)
	@echo "Building $< to $@..."
	@$(CC) -E $< $(LIBS) $(PF) $(DF) $(CF) $(LDFLAGS) -MD -o $@
	@echo "\nDone!"
endif

%.asm : %.c
ifeq ($(PLATFORM), MSP432)
	@echo "Building $< to $@..."
	@$(CC) $(LIBS) $(PF) $(DF) $(CF) -c $< $(CFLAGS) $(LDFLAGS) -MD -o $@
	@echo "\nDone!"
	@echo "\nAssembly:"
	@arm-none-eabi-objdump -S $@
else ifeq ($(PLATFORM), HOST)
	@echo "Building $< to $@..."
	@$(CC) $(LIBS) $(PF) $(DF) $(CF) -c $< $(LDFLAGS) -MD -o $@
	@echo "\nDone!"
	@echo "\nAssembly:"
	@objdump -S $@
endif

%.o : %.c
ifeq ($(PLATFORM), MSP432)
	@echo "Compiling $< to $@..."
	@$(CC) $(LIBS) $(PF) $(DF) $(CF) -c $< $(CFLAGS) $(LDFLAGS) -MD -o $@
else ifeq ($(PLATFORM), HOST)
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
	@echo "\nDone!"
	@echo "\nSize of code:"
	@arm-none-eabi-size -Btd $@
else ifeq ($(PLATFORM), HOST)
	@echo "\nCompiling for: $(PLATFORM)"
	@echo "Using: $(FUNCTION)"
	@echo "Debug: $(DEBUG)"
	@echo "Building $(OBJS) to $@..."
	@$(CC) $(OBJS) $(PF) $(DF) $(CF) $(LIBS) $(LDFLAGS) -o $@
	@echo "\nDone!"
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
	@echo "\nCompiling for: $(PLATFORM)"
	@echo "Using: $(FUNCTION)"
	@echo "Debug: $(DEBUG)"
	@$(CC) -c $(OBJS) $(PF) $(DF) $(CF) $(LIBS) $(CFLAGS) $(LDFLAGS) -o $@
	@echo "\nDone!"
else ifeq ($(PLATFORM), HOST)
	@echo "\nCompiling for: $(PLATFORM)"
	@echo "Using: $(FUNCTION)"
	@echo "Debug: $(DEBUG)"
	@$(CC) -c $(OBJS) $(PF) $(DF) $(CF) $(LIBS) $(LDFLAGS) -o $@
	@echo "\nDone!"
endif

#Remove generated files
#------------------------------------------------------------------------------
.PHONY: clean
clean:
	@ rm -f $(OBJS) $(TARGET).map $(TARGET).out $(DEPS) $(PRE) $(ASM) ./src/*.out ./src/*.map
	@echo "\n           ***All files generated removed***\n"
	
