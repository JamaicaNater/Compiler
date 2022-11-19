.text
	move $fp, $sp
	JAL initmain
	li  $v0, 10
	syscall
initoutput:
	addi $sp, $sp, -36
	lw $a0, 0($sp)
	li $v0, 1
	syscall
	addi $sp, $sp, 36
	jr $ra
initoutputchar:
	addi $sp, $sp, -36
	lw $a0, 0($sp)
	li $v0, 11
	syscall
	addi $sp, $sp, 36
	jr $ra
initoutputhexaschar:
	addi $sp, $sp, -36
	lw $a0, 0($sp)
	li $v0, 11
	syscall
	addi $sp, $sp, 36
	jr $ra
initinputchar:
	addi $sp, $sp, -36
	li $v0, 12
	syscall
	addi $sp, $sp, 36
	jr $ra
initinputint:
	addi $sp, $sp, -36
	li $v0, 5
	syscall
	addi $sp, $sp, 36
	jr $ra
	# We dont allocate space for globals, i will be stored at 0 relative to the global pointer when it needs to be saved
	# We dont allocate space for globals, dog will be stored at -4 relative to the global pointer when it needs to be saved
	# We dont allocate space for globals, cat will be stored at -8 relative to the global pointer when it needs to be saved
initadd: 
	# Setting up FP
	sw $fp, ($sp)
	move $fp, $sp
	subi $sp, $sp, 4
	# Saving registers
	sw $s0, ($sp)
	subi $sp, $sp, 4
	sw $s1, ($sp)
	subi $sp, $sp, 4
	sw $s2, ($sp)
	subi $sp, $sp, 4
	sw $s3, ($sp)
	subi $sp, $sp, 4
	sw $s4, ($sp)
	subi $sp, $sp, 4
	sw $s5, ($sp)
	subi $sp, $sp, 4
	sw $s6, ($sp)
	subi $sp, $sp, 4
	sw $s7, ($sp)
	subi $sp, $sp, 4
	move $fp, $sp
	# Allocate space for local variables.
	ADDI $sp, $sp, -4 # Allocate space for x
	ADDI $sp, $sp, -4 # Allocate space for y
	ADDI $sp, $sp, -4 # Allocate space for result
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	# Map result to register $s0
	lw $s0, -8($fp) # result will be used in the future and must be loaded into a register
	#BEGIN EXPR STMT
	# Map x to register $s1
	lw $s1, 0($fp) # x will be used in the future and must be loaded into a register
	# Map y to register $s2
	lw $s2, -4($fp) # y will be used in the future and must be loaded into a register
	ADD $t0, $s1, $s2 
	move $s0, $t0
	sw $s0, -8($fp) # result was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
#Return
	LW $v0, -8($fp)
 # Save Return value	# Deallocate space for 3, local variables
	addi $sp, $sp, 4
	addi $sp, $sp, 4
	addi $sp, $sp, 4
	# Reloading registers
	addi $sp, $sp, 4
	lw $s7, ($sp)
	addi $sp, $sp, 4
	lw $s6, ($sp)
	addi $sp, $sp, 4
	lw $s5, ($sp)
	addi $sp, $sp, 4
	lw $s4, ($sp)
	addi $sp, $sp, 4
	lw $s3, ($sp)
	addi $sp, $sp, 4
	lw $s2, ($sp)
	addi $sp, $sp, 4
	lw $s1, ($sp)
	addi $sp, $sp, 4
	lw $s0, ($sp)
	# Setting FP back to old value
	addi $sp, $sp, 4
	lw $fp, ($sp)
	# Return to caller
	jr $ra
endadd: 
initsaydog: 
	# Setting up FP
	sw $fp, ($sp)
	move $fp, $sp
	subi $sp, $sp, 4
	# Saving registers
	sw $s0, ($sp)
	subi $sp, $sp, 4
	sw $s1, ($sp)
	subi $sp, $sp, 4
	sw $s2, ($sp)
	subi $sp, $sp, 4
	sw $s3, ($sp)
	subi $sp, $sp, 4
	sw $s4, ($sp)
	subi $sp, $sp, 4
	sw $s5, ($sp)
	subi $sp, $sp, 4
	sw $s6, ($sp)
	subi $sp, $sp, 4
	sw $s7, ($sp)
	subi $sp, $sp, 4
	move $fp, $sp
	# Allocate space for local variables.
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 68 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 111 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 103 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 61 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	# Map dog to register $s0
	lw $s0, -4($gp) # dog will be used in the future and must be loaded into a register
	sw $s0, -36($sp) # Store Argument
	jal initoutput
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#Return
	# Deallocate space for 0, local variables
	# Reloading registers
	addi $sp, $sp, 4
	lw $s7, ($sp)
	addi $sp, $sp, 4
	lw $s6, ($sp)
	addi $sp, $sp, 4
	lw $s5, ($sp)
	addi $sp, $sp, 4
	lw $s4, ($sp)
	addi $sp, $sp, 4
	lw $s3, ($sp)
	addi $sp, $sp, 4
	lw $s2, ($sp)
	addi $sp, $sp, 4
	lw $s1, ($sp)
	addi $sp, $sp, 4
	lw $s0, ($sp)
	# Setting FP back to old value
	addi $sp, $sp, 4
	lw $fp, ($sp)
	# Return to caller
	jr $ra
endsaydog: 
initmain: 
	# Setting up FP
	sw $fp, ($sp)
	move $fp, $sp
	subi $sp, $sp, 4
	# Saving registers
	sw $s0, ($sp)
	subi $sp, $sp, 4
	sw $s1, ($sp)
	subi $sp, $sp, 4
	sw $s2, ($sp)
	subi $sp, $sp, 4
	sw $s3, ($sp)
	subi $sp, $sp, 4
	sw $s4, ($sp)
	subi $sp, $sp, 4
	sw $s5, ($sp)
	subi $sp, $sp, 4
	sw $s6, ($sp)
	subi $sp, $sp, 4
	sw $s7, ($sp)
	subi $sp, $sp, 4
	move $fp, $sp
	# Allocate space for local variables.
	ADDI $sp, $sp, -4 # Allocate space for x
	ADDI $sp, $sp, -4 # Allocate space for t
	ADDI $sp, $sp, -4 # Allocate space for testglobal
	ADDI $sp, $sp, -4 # Allocate space for z
	ADDI $sp, $sp, -4 # Allocate space for c
	ADDI $sp, $sp, -4 # Allocate space for v
	ADDI $sp, $sp, -4 # Allocate space for newline
	ADDI $sp, $sp, -4 # Allocate space for over9k
	ADDI $sp, $sp, -4 # Allocate space for num1
	ADDI $sp, $sp, -4 # Allocate space for num2
	ADDI $sp, $sp, -4 # Allocate space for result
	ADDI $sp, $sp, -4 # Allocate space for num3
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	# Map newline to register $s0
	lw $s0, -24($fp) # newline will be used in the future and must be loaded into a register
	#BEGIN EXPR STMT
	LI, $t0, 10
	move $s0, $t0
	sw $s0, -24($fp) # newline was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 73 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 110 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 112 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 117 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 116 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 97 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 99 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 104 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 97 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 114 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 58 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	# Map c to register $s1
	lw $s1, -16($fp) # c will be used in the future and must be loaded into a register
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	jal initinputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	move $s1, $v0
	sw $s1, -16($fp) # c was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 99 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 104 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 97 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 114 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 58 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value c is already stored in register $s1 and doesnt need to be loaded
	sw $s1, -36($sp) # Store Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value newline is already stored in register $s0 and doesnt need to be loaded
	sw $s0, -36($sp) # Store Argument
	jal initoutputhexaschar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 72 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 101 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 108 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 108 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 111 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 87 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 111 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 114 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 108 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 100 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 33 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 33 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 33 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value newline is already stored in register $s0 and doesnt need to be loaded
	sw $s0, -36($sp) # Store Argument
	jal initoutputhexaschar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 73 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 110 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 112 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 117 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 116 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 97 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 105 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 110 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 116 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 49 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 58 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	# Map num1 to register $s2
	lw $s2, -32($fp) # num1 will be used in the future and must be loaded into a register
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	jal initinputint
	addi $sp, $sp, 4
	lw $ra, ($sp)
	move $s2, $v0
	sw $s2, -32($fp) # num1 was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 73 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 110 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 112 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 117 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 116 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 97 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 105 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 110 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 116 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 50 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 58 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	# Map num2 to register $s3
	lw $s3, -36($fp) # num2 will be used in the future and must be loaded into a register
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	jal initinputint
	addi $sp, $sp, 4
	lw $ra, ($sp)
	move $s3, $v0
	sw $s3, -36($fp) # num2 was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	# Map result to register $s4
	lw $s4, -40($fp) # result will be used in the future and must be loaded into a register
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value num1 is already stored in register $s2 and doesnt need to be loaded
	sw $s2, -36($sp) # Store Argument
	#Value num2 is already stored in register $s3 and doesnt need to be loaded
	sw $s3, -40($sp) # Store Argument
	jal initadd
	addi $sp, $sp, 4
	lw $ra, ($sp)
	move $s4, $v0
	sw $s4, -40($fp) # result was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value num1 is already stored in register $s2 and doesnt need to be loaded
	sw $s2, -36($sp) # Store Argument
	jal initoutput
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 43 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value num2 is already stored in register $s3 and doesnt need to be loaded
	sw $s3, -36($sp) # Store Argument
	jal initoutput
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 61 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value result is already stored in register $s4 and doesnt need to be loaded
	sw $s4, -36($sp) # Store Argument
	jal initoutput
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value newline is already stored in register $s0 and doesnt need to be loaded
	sw $s0, -36($sp) # Store Argument
	jal initoutputhexaschar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	# Map t to register $s5
	lw $s5, -4($fp) # t will be used in the future and must be loaded into a register
	#BEGIN EXPR STMT
	LI, $t0, 5
	LI, $t1, 76
	LI, $t2, 5
	MULT $t1, $t2 
	MFLO $t3
	ADD $t1, $t0, $t3 
	LI, $t0, 6
	ADD $t2, $t1, $t0 
	LI, $t0, 3
	SUB $t1, $t2, $t0 
	move $s5, $t1
	sw $s5, -4($fp) # t was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	#Value t is already stored in register $s5 and doesnt need to be loaded
	#BEGIN EXPR STMT
	LI, $t0, 6
	move $s5, $t0
	sw $s5, -4($fp) # t was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	# Map i to register $s6
	lw $s6, 0($gp) # i will be used in the future and must be loaded into a register
	#BEGIN EXPR STMT
	LI, $t0, 3
	move $s6, $t0
	sw $s6, 0($gp) # i was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	# Map dog to register $s7
	lw $s7, -4($gp) # dog will be used in the future and must be loaded into a register
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value i is already stored in register $s6 and doesnt need to be loaded
	sw $s6, -36($sp) # Store Argument
	li $t2, 1 # Load Immideiate Argument
	sw $t2, -40($sp) # Store Immidiate Argument
	jal initadd
	addi $sp, $sp, 4
	lw $ra, ($sp)
	LI, $t0, 1
	ADD $t1, $v0, $t0 
	move $s7, $t1
	sw $s7, -4($gp) # dog was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 103 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 108 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 111 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 98 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 97 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 108 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 100 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 111 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 103 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 105 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 115 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value dog is already stored in register $s7 and doesnt need to be loaded
	sw $s7, -36($sp) # Store Argument
	jal initoutput
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 102 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 117 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 110 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 99 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 99 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 97 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 108 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 108 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	jal initsaydog
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value newline is already stored in register $s0 and doesnt need to be loaded
	sw $s0, -36($sp) # Store Argument
	jal initoutputhexaschar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 73 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 110 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 112 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 117 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 116 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 97 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 105 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 110 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 116 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 51 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 40 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 112 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 111 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 119 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 101 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 114 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 108 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 101 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 118 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 101 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 108 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 41 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 58 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	# Value 't' booted from $s5 due to call to 'num3'
	# Map num3 to register $s5
	lw $s5, -44($fp) # num3 will be used in the future and must be loaded into a register
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	jal initinputint
	addi $sp, $sp, 4
	lw $ra, ($sp)
	move $s5, $v0
	sw $s5, -44($fp) # num3 was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT

beginif1:
	#Value num3 is already stored in register $s5 and doesnt need to be loaded
	LI, $t0, 9000
	SGT $t1, $s5, $t0 
	BNE $t1, 1, beginelse1
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	# Map over9k to register $s5
	lw $s5, -28($fp) # over9k will be used in the future and must be loaded into a register
	#BEGIN EXPR STMT
	LI, $t0, 1
	move $s5, $t0
	sw $s5, -28($fp) # over9k was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 73 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 116 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 115 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 111 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 118 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 101 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 114 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 57 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 48 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 48 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 48 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 33 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 33 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 33 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 33 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
	J endif1

beginelse1:
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	#Value over9k is already stored in register $s5 and doesnt need to be loaded
	#BEGIN EXPR STMT
	LI, $t0, 0
	move $s5, $t0
	sw $s5, -28($fp) # over9k was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 73 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 116 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 115 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 117 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 110 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 100 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 101 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 114 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 57 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 48 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 48 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 48 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 44 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 119 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 101 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 97 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 107 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 33 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 73 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 116 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 115 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 116 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 105 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 109 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 101 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 102 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 111 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 114 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 97 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 98 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 111 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 111 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 115 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 116 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
	J endif1
endif1:

#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value newline is already stored in register $s0 and doesnt need to be loaded
	sw $s0, -36($sp) # Store Argument
	jal initoutputhexaschar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value num3 is already stored in register $s5 and doesnt need to be loaded
	sw $s5, -36($sp) # Store Argument
	jal initoutput
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT

beginwhile1:
	#Value num3 is already stored in register $s5 and doesnt need to be loaded
	LI, $t0, 9000
	SLT $t1, $s5, $t0 
	BNE $t1, 1, endwhile1
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value num3 is already stored in register $s5 and doesnt need to be loaded
	sw $s5, -36($sp) # Store Argument
	jal initoutput
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	#Value num3 is already stored in register $s5 and doesnt need to be loaded
	#BEGIN EXPR STMT
	#Value num3 is already stored in register $s5 and doesnt need to be loaded
	LI, $t0, 100
	ADD $t1, $s5, $t0 
	move $s5, $t1
	sw $at, 1($fp) #  was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
	J beginwhile1
endwhile1:

#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value newline is already stored in register $s0 and doesnt need to be loaded
	sw $s0, -36($sp) # Store Argument
	jal initoutputhexaschar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 70 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 105 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 110 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 97 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 108 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 112 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 111 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 119 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 101 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 114 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 108 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 101 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 118 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 101 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 108 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 105 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 115 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 58 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value num3 is already stored in register $s5 and doesnt need to be loaded
	sw $s5, -36($sp) # Store Argument
	jal initoutput
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value newline is already stored in register $s0 and doesnt need to be loaded
	sw $s0, -36($sp) # Store Argument
	jal initoutputhexaschar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#BEGIN ACTUAL ASSIGN STMT
	# Map z to register $s5
	lw $s5, -12($fp) # z will be used in the future and must be loaded into a register
	#BEGIN EXPR STMT
	LI, $t0, 76
	LI, $t1, 7
	SGT $t2, $t0, $t1 
	move $s5, $t2
	sw $s5, -12($fp) # z was updated and must be saved
	#END EXPR STMT
#END ASSIGN STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 55 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 54 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 62 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 55 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 63 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 65 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 110 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 115 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 61 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	li $t2, 32 # Load Immideiate Argument
	sw $t2, -36($sp) # Store Immidiate Argument
	jal initoutputchar
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#BEGIN ASSIGN STMT
#END ASSIGN STMT
	#BEGIN EXPR STMT
	sw $ra, ($sp)
	subi $sp, $sp, 4
	#Value z is already stored in register $s5 and doesnt need to be loaded
	sw $s5, -36($sp) # Store Argument
	jal initoutput
	addi $sp, $sp, 4
	lw $ra, ($sp)
	#END EXPR STMT
#Return
	LW $v0, 0($fp)
 # Save Return value	# Deallocate space for 12, local variables
	addi $sp, $sp, 4
	addi $sp, $sp, 4
	addi $sp, $sp, 4
	addi $sp, $sp, 4
	addi $sp, $sp, 4
	addi $sp, $sp, 4
	addi $sp, $sp, 4
	addi $sp, $sp, 4
	addi $sp, $sp, 4
	addi $sp, $sp, 4
	addi $sp, $sp, 4
	addi $sp, $sp, 4
	# Reloading registers
	addi $sp, $sp, 4
	lw $s7, ($sp)
	addi $sp, $sp, 4
	lw $s6, ($sp)
	addi $sp, $sp, 4
	lw $s5, ($sp)
	addi $sp, $sp, 4
	lw $s4, ($sp)
	addi $sp, $sp, 4
	lw $s3, ($sp)
	addi $sp, $sp, 4
	lw $s2, ($sp)
	addi $sp, $sp, 4
	lw $s1, ($sp)
	addi $sp, $sp, 4
	lw $s0, ($sp)
	# Setting FP back to old value
	addi $sp, $sp, 4
	lw $fp, ($sp)
	# Return to caller
	jr $ra
endmain: 
