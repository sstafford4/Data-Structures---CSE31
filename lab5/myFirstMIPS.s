.data

.text
main:
	
	move $t0, $s0 # sets t0 to the manually inputted s0 value ex. value = 20
	subi $t1, $t0, 7 # 20 - 7 = 13
	add $t2, $t1, $t0 # 20 + 13 = 33
	addi $t3, $t2, 2 # 33 + 2 = 35
	add $t4, $t3, $t2# 33 + 35 = 68
	subi $t5, $t4, 28# 68 - 28 = 40
	sub $t6, $t4, $t5 # 68 - 40 = 28
	addi $t7, $t6, 12 # 28 + 12 = 40
	
	addi $a0, $t7, 0 # this sets the printing value to equal $t7, the final value
	
	li $v0, 1 # 1 service number tells the program to print out the value of a0.
	syscall	# it only prints if syscall follows it 
	
	li $v0, 10 # 10 service number makes the program stop!
	syscall # it only stops if syscall follows it. 