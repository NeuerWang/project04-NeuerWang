.global fib_rec_s

fib_rec_s:
    # Check if n (in a0) is less than or equal to 1
    blez a0, base_case  # if n <= 1, go to base_case

    # Recursion for fib_rec_s(n - 1)
    addi sp, sp, -8  # allocate stack space for saving registers
    sw ra, 4(sp)     # save return address
    addi a0, a0, -1  # decrement n
    call fib_rec_s   # recursive call
    lw ra, 4(sp)     # restore return address
    sw a0, 0(sp)     # save result of fib_rec_s(n - 1) on the stack

    # Recursion for fib_rec_s(n - 2)
    addi a0, a0, -1  # decrement n again
    call fib_rec_s   # recursive call

    # Add results of fib_rec_s(n - 1) and fib_rec_s(n - 2)
    lw t0, 0(sp)     # load result of fib_rec_s(n - 1) from the stack
    add a0, a0, t0   # add the results

    addi sp, sp, 8   # deallocate stack space
    ret              # return the result

base_case:
    # if n <= 1, just return n
    ret

