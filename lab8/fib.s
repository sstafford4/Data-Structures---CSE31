        .data
#n:      .word 13
prompt: .asciiz "Please enter a number!\n"

        .text
main: 	
# calls the first prompt
	li $v0, 4 
	la $a0, prompt 
	syscall
	
	#grabs the first user inputted value
	li $v0, 5
	syscall
	
	# puts that user inputted value into $s0 to make comparison more consistent
	addi $t3, $v0, 0

	add     $t0, $0, $zero
	addi    $t1, $zero, 1
	#la      $t3, n
	#lw      $t3, 0($t3)
		
fib: 	beq     $t3, $0, finish
	add     $t2,$t1,$t0
	move    $t0, $t1
	move    $t1, $t2
	subi    $t3, $t3, 1
	j       fib
		
finish: addi    $a0, $t0, 0
	li      $v0, 1		
	syscall			
	li      $v0, 10		
	syscall			

