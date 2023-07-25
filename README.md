# mC Compiler

## Prerequisites
* lex and bison 
  * ```sudo apt-get install bison=3.8.2 flex=2.6.4```
* java
  * ```sudo apt install openjdk-11-jre```
* python3 (for running tests)
  * ```sudo apt install python3```

## Info
The program was debugged using GDB and Mars version 4.5.

All funtions must have a return including voids

When fuctions are called, thier arguments are stored in memory then the function moves its stackpointer to just after the last argument passed.
The funtion then reads these in and uses them as needed. Thus the fuction accepts any number of arguments.

## Running the Program
1. You can run the compiler with your source code by running ```make compile INPUT_FILE={sample_file.mC} OUTPUT_FILE=sample_file.asm``` 
   1. eg. ```make compile INPUT_FILE=test/cases/asmTest.mC OUTPUT_FILE=test.asm```. 
2. After you can run the code by running ```make execute OUTPUT_FILE=test.asm```.

## Bugs to fix:
* you cant assign and declare in one step
* you cant pass array vals to funtions
