
#
# Pn = 1.3.5. ... .(2n+1)
# 

.data
msg1: .asciiz "Give a number: "
list: .word 3, 0, 1, 2, 6, -2, 4, 7, 3, 7
list: .space 1000  # 250 elements of word 

.text
.globl main
main:
    li $v0,  4
    la $a0,  msg1
    syscall             # print msg
    
    li $v0,  5
    syscall             # read an int
    add $a0, $v0, $zero # move to $a0
    
    la $t3, list         # put address of list into $t3
    li $t2, 6            # put the index into $t2
    add $t2, $t2, $t2    # double the index
    add $t2, $t2, $t2    # double the index again (now 4x)
    add $t1, $t2, $t3    # combine the two components of the address
    lw $t4, 0($t1)       # get the value from the array cell to t4
    sw $t4, 0($t1)  	 # set the value of t4 to array cell

    add $a0, $v0, $zero
    li  $v0, 1
    syscall

    li $v0, 10
    syscall
