.data 

# initialize 3 variables and set them to equal 1,2,3 respectively
x: .word 1
y: .word 2
z: .word 3

# now we need printing prompts to print p + q, as well as the overall value 
pqprompt: .asciiz "\np + q: "
finalprompt: .asciiz "final answer: "

.text 

MAIN:
	# i need to place the values of xyz into their own regsters so that i can use them in register operations
	la $t0, x # im gonna do this by loading them into t0, then taking that value and putting them into s0, s1, s2
	lw $s0, 0($t0) # zero offset
	la $t0, y
	lw $s1, 0($t0)
	la $t0, z
	lw $s2, 0($t0)
	
	# this is necessary for when i end up saving the values!
	add $a0, $zero, $s0
	add $a1, $zero, $s1
	add $a2, $zero, $s2
	
	# holding (y + z) for final answer
	add $s2, $s1, $s2
	# holding x + (y + z) for final answer
	add $s2, $s2, $s0
	
	# immediate jump and link to FOO from here. Not bar because I need to get the registers for BAR from FOO
	jal FOO
	
	# p + q
	add $t6, $s1, $s0
	addi $v0, $t6, 0
	
	la $a0, pqprompt
	li $v0, 4
	syscall
	
	add $a0, $v0, $s2
	li $v0, 1		 
	syscall
	# so now I need the z = x + y + z + foo(x,y,z) math
	
	j END # inevitable jump to END
	
# down here, im going to need 3 labels, one for each function in the original C code, as well as the end label for when the program is over.
FOO:
	# i need to save the locations of the jump, as well as the values of the registers. 
	addi $sp, $sp, -4 # this is saving the location
	# this is going to save the values
	sw $ra, 0($sp) # THERE IS APPARENTLY AN ERROR HERE. it assembles tho lol. stores $ra in the stack
	add $t0, $zero, $a0 # backing up x because it has multiple usages 
	add $a2, $a2, $t0  # xANDz == a
	add $a1, $a1, $a2 #yANDz == b
	add $a0, $t0, $a1 #xANDy == c
	
	jal BAR
	
	sub $s0, $s0, $s0
	add $s0, $zero, $t0 # stores p into $s0
	mul $s0, $s0, $a0 # this is supposed to multiply the bit shift for p. 
	
	la $t0, x # set up input arguments for q 
	lw $a0, 0($t0)
	la $t0, y
	lw $a1, 0($t0)
	la $t0, z
	lw $a2, 0($t0)
	# back up m and n
	add $t1, $zero, $a0
	add $t2, $zero, $a1
	
	sub $a0, $a0, $a2 # m - o
	sub $a1, $a1, $a0 # n - m
	add $a2, $a1, $a1 # n + n
	
	jal BAR
	
	sub $s1, $s1, $s1
	add $s1, $zero, $t0 # stores the q value
	mul $s1, $s1, $a0   # multiple q's bit shift
		
	add $v0, $s0, $s1 # output of FOO
		
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	#sw $a0, 4($sp)
	#sw $a1, 8($sp)
	#sw $a2, 12($sp)
	# foo is going to rely on bar, but i need to set up certain registers in order for it to work.
	# to get P:
	# first off i need a = x + z. there are 7 s registers, 8 t registers
	#add $a0, $a0, $a2
	# now i need b = y + z
	#add $a1, $a1, $a2
	# now i need c = x + y
	#add $a2, $a0, $a1
	
	#jal bar # jumps and links to BAR
	
	
	
	# now i need to make it so that p register, which i'll make like $t2 or something, is equal to the value i just got from BAR
	#add $t2, $zero, $t1
	
	# gonna try repeating this statement.
	# i havent tested the program yet at all but this should derail a potential issue im seeing. 
	#sw $ra, 0($sp)
	#sw $a0, 4($sp)
	#sw $a1, 8($sp)
	#sw $a2, 12($sp)
	
	# now for q i need to do some subtraction
	# a = x - z
	#sub $a0, $a0, $a2
	# b = y - x
	#sub $a1, $a1, $a0
	# c = y + y
	# if there is a problem in calculations its def coming from this line.  
	#add $a2, $a1, $a1 # no clue if this is going to work tbh.
	
	
	#jal bar # second jump to bar to get q
	#add $t3, $zero, $t1 # theoretically going to give me q
	
	#j main
	
BAR:
	# so what bar does is that it takes in 3 integers, abc, subtracts a from b (b - a), then shifts the value c units to the left in binary, which changes the value. 
	# for this function, a = x, b = y, c = z
	
	sub $a0, $a1, $a0 # b = b - a
	addi $fp, $fp, -4 # saves the return address for when you come back to FOO
	sw $ra, 0($fp)
	
	#sllv $t1, $a1, $a2 # $t1 == the value when $a1 is shifted left by $a2 units
	lw $ra, 0($fp)# returns to FOO
	addi $fp, $fp, 4
	# jump register to $ras
	jr $ra # jump to statement whose address is in $ra	

END:
