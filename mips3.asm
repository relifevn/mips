
#
# Pn = 1.3.5. ... .(2n+1)
# 

.data
msg1: .asciiz "Give a number: "

.text
.globl main
main:
    li $v0,  4
    la $a0,  msg1
    syscall             # print msg
    
    li $v0,  5
    syscall             # read an int
    add $a0, $v0, $zero # move to $a0
    
    jal Pn             # call fib

    add $a0, $v0, $zero
    li  $v0, 1
    syscall

    li $v0, 10
    syscall

Pn:
    # a0 = n
    # if (n > 0) return (2*n+1) * P(n-1);
    # if (n = 0) return 1;
    # v0 = result

    # save in stack
    addi $sp, $sp, -16 
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)
    sw   $s1, 8($sp)
    sw 	 $s2, 12($sp)

    add  $s0, $a0, $zero   # s0 = n
    beq  $s0, $zero, return0

    addi $a0, $s0, -1
    
    # recursive
    jal Pn

    add $s1, $zero, $v0         # s1 = Pn(n - 1)
    
    mul $s2, $s0, 2 		# s2 = 2*n
    addi $s2, $s2, 1 		# s2 = 2*n + 1
    mul $v0, $v0, $s2		# v0 = (2*n + 1) * Pn(n-1)

    exitPn:
        lw   $ra, 0($sp)        # read registers from stack
        lw   $s0, 4($sp)
        lw   $s1, 8($sp)
        lw   $s2, 12($sp)
        addi $sp, $sp, 16       # bring back stack pointer
        jr   $ra

    return0:     
        li $v0, 1
        j  exitPn