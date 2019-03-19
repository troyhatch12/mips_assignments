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


end_factorial_loop:


.data
prompt_output_1: .asciiz "The factorial of " 
prompt_output_2: .asciiz " is: "
prompt_integer: .asciiz "Please input an integer between 0 and 12"
user_int: .byte 0
factorial_total: .byte 0