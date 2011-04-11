# A Makefile for GNUStep and Cocoa

CC=gcc

SRC_DIR=./src/
LCS_SRC_DIR=$(SRC_DIR)/LCS/
LCS_SRC=$(LCS_SRC_DIR)/*.m
BUILD_DIR=./build/
LCS_BUILD_DIR=$(BUILD_DIR)/LCS/
LCS_OBJS=$(LCS_BUILD_DIR)/*.o
BIN_DIR=./bin/

OBJC_FLAGS=-c
LDFLAGS = -l objc

all: lcs

lcs:
	$(CC) $(OBJC_FLAGS) $(LCS_SRC) $(LDFLAGS); \
	mv *.o $(LCS_BUILD_DIR); \
	$(CC) $(LCS_OBJS) -o $(BIN_DIR)/lcs $(LDFLAGS)

clean:
	$(RM) $(LCS_OBJS) $(BIN_DIR)/*


