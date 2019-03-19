# author: Troy Hatchard
# Date: 17/03/2019
# Description: Will take input from the user for an integer between
# 0 and 12 and will output the results of the factorial of
# this integer

.text
main:

#vv get user input vv
#prompt for input
la $a0, prompt_integer
li $v0, 4
syscall

#collect input for the integer
li $v0, 5
syscall

#vv copy the integer from v0 to the user_int variable
#load the address of user_int
la $t0, user_int
#save the input integer into user_int address
sb $v0, 0($t0)

# vv compute factorial vv
#setup loop index
lb $s1, user_int


factorial_loop:

#break loop if index less than 1
blt $s1, 1, end_factorial_loop

#load total from data
lb $t1, factorial_total
#multiply total by the current index
mult $t1, $s1
#get total from $LO
mflo $t1

#load address of factorial_total
la $t2 factorial_total
#store the total back to factorial_total
sb $t1, 0($t2)

#increment index
sub $s1, $s1, 1

j factorial_loop

end_factorial_loop:

#output first part of sentence
la $a0, prompt_output_1
li $v0, 4
syscall

#output user input int
lb $a0, user_int
li $v0, 1
syscall

#output second part of sentence
la $a0, prompt_output_2
li $v0, 4

syscall
lb $a0, factorial_total
li $v0, 1
syscall



#exit program
li $v0, 10 
syscall

.data
prompt_output_1: .asciiz "The factorial of " 
prompt_output_2: .asciiz " is: "
prompt_integer: .asciiz "Please input an integer between 0 and 12: "
user_int: .byte 0
factorial_total: .byte 1