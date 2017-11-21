# This program multiplies two 31-bit binary numbers using the "shift and add" algorithm historically used in computers
# The two numbers are read through the keyboard 
# Eric Chien/Kevin Huynh/Treven Stoddard
.text
.globl main

main:
# Display prompt1
li $v0, 4
la $a0, prompt1
syscall

li $v0, 5 # read keyboard into $v0 (number x is number to test)
syscall

move $t0,$v0 # move the first number from $v0 in $t1

# Display prompt2
li $v0, 4
la $a0, prompt2
syscall

li $v0, 5 # read keyboard into $v0 (number x is number to test)
syscall

move $t1,$v0 # move the second number from $v0 in $t1

li $s0, 0 #Load register with 0, used as a comparator
li $s1, 1 #Load register with 1, used as a comparator
move $s2, $t0 #load register with first number because manipulate the first to multiply
move $s3 $t1 #load register with second number because manipulate the number to multiply

#Start conditions
beq $t0, $s0, L3 #Terminate if number A is 0
beq $t1, $s0, L3 #Terminate if number B is 0
andi $t7, $t1, 1 #Store register with least significant bit of $t1

L1:#Adding (can be skipped if LSB of number A is 0)
andi $t4, $t0, 1 #Get LSB of number A
beq $t4, $s0, L2 #Skip if 0 and go to shifting
addu $t3, $t3, $t1 #Register D plus number B

#LSB
sltu $t5, $t3, $t1 #If register D is less than number B then we will need to add 1 to register C
addu $t2, $t2, $t5 #Register C plus the case of overflow
addu $t2, $t2, $t6 #Register C plus secondary part of number B 

#Shifting 

L2:#Essentially this shifts number B by 1 to the left, number A by 1 to the right, and makes number B stored into 2 registers
srl $t4, $t1, 31 #Get MSB of number B
sll $t1, $t1, 1 #Shift number B by 1 to the left
sll $t6, $t6, 1 #Shift secondary part of number B by 1 to the left
addu $t6, $t6, $t4 #Adding MSB of B to secondary part of number B
srl $t0, $t0, 1 #Shifting number A by 1 to the right
#Go back and add
bne $t0, $s0, L1 #Go back and Add the next bits

L3:
#Display the answer
li $v0, 1
add $a0, $s2, $zero
syscall #Displays the first number

li $v0, 4
la $a0, answer
syscall #Displays answer text

li $v0, 1
add $a0, $s3, $zero
syscall #Displays the second number

li $v0, 4
la $a0, answer1
syscall #Displays answer1

li $v0, 1
add $a0, $t2, $zero
syscall #Displays register C in decimal format

li $v0, 4
la $a0, answer2
syscall #Displays answer2

li $v0, 1
add $a0, $t3, $zero
syscall #Displays register D in decimal format

#exit
end: li $v0, 10 
syscall 

.data
prompt1:
 .asciiz "Enter the first number: "
prompt2:
 .asciiz "Enter the second number: "
answer:
 .asciiz " multiplied by "
answer1:
 .asciiz " is: "
answer2:
 .asciiz " and "
