#include<stdio.h>
#include<string.h>
#include<assert.h>
#include<stdlib.h>
#include"strtab.h"
#include"globals.h"


char * reg_names[32] = {
    "$zero", "$at", "$v0", "$v1", "$a0", "$a1", "$a2", "$a3", "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", 
    "$s0", "$s1", "$s2", "$s3", "$s4", "$s5", "$s6", "$s7", "$t8", "$t9", "$k0", "$k1", "$gp", "$sp", "$fp", "$ra"
};

struct reg_val reg_map[32] = {[0 ... 28] = {-1,0}, [29 ... 31] = {0,0}};

int get_and_update_mempos(int index) {
    int mempos = -1;

    struct treenode * functionNode = strTable[ST_lookup(strTable[index].scope, "global")].treeptr;

    if(strTable[index].mempos != -1) { // if the variable already has a location in memory return it
        mempos = strTable[index].mempos;
    } else { // otherwise, allocate the next free block of memory relative to the stack pointer
        if (!is_global(index)){
            mempos = functionNode->val; // mempos =  next availiable block
            strTable[index].mempos = mempos;

            if (is_array(strTable[index].treeptr))
                functionNode->val -= 4 * get_array_val(strTable[index].treeptr);
            else 
                functionNode->val -= 4;
        } else {
            mempos = globalptr;
            strTable[index].mempos = mempos;
            if (is_array(strTable[index].treeptr))
                globalptr -= 4 * get_array_val(strTable[index].treeptr);
            else 
                globalptr -= 4;
        }
    }    

    return mempos;
}

int get_next_temp_reg() {
    int i;
    for (i = t0; i <= t7; i++) {
        if (reg_map[i].index == -1) {
            reg_map[i].index = 0;
            return i;
        }
    }
    assert(0);
    return 0;
}

int * get_and_update_reg(int index, int offset, int * needs_load) {
    *needs_load = 1;
    int reg = -1;
    // NOTE: reg_map maps register values to indexes in the sybol table.

    int lowest_priority = s0;
    int i = s0;
    // if the value already has a register return that
    if (strTable[index].reg != -1 && offset == reg_map[strTable[index].reg].offset){
        *needs_load = 0;
        reg = strTable[index].reg;
    } else {
        // otherwise get the next availiable register
        for (i = s0; i <= s7; i++) {
            if (reg_map[i].index == -1) { // if the register not not mapped to a vlue in the symbol table
                reg = i;
                break;
            }

            if (strTable[reg_map[i].index].calls < strTable[reg_map[lowest_priority].index].calls){
                lowest_priority = i;
            }
        }
    }
    
    strTable[index].calls--; // the more times is called in assmebling the fewer calls left and the lower the priority

    if (reg == -1) {
        reg = lowest_priority;
        // if all registers are full boot lowest priority
        strTable[reg_map[reg].index].reg = -1;
        fprintf(fileptr, "\t# Value '%s' booted from %s due to call to '%s'\n", strTable[reg_map[reg].index].id, reg_names[reg], strTable[index].id);
    }

    if (*needs_load) {
        reg_map[reg].index = index;
        reg_map[reg].offset = offset;
        strTable[index].reg = reg;
        fprintf(fileptr, "\t# Map %s to register %s\n", strTable[index].id, reg_names[reg]);
    }

    return &strTable[index].reg;
}

void emit(char * instr, int rd, int rs, int rt, int * imm ) {

}

int * load_val(int index, int offset) {
    int needs_load;
    int mempos = get_and_update_mempos(index) + offset;
    int * reg = get_and_update_reg(index, offset, &needs_load);
    char * name = malloc(20);
    strcpy(name, strTable[index].id);

    if (needs_load) {
        if (is_global(index)){
            fprintf(fileptr, "\tlw %s, %d($gp) # %s will be used in the future and must be loaded into a register\n", reg_names[*reg], mempos, name);
        } else {
            fprintf(fileptr, "\tlw %s, %d($fp) # %s will be used in the future and must be loaded into a register\n", reg_names[*reg], mempos, name);
        }
    } else {
        fprintf(fileptr, "\t#Value %s is already stored in register %s and doesnt need to be loaded\n", name, reg_names[*reg]);
    }

    return reg;
}

void store_val(int index, int offset) {
    int needs_load;
    int mempos = get_and_update_mempos(index) + offset;
    int reg = *get_and_update_reg(index, offset, &needs_load);
    char * name = malloc(20);
    strcpy(name, strTable[index].id);

    if (is_global(index)){
        fprintf(fileptr, "\tsw %s, %d($gp) # %s was updated and must be saved\n", reg_names[reg], mempos, name);
    } else {
        fprintf(fileptr, "\tsw %s, %d($fp) # %s was updated and must be saved\n", reg_names[reg], mempos, name);
    }
}

void emit_pre_instructions() {
    fprintf(fileptr,    "\t# Setting up FP\n"
                        "\tsw $fp, ($sp)\n"
                        "\tmove $fp, $sp\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\t# Saving registers\n"
                        "\tsw $s0, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s1, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s2, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s3, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s4, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s5, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s6, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s7, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tmove $fp, $sp\n"
                        "\t# Allocate space for local variables.\n");
}

void emit_post_instructions() {
    fprintf(fileptr, "\t# Deallocate space for %d, local variables\n", vars_declared);
    
    while (vars_declared > 0) {
        fprintf(fileptr, "\taddi $sp, $sp, 4\n");
        vars_declared--;
    }

    fprintf(fileptr,    "\t# Reloading registers\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s7, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s6, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s5, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s4, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s3, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s2, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s1, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s0, ($sp)\n"
                        "\t# Setting FP back to old value\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $fp, ($sp)\n"
                        "\t# Return to caller\n");
}