.data 

orig: .space 100	# In terms of bytes (25 elements * 4 bytes each)
sorted: .space 100

str0: .asciiz "Enter the number of assignments (between 1 and 25): "
str1: .asciiz "Enter score: "
str2: .asciiz "Original scores: "
str3: .asciiz "Sorted scores (in descending order): "
str4: .asciiz "Enter the number of (lowest) scores to drop: "
str5: .asciiz "Average (rounded up) with dropped scores removed: "


.text 

# This is the main program.
# It first asks user to enter the number of assignments.
# It then asks user to input the scores, one at a time.
# It then calls selSort to perform selection sort.
# It then calls printArray twice to print out contents of the original and sorted scores.
# It then asks user to enter the number of (lowest) scores to drop.
# It then calls calcSum on the sorted array with the adjusted length (to account for dropped scores).
# It then prints out average score with the specified number of (lowest) scores dropped from the calculation.
main: 
	addi $sp, $sp -4
	sw $ra, 0($sp)
	li $v0, 4 
	la $a0, str0 
	syscall 
	li $v0, 5	# Read the number of scores from user
	syscall
	move $s0, $v0	# $s0 = numScores
	move $t0, $0
	la $s1, orig	# $s1 = orig
	la $s2, sorted	# $s2 = sorted
loop_in:
	li $v0, 4 
	la $a0, str1 
	syscall 
	sll $t1, $t0, 2
	add $t1, $t1, $s1
	li $v0, 5		# Read elements from user
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	bne $t0, $s0, loop_in
	
	
	move $a0, $s0
	jal selSort	# Call selSort to perform selection sort in original array
	
	li $v0, 4 
	la $a0, str2 
	syscall
	move $a0, $s1	# More efficient than la $a0, orig
	move $a1, $s0
	jal printArray	# Print original scores
	li $v0, 4 
	la $a0, str3 
	syscall 
	move $a0, $s2	# More efficient than la $a0, sorted
	jal printArray	# Print sorted scores
	
	li $v0, 4 
	la $a0, str4 
	syscall 
	li $v0, 5	# Read the number of (lowest) scores to drop
	syscall
	move $a1, $v0
	sub $a1, $s0, $a1	# numScores - drop
	move $a0, $s2
	jal calcSum	# Call calcSum to RECURSIVELY compute the sum of scores that are not dropped
	
	# Your code here to compute average and print it
	
	move $s4, $v0
	
	div $s4, $s4, $s5
	
	li $v0, 4 
	la $a0, str5
	syscall 
	
	li 	$v0, 1
	move $a0, $s4
	syscall
	
	lw $ra, 0($sp)
	addi $sp, $sp 4
	li $v0, 10 
	syscall
	
	
# printList takes in an array and its size as arguments. 
# It prints all the elements in one line with a newline at the end.
printArray:
	# Your implementation of printList here	
	move $t5, $a0
	move $t6, $0
	move $t7, $0
loopin:
	
	lw 	$t6, 0($t5)			#load
	li 	$v0, 1
	addi 	$a0, $t6, 0
	syscall
	li 	$a0, 32
	li 	$v0, 11  			# syscall number for printing character
	syscall

	addi 	$t5, $t5, 4
	addi 	$t7, $t7, 1
	bne 	$t7, $a1, loopin
	
	li $a0, 10
	li $v0, 11
	syscall	

	jr 	$ra
	
	
# selSort takes in the number of scores as argument. 
# It performs SELECTION sort in descending order and populates the sorted array
selSort:
	# Your implementation of selSort here
		
		sll	$s3, $a0, 2		# $s3=n*4
		sub	$sp, $sp, $s3		# creates enough memory on stack to store the array

		move	$s5, $zero		# set i equal to 0
		move	$a1, $s1
		
for_get:	
		bge	$s5, $a0, exit_get	# if i>=n go to exit_for_get
		sll	$t2, $s5, 2		# $t2=i*4
		add	$t1, $t2, $sp		# $t1=$sp+i*4
		
		
		lw 	$t6, 0($a1)
		sw	$t6, 0($t1)		# The element is stored
						# at the address $t1
		addi 	$a1, $a1, 4
		addi	$s5, $s5, 1		# i=i+1
		j	for_get
		
exit_get:	
		move	$a1, $a0		# $a1=size of the array
		move	$a0, $sp		# $a0=base address of the array
		
		subi	$sp, $sp, 4
		sw 	$ra, 0($sp) 
		
		jal	sort			# isort(a,n) #MAKE SURE TO CHANGE ALL S2 TO S0
		
		
		
		lw	$ra, 0($sp)		#reload register to return to main function
		addi	$sp, $sp, 4
		
		move $s2, $sp
		

		
		jr 	$ra

# selection_sort
sort:		addi	$sp, $sp, -20		# save values on stack
		sw	$ra, 0($sp)
		sw	$s0, 4($sp)
		sw	$s3, 8($sp)
		sw	$s4, 12($sp)
		sw	$s5, 16($sp)
		
		add 	$s3, $s0, $0 #store size of array in s3
		sll 	$s3, $s3, 2

		move 	$s3, $a0		# base address of the array
		move	$s5, $zero		# i=0

		subi	$s0, $a1, 1		# lenght -1
sort_forloop:	beq 	$s5, $s0, sort_exit	# if i = length-1 -> exit loop
		
		move	$a1, $s5		# i
		move	$a2, $s0		# length - 1
		
		jal	max
		
		move	$a2, $v0		# get value of mini
		
		jal	swap

		addi	$s5, $s5, 1		# i += 1
		j	sort_forloop		# go back to the beginning of the loop
		
sort_exit:	lw	$ra, 0($sp)		# restore values from stack
		lw	$s0, 4($sp)
		lw	$s3, 8($sp)
		lw	$s4, 12($sp)
		lw	$s5, 16($sp)
		addi	$sp, $sp, 20		# restore stack pointer
		jr	$ra			# return


# maximum routine
max:		move	$t0, $a0		# base of the array
		move	$t1, $a1		# max = first = i
		move	$t2, $a2		# last
		
		sll	$t3, $t1, 2		# first * 4
		add	$t3, $t3, $t0		# index = base array + first * 4		
		lw	$t4, 0($t3)		# max = v[first]
		
		addi	$t5, $t1, 1		# i = 0
max_forloop:	bgt	$t5, $t2, max_end	# go to max_end

		sll	$t6, $t5, 2		# i * 4
		add	$t6, $t6, $t0		# index = base array + i * 4		
		lw	$t7, 0($t6)		# v[index]

		ble	$t7, $t4, max_if_exit	# skip the if when v[i] <= max
		
		move	$t1, $t5		# max = i
		move	$t4, $t7		# max = v[i]

max_if_exit:	addi	$t5, $t5, 1		# i += 1
		j	max_forloop

max_end:	move 	$v0, $t1		# return max
		jr	$ra


# swap function
swap:		sll	$t1, $a1, 2		# i * 4
		add	$t1, $a0, $t1		# v + i * 4
		
		sll	$t2, $a2, 2		# j * 4
		add	$t2, $a0, $t2		# v + j * 4

		lw	$t0, 0($t1)		# v[i]
		lw	$t3, 0($t2)		# v[j]

		sw	$t3, 0($t1)		# v[i] = v[j]
		sw	$t0, 0($t2)		# v[j] = $t0

		jr	$ra
	
	
# calcSum takes in an array and its size as arguments.
# It RECURSIVELY computes and returns the sum of elements in the array.
# Note: you MUST NOT use iterative approach in this function.
calcSum:move $s5, $a1 #gets new length
	move $v0, $0
	move $t1, $0
	
	recur: subi $sp, $sp, 4
	       sw $ra 0($sp) 
	
	if: bgtz $a1, else
	    j end_recur
	
	else: subi $a1, $a1, 1 #the next n-1 to send
	      sll $t0, $a1, 2 #multiple by 4 times a1. bits
	      add $t0, $t0, $a0 #the address of the value we are looking at
	      
	      lw $t2, 0($t0)#t2 = arr[n-1]
	      
	      add $v0, $v0, $t2 #add the value we are looking at to the calcsum
	      j recur
	      
	end_recur: lw $ra 0($sp)
		   addi $sp, $sp, 4
	      
		jr $ra
