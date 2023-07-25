CC = gcc
CFLAGS = -I./src -std=gnu99 -g 

LEX=lex

YACC=yacc
YFLAGS=-v -d -b obj/y
GRAMMAR=parser.y

obj/mcc: obj/lex.yy.o obj/y.tab.o obj/tree.o obj/driver.o obj/strtab.o | obj
	$(CC) $(CFLAGS) -o $@ $^ -ll

obj/y.tab.o: obj/y.tab.c | obj
	$(CC) $(CFLAGS) -c $< -o $@

obj/lex.yy.o: obj/lex.yy.c | obj
	$(CC) $(CFLAGS) -c $< -o $@

obj/y.tab.h obj/y.tab.c: src/$(GRAMMAR)  src/tree.h | obj
	$(YACC) $(YFLAGS) $<

obj/lex.yy.c: src/scanner.l obj/y.tab.h | obj
	$(LEX) -o $@ $<

obj/tree.o: src/tree.c src/tree.h | obj
	$(CC)  $(CFLAGS) -c $< -o $@

obj/driver.o: src/driver.c src/tree.h obj/y.tab.h | obj
	$(CC)  $(CFLAGS) -c $< -o $@

obj/strtab.o: src/strtab.c src/strtab.h obj/y.tab.h | obj
	$(CC)  $(CFLAGS) -c $< -o $@

.PHONY: clean test objdir

obj:
	@mkdir -p obj

clean:
	@rm -rf obj
	@rm -f lex.yy.* *.o *~ scanner
	@rm -f *.asm

test: obj/mcc
	@python3 test/test_runner.py


CHECK_INPUT_FILE := $(if $(INPUT_FILE),$(INPUT_FILE),test/cases/asmTest2.mC)
CHECK_OUTPUT_FILE := $(if $(OUTPUT_FILE),$(OUTPUT_FILE),asm.asm)

compile: obj/mcc
	@echo "Checking for INPUT_FILE and OUTPUT_FILE..."
	@if [ -z "$(INPUT_FILE)" ]; then \
		echo "INPUT_FILE not set, defaulting to 'test/cases/asmTest2.mC'"; \
	fi
	@if [ -z "$(OUTPUT_FILE)" ]; then \
		echo "OUTPUT_FILE not set, defaulting to 'asm.asm'"; \
	fi
	./obj/mcc $(CHECK_INPUT_FILE) $(CHECK_OUTPUT_FILE)


execute:
	@echo "Checking for OUTPUT_FILE..."
	@if [ -z "$(OUTPUT_FILE)" ]; then \
		echo "OUTPUT_FILE not set, defaulting to 'asm.asm'"; \
	fi
	java -jar Mars4_5.jar 10000 $(CHECK_OUTPUT_FILE)

lint:
	~/.local/bin/cpplint src/driver.c src/tree.c src/tree.h src/strtab.c src/strtab.h
