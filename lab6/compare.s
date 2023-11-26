.data 
n:	.word 25 # this is setting the value of n! Nothing more than the value of the variable, C equivalent: int n = 25.

userinput:	.asciiz "Enter a number: "
str1:	.asciiz "Less Than\n"
str2:	.asciiz "Less than or equal to\n"
str3:	.asciiz "Greater than\n"
str4:	.asciiz "Greater than or equal to\n"

.text

main:
	# first, prompt the user to enter a number
	li $v0, 4 # 4 is the service number for printing strings. 
	la $a0, userinput #loads the user response into $a0
	syscall
	
	# Get the user's input
	li $v0, 5 # 5 is the service number to tell the program to get an integer from the keyboard. 
	syscall
	
	# store the result in $t0, temporarily
	move $t0, $v0 # used move to store the value from $v0 into $t0
	
	la $t1, n # loads n onto $t1
	lw $t1, 0($t1) # necessary instruction after loading n into the register. 
	
	# Logic: ($t0 < $t1) != 0, then branch
	#slt $t2, $t0, $t1 #checks if n is greater than $t0
	#bne $t2, $zero, LessThan # Branch to LessThan if not equal
	
	# Logic: ($t0 > $t1) == 0, then branch
	#slt $t3, $t1, $t0 # checks if $t1 is less than $t0
	#beq $t3, $zero, GreaterThanEqualTo # Branch to the GreaterThanEqualTo if equal
	
	# Logic: ($t1 < $t0) == 0, then branch
	slt $t2, $t1, $t0
	beq $t2, $zero, GreaterThan
	
	# Logic: ($t0 < $t1) == 0, then branch
	slt $t3, $t0, $t1
	beq $t3, $zero, LessThanEqualTo
	
#LessThan: # This will print out str1 if branched
	#li $v0, 4
	#la $a0, str1
	#syscall
	
#GreaterThanEqualTo: # This will print out str4 if branched
	#li $v0, 4
	#la $a0, str4
	#syscall
GreaterThan:
	li $v0, 4
	la $a0, str2
	syscall

LessThanEqualTo:
	li $v0, 4
	la $a0, str3
	syscall
	
	
	
	
	
	
	
