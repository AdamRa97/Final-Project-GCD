.data
ask: .asciiz "Enter an integer: "
ask2: .asciiz "Enter another integer: "
leftPar: .asciiz "("
rightPar: .asciiz ") "
comma: .asciiz ", "
firstSent: .asciiz "The GCD of "
secondSent: .asciiz "is "

.text
main:

	#asking to input the first int
	li $v0, 4
	la $a0, ask
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	#making sure to store orig int
	move $t4, $t1
	
	#asking to input the second int
	li $v0, 4
	la $a0, ask2
	syscall

	li $v0, 5
	syscall
	move $t2, $v0
	
	#making sure to store orig int
	move $t5, $t2
	
	#Making sure the Greatest number is set in the first spot and the lower number in the second spot ( first, second ) and then gets the GCD
	jal sortInt
	
	#Displaying everything so it'll show as 'The GCD of (integer, integer) is GCD'
	li $v0, 4
	la $a0, firstSent
	syscall
	
	li $v0, 4
	la $a0, leftPar
	syscall
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	move $a0, $t5
	syscall
	
	li $v0, 4
	la $a0, rightPar
	syscall
	
	li $v0, 4
	la $a0, secondSent
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	
	#ends program
	li $v0, 10
	syscall
	


#method to sort the ints, will check if $t1 is >= $t2, if it isn't then it moves values around so that it will become true	
sortInt:
	bge $t1, $t2, eucAlg
	move $t3, $t1
	move $t1, $t2
	move $t2, $t3

#method that integrates the euclidean algorithm to find the GCD
eucAlg:
	while:
		#checks if the second spot is equal to 0 since the remainder will always go into the second spot
		beq $t2, $zero, exit
		
		#Diving Greater number by lower number
		div $t1, $t2

		#to access the remainder
		mfhi $s0 
		
		#making the bigger number in the first spot and remainder into the second spot
		move $t3, $t2
		move $t1, $t2
		move $t2, $s0

		#loops back
		j while

	exit:
		jr $ra

