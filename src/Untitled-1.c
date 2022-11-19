int asm_expr(tree * node, const int * const dest_reg_no, int * operation) {
    char * registerno = malloc(20);
    int is_immediate = 0;
    int ret = 0;
    if (dest_reg_no) strcpy(registerno, reg_names[*dest_reg_no]);

    // if (node == NULL)
    //     return;

    // if we need to operate on a funtion value just load the retunr value into memory
    if (node->node_kind == FUNCCALLEXPR) {
        assemble(node, dest_reg_no);

        if (dest_reg_no) fprintf(fileptr, "\tMOVE %s, $v0 \n", registerno);
        return;
    }

    if (node->node_kind == ARRAYSIZE) {
        return;
    }

    if (node->num_children > 0)
        asm_expr(node->children[0], dest_reg_no, operation);

    if (node->node_kind == INT || node->node_kind == IDENTIFIER || node->node_kind == CHAR) {
        char operand[15];
        char imm[2] = "";

        if (node->node_kind == IDENTIFIER) {
            assert(node->parent->node_kind == VAR);
            tree * var_ptr = node->parent;
            int rt = *load_val(node->val, get_offset(var_ptr));
            strcpy(operand, reg_names[rt]);
        } else {
            is_immediate = 1;
            imm[0] = 'I';
            snprintf(operand, 14, "%d", node->val);
        }
        if (!(*operation)){
            if (node->node_kind == IDENTIFIER) {
                fprintf(fileptr, "\tMOVE %s, %s # Load operand into destination reg\n", registerno, operand);
            } else {
                fprintf(fileptr, "\tLI %s, %s # Load operand into destination reg\n", registerno, operand);
            } 
            
        } else {
            switch (*operation) {
                case ADD:
                    fprintf(fileptr, "\tADD %s, %s, %s \n", imm, registerno, registerno, operand);
                    break;
                case SUB:
                    fprintf(fileptr, "\tSUB %s, %s, %s \n", imm, registerno, registerno, operand);
                    break;
                case MUL:
                    fprintf(fileptr, "\tMULT %s, $t9 \n", registerno, operand);
                    fprintf(fileptr, "\tMFLO %s\n", registerno);
                    break;
                case DIV:
                    fprintf(fileptr, "\tDIV %s, $t9\n",registerno, operand);
                    fprintf(fileptr, "\tMFHI %s\n", registerno);
                    break;
                case LTE:
                    fprintf(fileptr, "\tSLTE %s, %s, %s \n", registerno, registerno, operand);
                    break;
                case LT:
                    fprintf(fileptr, "\tSLT %s, %s, %s \n", registerno, registerno, operand);
                    break;
                case GTE:
                    fprintf(fileptr, "\tGLTE %s, %s, %s \n", registerno, registerno, operand);
                    break;
                case GT:
                    fprintf(fileptr, "\tSGT %s, %s, %s \n", registerno, registerno, operand);
                    break;
                case EQ:
                    fprintf(fileptr, "\tSEQ%s %s, %s, %s \n", imm, registerno, registerno, operand);
                    break;
                case NEQ:
                    fprintf(fileptr, "\tSNQT %s, %s, %s \n", registerno, registerno, operand);
                    break;
            }
            *operation = 0;
        }
    }
    if (node->num_children > 1)
        asm_expr(node->children[1], dest_reg_no, operation);

    if (node->node_kind == MULOP || node->node_kind == ADDOP || node->node_kind == RELOP) {
        *operation = node->val;
    }
    if (node->num_children > 2)
        asm_expr(node->children[2], dest_reg_no, operation);
}

int asm_expr2(tree * node) {
    int return_reg = 0;

    int left_reg, int right_reg;

    switch(node->node_kind) {
        case FUNCCALLEXPR:
            assemble(node, dest_reg_no);
            return v0;
            break;
        case MULOP:
        case ADDOP:
        case RELOP:
            left_reg = factorize(node->children[0]);
            right_reg = factorize(node->children[1]);
            return_reg = get_next_temp();
            switch (node->val) {
                case ADD:
                    fprintf(fileptr, "\tADD %s, %s, %s \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
                case SUB:
                    fprintf(fileptr, "\tSUB %s, %s, %s \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
                case MUL:
                    fprintf(fileptr, "\tMULT %s, %s \n", reg_names[left_reg], reg_names[right_reg]);
                    fprintf(fileptr, "\tMFLO %s\n", reg_names[return_reg]);
                    break;
                case DIV:
                    fprintf(fileptr, "\tDIV %s, %s\n", reg_names[left_reg], reg_names[right_reg]);
                    fprintf(fileptr, "\tMFHI %s\n", reg_names[return_reg]);
                    break;
                case LTE:
                    fprintf(fileptr, "\tSLTE %s, %s, %s \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
                case LT:
                    fprintf(fileptr, "\tSLT %s, %s, %s \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
                case GTE:
                    fprintf(fileptr, "\tGLTE %s, %s, %s \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
                case GT:
                    fprintf(fileptr, "\tSGT %s, %s, %s \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
                case EQ:
                    fprintf(fileptr, "\tSEQ %s, %s, %s \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
                case NEQ:
                    fprintf(fileptr, "\tSNQT %s, %s, %s \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
            }
            //Retire registers
            reg_map[left_reg] = {-1, 0};
            reg_map[right_reg] = {-1, 0};
            break;
        case IDENTIFIER:
            return load_val(node->val, get_offset(node->parent));
            break
        case INT:
        case CHAR:
            return_reg = get_next_temp();
            fprintf(fileptr, "\tLI, %s, %d\n", reg, node->val);
            return return_reg;
            break;
        default:
            for (int i = 0; i < node->num_children; i++){
                //assert(node->num_children == 1 || node->num_children == 0);
                if (node->children[i]->node_kind != ARRAYSIZE) return_reg = asm_expr(node->children[i]);
                if (return_reg != 0) break;
            }
            break;
    }
    return return_reg;
}