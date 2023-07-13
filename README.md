# Compiler

## Info
The program was debugged using GDB and Mars version 4.5.

All funtions must have a return including voids

When fuctions are called, thier arguments are stored in memory then the function moves its stackpointer to just after the last argument passed.
The funtion then reads these in and uses them as needed. Thus the fuction accepts any number of arguments.

## Bugs to fix:
* you cant assign and declare in one step
* you cant pass array vals to funtions

## Running the Program
To run, first install lex and bison ```sudo apt-get install bison flex```

Once these are installed you can build the compiler by simply running ```make``` and you can clean the residual objects by running ```make clean```.

Once the compiler is built compile code by running ```./obj/mcc file.mC``` eg. (```./obj/mcc test/cases/asmTest.mC```). The code can be run using mars with ```make compile```.
Alternatively, you can paste the generated asembly into mars and run it that way.
