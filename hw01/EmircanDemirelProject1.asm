# Program Description:
# This MIPS assembly program creates and manipulates a grid-based structure. 
# It allows users to input grid dimensions, initialize the grid, plant bombs,
# detonate bombs, and display the grid at various stages.
#
#	EMIRCAN DEMIREL - 1901042674
#	GEBZE TECHNICAL UNIVERSITY - CSE 331 COMPUTER ORGANIZATION - HOMEWORK 1
#
#
.data
# Data Segment: Declaration of variables and constants used in the program
input_buffer: .space 33 # Buffer for user input
grid:        .space 1024    # Allocate space for 32x32 grid
gridNew:     .space 1024
finalGrid:   .space 1024
dx:          .word 0, 0, 1, -1  # Direction array for rows
dy:          .word 1, -1, 0, 0  # Direction array for columns
prompt_row_num: .asciiz "\n Enter the number of rows: "
prompt_col_num: .asciiz "\n Enter the number of columns: "
prompt_row: .asciiz "\n Enter the Row(Only O and . ): "
prompt_error: .asciiz "\n ERROR: limits must be less than 32... exiting\n"
prompt_first: .asciiz "\n ---1st second--- \n"
prompt_second: .asciiz "\n ---2nd second--- \n"
prompt_third: .asciiz "\n ---3rd second--- \n"

.text
.globl main
main:
    # Get the number of rows from the user
    li $v0, 4
    la $a0, prompt_row_num
    syscall

    li $v0, 5
    syscall
    move $s0, $v0  # $s0 keeps the number of rows

    # Get the number of columns from the user
    li $v0, 4
    la $a0, prompt_col_num
    syscall

    li $v0, 5
    syscall
    move $s1, $v0  # $s1 holds the number of columns

    # Check if the number of rows and columns are within the allowed limits
    li $t0, 32  # Max grid size
    bgt $s0, $t0, error  # If rows > 32, go to error
    bgt $s1, $t0, error  # If cols > 32, go to error

    # Pass the number of rows and columns to initializeGrid
    move $a0, $s0  # Pass number of rows in $a0
    move $a1, $s1  # Pass number of columns in $a1
    jal initializeGrid 
    # Print the initial grid (0th second)
    la $a0, prompt_first # Load the base address of the prompt into $a0
    jal printMessage # Print the message
    
    la $a0, grid # Load the base address of the grid into $a0
    move $a1, $s0  # Pass number of rows in $a0
    move $a2, $s1  # Pass number of columns in $a1
    jal printGrid  # Print the grid
    
    jal plantBombs # Plant bombs on gridNew and prepare finalGrid
    la $a0, prompt_second # Load the base address of the grid into $a0
    jal printMessage # Print the message
    la $a0, gridNew # Load the base address of the grid into $a0
    jal printGrid # Print the grid with bombs
    
    jal detonateBombs # Detonate bombs on gridNew and prepare finalGrid
    # Print the final grid after detonation
    la $a0, prompt_third # Load the base address of the prompt into $a0
    jal printMessage # Print the message
    la $a0, finalGrid # Load the base address of the grid into $a0
    jal printGrid # Print the grid after detonation

    # Exit the program
    j exit
    
error:
# print the error message
    li $v0, 4 # print_string
    la $a0, prompt_error # load the address of the string to print
    syscall
    j exit
   
#$a0 -> prompt     
printMessage:
# print the message
    li $v0, 4 # print_string
    la $a0, ($a0) # load the address of the string to print
    syscall
    jr $ra


# function to print grid: $a0 -> grid address to print
#			$a1 -> number of rows for the grid
#			$a2 -> number of columns for the grid
printGrid:
    # Save temporary registers to the stack
    addi $sp, $sp, -12   # Allocate space for three registers on the stack
    sw $t0, 0($sp)       # Save $t0
    sw $t1, 4($sp)       # Save $t1
    sw $t2, 8($sp)       # Save $t2

    li $t0, 0            # Initialize row counter to 0
    move $t2, $a0        # Set $t2 to the start of the current row

    print_row:
        li $t1, 0        # Initialize column counter to 0

        print_column:
            lb $s0, 0($t2)   # Load a character from the grid
            beqz $s0, end_print_column  # Check if it's the null terminator (end of row)
            li $v0, 11
            move $a0, $s0
            syscall
            addi $t1, $t1, 1    # Increment the column counter
            addi $t2, $t2, 1   # Move to the next character in the row
            blt $t1, $a2, print_column  # Use $a2 for column limit

        end_print_column:
            li $v0, 11
            li $a0, '\n'     # Print a newline character
            syscall
            addi $t0, $t0, 1     # Increment the row counter
            blt $t0, $a1, print_row  # Use $a1 for row limit

    end_print_row:
    # Restore temporary registers from the stack
    lw $t2, 8($sp)
    lw $t1, 4($sp)
    lw $t0, 0($sp)
    addi $sp, $sp, 12   # Deallocate space from the stack
    jr $ra

# $a1-> number of rows $a2-> number of columns
# Initializes the grid with bombs and copies the bomb placement to the finalGrid
plantBombs:
    # Save registers
    addi $sp, $sp, -28            # Allocate space for 5 registers on the stack
    sw $ra, 0($sp)                # Save $ra
    sw $s0, 4($sp)                # Save $s0 (row index)
    sw $s1, 8($sp)                # Save $s1 (column index)
    sw $s2, 12($sp)               # Save $s2 (temporary address for gridNew)
    sw $s3, 16($sp)               # Save $s3 (temporary address for finalGrid)
    sw $s4, 20($sp)               # Save $s4 (number of rows)
    sw $s5, 24($sp)               # Save $s5 (number of columns) 

    move $s4, $a1                 # Move number of rows to $s4
    move $s5, $a2                 # Move number of columns to $s5
    li $s0, 0                     # Initialize row index
    la $s2, gridNew               # Load base address of gridNew
    la $s3, finalGrid             # Load base address of finalGrid

plant_row:
    blt $s0, $s4, row_in_bounds   # Check if row index is less than number of rows
    j finish_plant               

row_in_bounds:
    li $s1, 0                     # Initialize column index

plant_column:
    blt $s1, $s5, column_in_bounds # Check if column index is less than number of columns
    j next_row

column_in_bounds:
    # Calculate address for gridNew's and finalGrid's cell
    mul $t1, $s0, $s5             # Calculate offset for current row
    add $t2, $s2, $t1             # Calculate address for gridNew's cell
    add $t3, $s3, $t1             # Calculate address for finalGrid's cell
    add $t2, $t2, $s1             # Add column offset for gridNew
    add $t3, $t3, $s1             # Add column offset for finalGrid

    li $t4, 'O'                   # ASCII value for 'O'
    sb $t4, 0($t2)                # Plant bomb in gridNew
    sb $t4, 0($t3)                # Copy bomb to finalGrid

    addi $s1, $s1, 1              # Increment column index
    j plant_column

next_row:
    addi $s0, $s0, 1              # Increment row index
    j plant_row

finish_plant:
    # Restore registers
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    lw $s5, 24($sp)
    addi $sp, $sp, 28             # Deallocate space from the stack
    jr $ra                        #

# $a1-> number of rows $a2-> number of columns
#  Detonates the bombs, updates the finalGrid, and clears adjacent cells.
detonateBombs:
    # Save registers
    addi $sp, $sp, -28
    sw $ra, 0($sp)
    sw $s0, 4($sp)       # i (row index)
    sw $s1, 8($sp)       # j (column index)
    sw $s2, 12($sp)      # Address calculation for grid
    sw $s3, 16($sp)      # k (direction index)
    sw $s4, 20($sp)	# number of rows
    sw $s5, 24($sp)	#number of columns

    # Initialize row index i
    li $s0, 0   # i
    move $s4, $a1 # number of rows
    move $s5, $a2 # number of columns
loop_i:
    blt $s0, $s4, continue_i # Check if i < ROWS
    j end_i # If i >= ROWS, exit loop

continue_i:
    # Initialize column index j
    li $s1, 0 # j
loop_j:
    blt $s1, $s5, continue_j # Check if j < COLS
    j end_j # If j >= COLS, skip to next row

continue_j:
    # Load the character at grid[i][j]
    la $s2, grid # Load the address of grid
    mul $t1, $s0, $s5 # Calculate row offset
    add $s2, $s2, $t1 # Add row offset
    add $s2, $s2, $s1 # Add column offset
    lb $s3, 0($s2) # Load the character at grid[i][j]

    # Check if it's a bomb
    li $t0, 'O' # ASCII value for 'O'
    bne $s3, $t0, next_j    # If it's not a bomb, skip to next column

    # Bomb found, detonate at [i][j] and adjacent cells
    la $s2, finalGrid # Load the address of finalGrid
    mul $t1, $s0, $s5 # Calculate row offset
    add $s2, $s2, $t1 # Add row offset
    add $s2, $s2, $s1   # Add column offset
    li $t0, '.' # ASCII value for '.'
    sb $t0, 0($s2) # Detonate bomb at [i][j]
     # Also detonate adjacent cells
    li $s3, 0  # k
loop_k:
    blt $s3, 4, continue_k # Check if k < 4
    j next_j # If k >= 4, skip to next column

continue_k:
    # Calculate ni and nj
    sll $t0, $s3, 2       # Multiply index k by 4 to get the word offset
    lw $t1, dx($t0)       # Load dx[k] using the word offset
    add $t1, $s0, $t1      # ni = i + dx[k]
    lw $t2, dy($t0)       # Load dy[k] using the word offset
    add $t2, $s1, $t2      # nj = j + dy[k]

    # Check boundaries for ni and nj
    bltz $t1, next_k      # if ni < 0, skip
    bge $t1, $s4, next_k   # if ni >= ROWS, skip
    bltz $t2, next_k      # if nj < 0, skip
    bge $t2, $s5, next_k   # if nj >= COLS, skip

    # Update the cell in finalGrid
    la $t0, finalGrid
    mul $t3, $t1, $s5      # Calculate row offset
    add $t0, $t0, $t3     # Add row offset
    add $t0, $t0, $t2     # Add column offset
    li $t3, '.'
    sb $t3, 0($t0)        # Set cell to '.'

next_k:
    addi $s3, $s3, 1
    j loop_k

next_j:
    addi $s1, $s1, 1
    j loop_j

end_j:
    addi $s0, $s0, 1
    j loop_i

end_i:
    # Restore registers
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    lw $s5, 24($sp)
    addi $sp, $sp, 28

    jr $ra  # Return to caller

#Initializes the grid with user-provided data while validating input
#the number of rows in the grid ($a0) and the number of columns in the grid ($a1)
initializeGrid:
    # Receive rows in $a0 and columns in $a1 from the caller
    move $s0, $a0  # $s0 now holds the number of rows
    move $s1, $a1  # $s1 now holds the number of columns

    # Load the address of the grid
    la $t0, grid
    li $t1, 0      # Initialize row counter to 0

read_row:
    blt $t1, $s0, continue_read_row # Check if row counter is less than number of rows
    jr $ra # Return to caller
    
continue_read_row:
    # Prompt user for a row of characters
    li $v0, 4
    la $a0, prompt_row
    syscall

    # Read a row of characters from the user
    li $v0, 8
    la $a0, input_buffer
    addi $a1, $s1, 1 # Maximum characters to read, considering the null terminator
    syscall

    # Copy input to the grid and set null terminator
    la $t2, input_buffer
    li $t3, 0   # Column counter

    validate_and_store:
        lb $t4, 0($t2)   # Load byte from input buffer
        beqz $t4, fill_remaining  # If it's the null terminator, fill remaining
        # Check if character is valid ('O' or '.')
        li $t6, 'O'
        li $t7, '.'
        beq $t4, $t6, store_char # If char is 'O', store it
        beq $t4, $t7, store_char # If char is '.', store it

        # Replace invalid character with '.'
        li $t4, '.'

        store_char:
        sb $t4, 0($t0)   # Store byte in grid
        addi $t2, $t2, 1 # Move to next byte in buffer
        addi $t0, $t0, 1 # Move to next byte in grid
        addi $t3, $t3, 1 # Increment column counter
        blt $t3, $s1, validate_and_store # Check next char

    fill_remaining:
        blt $t3, $s1, continue_fill
        j read_next_row

    continue_fill:
        sb $zero, 0($t0)   # Set null terminator for remaining columns
        addi $t0, $t0, 1  # Move to next byte in grid
        addi $t3, $t3, 1  # Increment column counter
        j fill_remaining

    read_next_row:
        # Increment the row counter
        addi $t1, $t1, 1
        j read_row
    
exit:
    # Exit the program
    li $v0, 10
    syscall
