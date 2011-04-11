# A Makefile for GNUStep and Cocoa

CC=gcc
FRAMEWORKS=-framework Foundation -framework SenTestingKit

SRC_DIR=./src/
TEST_DIR=./test/
LCS_SRC_DIR=$(SRC_DIR)/LCS/
LCS_TEST_DIR=$(TEST_DIR)/LCS/
LCS_SRC=$(LCS_SRC_DIR)/*.m
LCS_TEST_SRC=$(LCS_TEST_DIR)/*.m
BUILD_DIR=./build/
LCS_BUILD_DIR=$(BUILD_DIR)/LCS/
LCS_TEST_BUILD_DIR=$(LCS_BUILD_DIR)/test/
LCS_OBJS=$(LCS_BUILD_DIR)/*.o
LCS_TEST_OBJS=$(LCS_TEST_BUILD_DIR)/*.o
BIN_DIR=./bin/

OBJC_FLAGS=-c -fobjc-exceptions

all: lcs

lcs:
ifdef GNUSTEP_SYSTEM_ROOT
	make -f ./GNUmakefile.lcs
else
	$(CC) $(FRAMEWORKS) $(OBJC_FLAGS) $(LCS_SRC); \
	mv *.o $(LCS_BUILD_DIR); \
	$(CC) $(FRAMEWORKS) $(LCS_OBJS) -o $(BIN_DIR)/lcs
endif

test: lcs
	$(CC) $(FRAMEWORKS) $(OBJC_FLAGS) -I$(LCS_SRC_DIR) $(LCS_TEST_SRC); \
	mv *.o $(LCS_TEST_BUILD_DIR); \
	$(CC) $(FRAMEWORKS) $(LCS_TEST_OBJS) $(LCS_BUILD_DIR)/LCS.o -o $(BIN_DIR)/lcstest


clean:
	$(RM) $(LCS_OBJS) $(LCS_TEST_OBJS) $(BIN_DIR)/*


