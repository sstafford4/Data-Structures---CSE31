# Program takes in numbers until the user enters 0, then produces an even sum and an odd sum

.data
prompt: .asciiz "Please enter a number: "
evenTotal: .asciiz "\nThe sum of all even numbers is: "
oddTotal: .asciiz "\nThe sum of all odd numbers is: "
finalPrompt: .asciiz " The sum of all inputted numbers is: "

# tbh the hardest part was register management. Remembering which registers go where and hold what. 
.text
main:
	li $v0, 1 #starts the program
	
	# calls the first prompt
	li $v0, 4 
	la $a0, prompt 
	syscall
	
	#grabs the first user inputted value
	li $v0, 5
	syscall
	
	# puts that user inputted value into $s0 to make comparison more consistent
	addi $s0, $v0, 0
	
	# Does the same thing as the While label, but doesnt loop. I did this so that the first value would be counted in the rest of the program
	# Sends the value through Even or Odd, and those labels send it back through to While
	rem $t5, $s0, 2
	beq $t5, $zero, Even
	bne $t5, $zero, Odd
	
	
While:
	# if ($v0 == 0) branch to Exit
	beq $v0, $zero, Exit
	
	# Same first prompt, but loops
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	
	addi $s0, $v0, 0 #takes the user input and adds 0 to it
	rem $t1, $s0, 2 # takes the remainder of $s0 / 2 and puts the result into $t1
	beq $t1, $zero, Even
	bne $t1, $zero, Odd
	
	
Even:
	# $t2 is the even total
	add $t2, $t2, $s0 # adds the even value to the overall even sum
	j While	#jumps back to the loop
	

Odd:
	# $t3 is the odd total
	add $t3, $t3, $s0
	j While #jumps back to the loop
	
Exit:
	li $v0, 4
	la $a0, evenTotal
	syscall
	
	li $v0, 1
	la $a0, ($t2)
	syscall
	
	li $v0, 4
	la $a0, oddTotal
	syscall
	
	li $v0, 1
	la $a0, ($t3)
	syscall
	
	li $v0, 10
	syscall
	
