#author: Troy Hatchard
#Date: 17/03/2019
#program to allow a user to input two integers to get
#the result of adding, subtracting, multiplying, and 
#dividing the two integers


.text
main:

#vv input the first elements vv
#prompt for first integer input
la $a0, prompt_first_integer 
li $v0, 4
syscall

#take input for the first integer
li $v0, 5 
syscall

#vv copy the first integer from v0 to the variable first_int vv
#load the address of the first_int variable into t0
la $t0, first_int 
#save the inputted integer into the first_int address (store byte)
sb $v0, 0($t0)
#? copy the first int to a1?


#vv input the second integer vv
#prompt for the second integer input
la $a0, prompt_second_integer
#print the prompt
li $v0, 4
syscall

#take input for second int
li $v0, 5
syscall

#vv Copy second integer from v0 to the varibale second_int vv
#load address of second_int to t1
la $t1, second_int
#save the inputted integer into the second_int address
sb $v0, 0($t1)




#vv Perform and output the addition vv
lb $t0, first_int
lb $t1, second_int
add $s1, $t0, $t1		# $t3 = $t0 + $t2
#print the result
la $a0, addition_output
li $v0, 4
syscall

move $a0, $s1
li $v0, 1
syscall

#print a new line
la $a0, newline
li $v0, 4
syscall

#vv Perform and output the subtraction vv
sub $s1, $t0, $t1		# $t3 = $t0 + $t2
#print the result
la $a0, subtraction_output
li $v0, 4
syscall

move $a0, $s1
li $v0, 1
syscall

#print a new line
la $a0, newline
li $v0, 4
syscall

#vv Perform and output the multiplication vv
mult $t0, $t1
#print the result
la $a0, multiplication_output
li $v0, 4
syscall

mflo $a0 #load the result of the multiplication to $a0
li $v0, 1
syscall

#print a new line
la $a0, newline
li $v0, 4
syscall

#vv Perform and output the division vv
div $t0, $t1
#print the result
la $a0, division_output
li $v0, 4
syscall

mflo $a0 #load the result of the division to $a0
li $v0, 1
syscall

#print a the r for remainder
la $a0, remainder_output
li $v0, 4
syscall

mfhi $a0 #load the result of the division to $a0
li $v0, 1
syscall



li $v0, 10 #exit function
syscall

.data
newline: .asciiz "\n"
prompt_first_integer: .asciiz "Please input the first integer: \n:"
prompt_second_integer: .asciiz "Please input the second integer: \n:"
first_int: .byte 0
second_int: .byte 0
addition_output: .asciiz "The addition is: "
subtraction_output: .asciiz "The subtraction is: "
multiplication_output: .asciiz "The multiplication is: "
division_output: .asciiz "The division is: "
remainder_output: .asciiz " r "