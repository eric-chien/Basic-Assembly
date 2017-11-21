# This program prints out all prime numbers between 0 and a given number
# The number is read through the keyboard 
# Author: Eric Chien
.text
.globl main

main:
# Display prompt1
li $v0, 4
la $a0, prompt1
syscall

li $v0, 5 # read keyboard into $v0 (number x is number to test)
syscall

move $t1,$v0 # move the first number from $v0 in $t1

li $t0, 2 #load $t0 with 3, used as a number that goes from 3 through the entered number
li $t2, 2 #load $t2 with 2, used as a divisor for the number
li $t8, 3 #load $t8 with 3, used to skip steps if user enters a number less than or equal to 3
li $t9, 0 #load $t9 with 0

li $v0, 4
la $a0, prompt2
syscall
li $v0, 1
add $a0, $t1, $zero
syscall
li $v0, 4
la $a0, prompt3
syscall

#Jump to answer if number is less than 3
ble $t1, $t8, L6

#Jump to loop if number entered is greater than 3
bge $t1, $t0, L1 #start loop

#Branch (jump) to L2 until loop is finished
L1:
bge $t1, $t0, L2

# Determine if a number is prime
L2: 
#Branch if divisor is equal than the numerator
beq $t2, $t0,L3
#Otherwise 
remu $t3, $t0, $t2
#Branch if remainder is not 0 (chance of being prime)
bne $t3, $t9, L5
#Branch if remainer is 0 (This number is not prime so increase the counter)
beq $t3, $t9, L4


#Add one to the divisor and try again
L5:
addi $t2, $t2, 1
bne $t9, $t2, L2

#Print the prime number
L3: 
#Dont print the number if its the user number
beq $t1, $t0, L4

move $a0, $t0
li $v0, 1
add $a0, $t0, $zero
syscall
li $v0, 4 
la $a0, answer
syscall
bne $t9, $t2, L4

#Reset divisor and increase numerator unil it reaches number entered by user
L4:
li $t2, 2
addi $t0, $t0, 1
#Branch if the user input number is is greater/equal to the running counter number
bge $t1, $t0, L2

L7:
#exit
end: li $v0, 10 
syscall 

#Display that there are no prime numbers between 1 and user number
L6:
li $v0, 4
la $a0, noprime
syscall
li $v0, 1
add $a0, $t1, $zero
syscall
bne $t0, $t9, L7
 
.data
prompt1:
 .asciiz "Enter the number "
prompt2:
 .asciiz "\nThe prime numbers between 1 and "
prompt3:
 .asciiz " are: \n"
noprime:
 .asciiz "There are no prime numbers between 1 and "
answer:
 .asciiz ",  "
