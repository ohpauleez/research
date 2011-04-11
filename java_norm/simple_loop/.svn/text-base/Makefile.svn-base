###############
# A Makefile for the simple loop example
##############
#JAVAC = javac
#JAVA = java
JAVAC = /usr/lib/soylatte/bin/javac
JAVA = /usr/lib/soylatte/bin/java
PY = python

SRC_DIR = ./src/
CLASS_DIR = ./build/class/
ASM_DIR = ./build/asm/
ASM2CLASS_DIR = ./build/asm2class
JAD_DIR = ./build/jad/
JAD_FROM_ASM_DIR = $(JAD_DIR)/from_asm/
JAD_FROM_ORG_DIR = $(JAD_DIR)/from_org/
UTIL_DIR = ./util/
COCOA_UTIL_DIR = $(UTIL_DIR)/cocoa
OBJC_UTIL_DIR = $(UTIL_DIR)/objc

JASM = $(JAVA) JasminVisitor
JASMIN = $(JAVA) -jar jasmin.jar
JAD = ../util/jadmx158/jad

SRC_FILES = $(SRC_DIR)/*.java
CLASS_FILES = $(CLASS_DIR)/*.class
ASM_FILES = $(ASM_DIR)/*.j
ASM2CLASS_FILES = $(ASM2CLASS_DIR)/*.class
JAD_FROM_ASM_FILES = $(JAD_FROM_ASM_DIR)/*.jad
JAD_FROM_ORG_FILES = $(JAD_FROM_ORG_DIR)/*.jad

JAVA_FLAGS = -d $(CLASS_DIR)
JAD_ASM_FLAGS = -d $(JAD_FROM_ASM_DIR)
JAD_ORG_FLAGS = -d $(JAD_FROM_ORG_DIR)



all: jad util

classes:
	$(JAVAC) $(JAVA_FLAGS) $(SRC_FILES)

asm: classes
	cd ../util/jasm; \
	$(JASM) ../../simple_loop/$(CLASS_FILES); \
	mv ./*.j ../../simple_loop/$(ASM_DIR); \
	cd ../../simple_loop;

asm2class: asm
	cd ../util/jasm/jasmin-2.2; \
	$(JASMIN) ../../../simple_loop/$(ASM_FILES); \
	mv ./*.class ../../../simple_loop/$(ASM2CLASS_DIR); \
	cd ../../../simple_loop;

jad: asm2class
	$(JAD) $(JAD_ASM_FLAGS) $(ASM2CLASS_FILES); \
	$(JAD) $(JAD_ORG_FLAGS) $(CLASS_FILES);
	
util-cocoa:
	cd $(COCOA_UTIL_DIR); make; cd ../..;

util-cocoa-test:
	cd $(COCOA_UTIL_DIR); make test; cd ../..;

util-cocoa-test-run: util-cocoa-test
	$(COCOA_UTIL_DIR)/bin/lcstest;

util-objc:
	cd $(OBJC_UTIL_DIR); make; cd ../..;

util: util-objc util-cocoa

clean:
	$(RM) $(CLASS_FILES) $(ASM_FILES) $(ASM2CLASS_FILES) $(JAD_FROM_ASM_FILES) $(JAD_FROM_ORG_FILES) \
	$(UTIL_DIR)/py/*.pyc; \
	cd $(COCOA_UTIL_DIR); make clean; cd ../..; \
	cd $(OBJC_UTIL_DIR); make clean; cd ../..;
	

