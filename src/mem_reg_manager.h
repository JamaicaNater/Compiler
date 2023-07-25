#ifndef MEM_REG_MANAGER_H
#define MEM_REG_MANAGER_H


int * load_val(int index, int offset);

void store_val(int index, int offset);

int get_next_temp_reg();

int * get_and_update_reg(int index, int offset, int * needs_load);

int get_and_update_mempos(int index);

void emit_pre_instructions();

void emit_post_instructions();

#endif