.data 

prompt: .asciiz "\nPlease Enter an  Integer: "


.text
main:
	addi $sp, $sp, -4 # maoving the stack pointer so that the local variables have space. 
	la $a0, prompt
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall 
	
	addi $t0, $v0, 0
	
	jal recursion
	
recursion: 
	addi $sp, $sp, -12 # pushes stack frame for local storage
	sw $ra, 0($sp)
	
	addi $t0, $zero, 1
	bne $t0, $zero, not_neg_one
	beq $t0, $zero, is_neg_one
	

is_neg_one:
	addi $v0, $zero, 3
	jal recursion
	
not_neg_one:
	slt $t1, $t0, -2
	beq $t1, $zero, lte_neg_two
	
	  



lte_neg_two:

lt_neg_two:

end_recur:
	lw $ra, 0($sp)
	addi $sp, $sp, 12 # pops the stack frame.
	jr $ra

END:
	
	