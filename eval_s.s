.global eval_s

# a0 - char *expr_str
# a1 - int *pos

# t0 - int value
# t1 - char token
# t2 - int pos_val
# t3 - temporary for storing results
# t4 - temporary for intermediate computations

eval_s:
    
    addi sp, sp, -16
    sw ra, 12(sp)

expression:
    # Call term to get the value of the term and store in t0
    call term_s
    mv t0, a0  # Move result to t0

expression_loop:
    
    lw t2, 0(a1)  # Load pos value
    add t3, a0, t2  # Compute address to get character from
    lb t1, 0(t3)  # Load token (character)
    
    # Check if token is '+' or '-'
    beq t1, '+', handle_plus
    beq t1, '-', handle_minus
    j expression_end

handle_plus:
    addi t2, t2, 1  # Increment pos value
    sw t2, 0(a1)  # Update pos in memory
    call term_s  # Call term_s again
    add t0, t0, a0  # Add the result to t0 (value)
    j expression_loop

handle_minus:
    addi t2, t2, 1  # Increment pos value
    sw t2, 0(a1)  # Update pos in memory
    call term_s  # Call term_s again
    sub t0, t0, a0  # Subtract the result from t0 (value)
    j expression_loop

expression_end:

    # Load return value and cleanup
    mv a0, t0  # Set return value
    lw ra, 12(sp)  # Restore return address
    addi sp, sp, 16  # Restore stack pointer
    ret



