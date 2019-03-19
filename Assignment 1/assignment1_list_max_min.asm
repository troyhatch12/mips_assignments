#This sample program is to let user input one element in the array 
#and store the list in the memory

#COPYRIGHT H.Li
.text
main:

#input the size of the list
la $a0, prompt_input_size
li $v0, 4
syscall

li $v0, 5 #take user input for the size
syscall

#copy the size from $v0 to variable size
la $t0, size #load the address of the size variable into t0
sw $v0, 0($t0) #store v0 to address of t0
move $a1, $v0 #copy the "size" to a1

#input the elements of the list
li $s1, 0 # s1 is the index, initialize to 0
la $t0, list # loading the address of list to $t0
li $t2, 0 # t2 is offset which is initialized to 0

input_loop:
 addi $s1, $s1, 1 # increment index by 1
 bgt $s1, $a1, end_input_loop #if incremented index is greater than desired array size, end loop

#printing the prompt of "please enter the element\n"
la $a0, prompt_input_element #load address of "prompt_input_element" to a0
li $v0, 4 #li: load integer, set v0 as 4 for output string function in syscall
syscall

#taking the input
li $v0, 5 #v0=5 for input integer function in syscall
syscall


#checking for greatest
beq $s1, 1, set_greatest #if this is the first number, set it as the greatest
lw $t4, greatest #load value of the greatest element so far
bgt $v0, $t4, set_greatest
j check_least

set_greatest:
la $t4, greatest
sw $v0, 0($t4) #store the current input value into greatest

check_least:
#check for least
beq $s1, 1, set_least #if this is the first number, set it as the least
lw $t5, least #load value of the min element
blt $v0, $t5, set_least
j save
set_least:
la $t5, least
sw $v0, 0($t5) #store the current input value into least

save:
#saving the input to the array
add $t3, $t0, $t2 # calculate the address for where to store the data
sw $v0, 0($t3) # saving the input
addi $t2, $t2, 4 #offset for next operation

j input_loop

end_input_loop:


#initialize list and increment
li $s1, 0
la $t0, list
li $t2, 0

#ouput description of elements in size
la $a0, prompt_output_element
li $v0, 4
syscall

output_element:

#increment and check if bigger for output
addi $s1, $s1, 1
bgt $s1, $a1, end_output_loop

add $t3, $t0, $t2
lw $a0, 0($t3)

li $v0, 1 #setv0 as 1 to print int
syscall

la $a0, space
li $v0, 4
syscall

addi $t2, $t2, 4
j output_element

end_output_loop:

#output the greatest element
la $a0, max_string
li $v0, 4
syscall

lw $a0, greatest #load the word of the greatest element into the first argument
li $v0, 1 #print an int (the greatest element)
syscall

#output the min element
la $a0, min_string
li $v0, 4
syscall

lw $a0, least #load the word of the least element into the first argument
li $v0, 1 #print
syscall


la $a0, debug_finish
li $v0, 4
syscall

li $v0, 10 #v0=10, exit function
syscall



.data
space: .asciiz " "
max_string: .asciiz "\n The max element is: "
greatest: .word 0
min_string: .asciiz "\n The min element is: "
least: .word 0
list: .space 100 # maximum size of list is 25, you can change this definition
size: .word 0
dataflag1: .word 0x12345678
charflag1: .ascii "abc"
dataflag4: .word 0x22227890
prompt_input_size: .asciiz "Please enter the size of the list: \n"
prompt_input_element: .asciiz "please enter an element: \n"
dataflag2: .word 0x88881111
Input: .space 20 # Allocate 20 bytes of storage for the input string
dataflag3: .word 0x99996666
prompt_output_element: .asciiz "The elements in the list are: "
debug_finish: .asciiz "\n Program finished"
