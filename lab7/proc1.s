        .data
m: 		.word 10
n: 		.word 5

		.text
MAIN:	la $t0, m			# Load address of m
		lw $a0, 0($t0)		# a0 = m
		la $t0, n			# Load address of n
		lw $a1, 0($t0)		# a1 = n
		
		# because we used jal, we no longer need to tediously set $ra to the correct address. 
		# addi $ra,$zero, 0x00400020	# Replace 0 with a correct return address 
		# The correct return address in this case was 0x00400020, which is the address of the line that previously set $ra to 0. 
		jal SUM #swiched j to jal because jal saves the return to $ra before jumping. 
		
		# jal is the instruction for jump-and-link
		
		addi $a0, $v0, 0	# Print out result
		li $v0, 1		 
		syscall	
		
		j END

SUM:	add $v0, $a0, $a1
		jr $ra

		
END:
