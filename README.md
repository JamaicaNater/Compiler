The program was debugged using GDB and Mars version 4.5. Run the assembly code you can copy the assembly code in to mars and run it. 
alternativly if you are using the provided makefile you can type "make compile"

Note: all funtions must have a return including voids

Bugs: you cant assign and declare in one step
	you cant pass array vals to funtions

When fuctions are called thier arguments are stored in memory then the function moves its stackpointer to just after the last argument passed.
The funtion then reads these in  and uses them as needed. Thus the fuction accepts any number of arguments.

To run, first install lex and bison shell```sudo apt-get install bison flex```

Once these are install you can compile the compiler by simply running shell```make``` and you can clean the code by running shell```make```.
You can addtionally compile code by running shell```./obj/mcc file.mC``` eg. (shell```./obj/mcc test/cases/asmTest.mC```). The code can be run using mars with shell```make compile```
