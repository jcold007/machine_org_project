# File: testprint.s
# By: Darrin G. Vaniglia, Xavier University
# 21 December 2000
# Modified by Liz Johnson 11/13
#
# Description:
# Test program for print portion of CSCI210 12F project.

         .data
prompt1: .ascii  "\nSelect which tests you would like to run:\n"
prompt2: .ascii  "\n  0. Test print string."
prompt3: .ascii  "\n  1. Test print binary."
prompt4: .ascii  "\n  2. Test print hexadecimal."
prompt5: .ascii  "\n  3. Test print decimal."
prompt6: .ascii  "\n  4. Test print single float."
prompt7: .ascii  "\n  5. Test double float."  
prompt8: .ascii  "\n  6. Test invalid input."
prompt9: .asciiz "\nPlease input your selection -->"
new:     .asciiz "\n"
cont:    .asciiz "\nWould you like to continue yes/no (1/0) -->"
err:     .asciiz "\nInvalid selection, please try again.\n"
jmp:     .word   test_p0, test_p1, test_p2, test_p3, test_p4, test_p5, test_p6            

         .text

main:                                
        
main_loop:
         li      $v0, 4
         la      $a0, prompt1
         syscall
         li      $v0, 5 
         syscall
         move    $t0, $v0
         bltz    $t0, main_err
         bgt     $t0, 6, main_err  
         mul     $t0, $t0, 4
         lw      $t1, jmp + 0($t0)
         jalr    $t1
         li      $v0, 4
         la      $a0, cont
         syscall
         li      $v0, 5
         syscall
         bne     $v0, $zero, main_loop
         j       exit
         
main_err:
         li      $v0, 4
         la      $a0, err
         syscall
         j       main_loop

exit:
         li   $v0, 10          # system call for exit
         syscall               # we are out of here.
         add     $0, $0, $0         #nop
         

#Begin test print string function.
         .data
p0_str1: .asciiz "Hello World!"
p0_str2: .asciiz "The quick brown fox jumped over the lazy dog."
p0_str3: .asciiz ""
p0_pt1:  .asciiz "\nYour output was        -->"
p0_pt2:  .asciiz "\nThe correct output was -->"
p0_strs: .word   p0_str1, p0_str1, p0_str2, p0_str2, p0_str3, p0_str3 
         .text
test_p0:
         addi    $sp, $sp, -4
         sw      $ra, 0($sp)
        
         la      $a0, p0_strs
         li      $a1, 3
         li      $a2, 0
         jal     run_test
        
         lw      $ra, 0($sp)
         addi    $sp, $sp, 4
         jr      $ra


#Begin test binary function.
         .data
p1_str1: .asciiz "00000000000000000000000000000000"
p1_str2: .asciiz "00000000000000000000000000000001"
p1_str3: .asciiz "10000000000000000000000000000000"
p1_str4: .asciiz "11111111111111111111111111111111"
p1_str5: .asciiz "11110000111100001111000011110000"
p1_vals: .word   0x0, p1_str1, 0x1, p1_str2, 0x80000000, p1_str3, 0xFFFFFFFF, p1_str4, 0xF0F0F0F0, p1_str5

         .text
test_p1:
         addi    $sp, $sp, -4
         sw      $ra, 0($sp)
        
         la      $a0, p1_vals
         li      $a1, 5
         li      $a2, 1
         jal     run_test
        
         lw      $ra, 0($sp)
         addi    $sp, $sp, 4
         jr      $ra

#Begin test  hex function.
         .data
p2_str1: .asciiz "0x00000000"
p2_str2: .asciiz "0x00000001"
p2_str3: .asciiz "0x80000000"
p2_str4: .asciiz "0xFFFFFFFF"
p2_str5: .asciiz "0xF0F0F0F0"
p2_str6: .asciiz "0xADCDEF01"
p2_str7: .asciiz "0xCAFEFACE"
p2_vals: .word   0x0, p2_str1, 0x1, p2_str2, 0x80000000, p2_str3, 0xFFFFFFFF, p2_str4, 0xF0F0F0F0, p2_str5, 0xADCDEF01, p2_str6, 0xCAFEFACE, p2_str7

         .text
test_p2:
         addi    $sp, $sp, -4
         sw      $ra, 0($sp)
        
         la      $a0, p2_vals
         li      $a1, 7
         li      $a2, 2
         jal     run_test
        
         lw      $ra, 0($sp)
         addi    $sp, $sp, 4
         jr      $ra

#Begin test deciaml function.
         .data
p3_str1: .asciiz "0"
p3_str2: .asciiz "1"
p3_str3: .asciiz "-1"
p3_str4: .asciiz "42"
p3_str5: .asciiz "-42"
p3_str6: .asciiz "2147483647"
p3_str7: .asciiz "-2147483647"
p3_vals: .word   0, p3_str1, 1, p3_str2, 0xFFFFFFFF, p3_str3, 42, p3_str4, 0xffffffd6, p3_str5, 2147483647, p3_str6, 0x80000001, p3_str7

         .text
test_p3:
         addi    $sp, $sp, -4
         sw      $ra, 0($sp)
        
         la      $a0, p3_vals
         li      $a1, 7
         li      $a2, 3
         jal     run_test
        
         lw      $ra, 0($sp)
         addi    $sp, $sp, 4
         jr      $ra


#Begin test float function.
         .data
p4_str1: .asciiz "0"
p4_str2: .asciiz "NaN"
p4_str3: .asciiz "NaN"
p4_str4: .asciiz "+infinity"
p4_str5: .asciiz "-infinity"
p4_str6: .asciiz "1.10000000000000000000000E0000001"
p4_str7: .asciiz "-1.10000000000000000000000E-0000001"
p4_str8: .asciiz "1.11111111111111111111111E1111111"
p4_str9: .asciiz "-1.11111111111111111111111E-1111110"
p4_strA: .asciiz "1.00011110000111100001111E1010101"
p4_strB: .asciiz "-1.00011110000111100001111E1010101"
p4_vals: .word   0, p4_str1, 0x7FC00000, p4_str2, 0xFFFFFFFF, p4_str3, 0x7F800000, p4_str4, 0xFF800000, p4_str5, 0x40400000, p4_str6, 0xBF400000, p4_str7, 0x7F7FFFFF, p4_str8, 0x80FFFFFF, p4_str9, 0x6A0F0F0F, p4_strA, 0xEA0F0F0F, p4_strB

         .text
test_p4:
         addi    $sp, $sp, -4
         sw      $ra, 0($sp)
        
         la      $a0, p4_vals
         li      $a1, 11
         li      $a2, 4              
         jal     run_test
        
         lw      $ra, 0($sp)
         addi    $sp, $sp, 4
         jr      $ra



#new# begin
#Begin test double float function.
         .data
p5_str1: .asciiz "0"
p5_str2: .asciiz "NaN"
p5_str3: .asciiz "NaN"
p5_str4: .asciiz "+infinity"
p5_str5: .asciiz "-infinity"
p5_str6: .asciiz "1.10000000000000000000000E0000001"
p5_str7: .asciiz "-1.10000000000000000000000E-0000001"
p5_str8: .asciiz "1.11111111111111111111111E1111111"
p5_str9: .asciiz "-1.11111111111111111111111E-1111110"
p5_strA: .asciiz "1.00011110000111100001E1010101"
p5_strB: .asciiz "-1.00011110000111100001E1010101"
p5_vals: .word   0, p5_str1, 0x7FC00000, p5_str2, 0xFFFFFFFF, p5_str3, 0x7FE00000, p5_str4, 0xFFE00000, p5_str5, 0x40040000, p5_str6, 0xBFF0000, p5_str7, 0x7FEFFFFF, p5_str8, 0x801FFFFF, p5_str9, 0x6581E1E1, p5_strA, 0xD581E1E1, p5_strB

         .text
test_p5:
         addi    $sp, $sp, -4
         sw      $ra, 0($sp)
        
         la      $a0, p5_vals
         li      $a1, 11
         li      $a2, 5             
         jal     run_test
        
         lw      $ra, 0($sp)
         addi    $sp, $sp, 4
         jr      $ra 


  # Begin test invalid input function
         .data
p6_str1: .asciiz "\nYour function should output an error message and terminate\n\n"
         
         .text
test_p6:
         li      $v0, 4
         la      $a0, p6_str1
         syscall
         
         li      $a0, 7
         li      $a1, 0x42
         jal     print
         jr      $ra      
# Begin function to run tests 0-5         
         .data
rt_pt1:  .asciiz "\nYour output was        -->"
rt_pt2:  .asciiz "\nThe correct output was -->"

         .text   
run_test:
         addi    $sp, $sp, -20
         sw      $ra, 16($sp)
         sw      $s0, 12($sp)
         sw      $s1, 8($sp)
         sw      $s2, 4($sp)
         sw      $s3, 0($sp)

         li      $s0, 0
         move    $s1, $a0
         move    $s2, $a1
         move    $s3, $a2
        
run_test_loop:        
         li      $v0, 4
         la      $a0, rt_pt1
         syscall
         move    $a0, $s3
         lw      $a1, 0($s1)
         jal     print
         li      $v0, 4
         la      $a0, rt_pt2
         syscall
         li      $v0, 4
         lw      $a0, 4($s1)
         syscall
         addi    $s0, $s0, 1
         addi    $s1, $s1, 8
         blt     $s0, $s2, run_test_loop

         lw      $s3, 0($sp)
         lw      $s2, 4($sp)         
         lw      $s1, 8($sp)
         lw      $s0, 12($sp)
         lw      $ra, 16($sp)
         addi    $sp, $sp, 20
         jr      $ra

.data
buffer1: .space 80
.text

reverse:
	# this function reverses the string in buffer
	# $a0 has address of beginning of string
	# $a1 has address of end of string
	# thanks to Noah for this
	addi	$t1, $a0, -1
	addi 	$t2, $a1, 0
	la 	$t3, buffer1
	# reverse the string in buffer and put result into buffer1
revloop1:
	beq 	$t2, $t1, revout1
	lb	$t4, 0($t2)
	sb	$t4, 0($t3)
	subi	$t2, $t2, 1
	addi	$t3, $t3, 1
	j	revloop1
revout1:
	# now copy the reversed string back into buffer
	la	$t1,buffer1
	la	$t2,buffer
revloop2:
	lb	$t3, 0($t1)
	sb	$t3, 0($t2)
	beq	$t3, $zero, revout2
	addi	$t1, $t1, 1
	addi	$t2, $t2, 1
	j	revloop2
revout2:
	jr	$ra
				
##############################################################
#                                                            #
#                   Print starts here                        #
#                                                            #
##############################################################
.data
buffer:
	.space 80
.text

print:	# this is the main print function
	# $a0 has 0 for string, 1 for binary, 2 for hex, 3 for int, 4 for float, 5 for double, 7 for invalid
	
	# spill $ra onto stack
	sw	$ra, -4($sp)
	addi	$sp,$sp,-4

	beq	$a0,0,call_print_str
	beq	$a0,1,call_print_bin
	beq	$a0,2,call_print_hex
	beq	$a0,3,call_print_int
	beq	$a0,4,call_print_float
	beq   $a0,5,call_print_double  #new#
	beq	$a0,7,call_print_invalid

default: 
	li      $v0, 4
   la      $a0, err
   syscall
   j	finish
call_print_str:
	jal	print_str
	j	finish 
call_print_bin:
	jal	print_bin
	j	finish
call_print_hex:
	jal	print_hex
	j	finish 
call_print_int:
	jal	print_int
	j	finish
call_print_float:
	jal	print_float
	j	finish 
call_print_double: #new#
	jal 	print_double #new#
	j	finish #new#
call_print_invalid:
	jal	print_invalid
	j	finish 
finish:	
	# restore $ra from stack		
	lw	$ra,0($sp)
	addi	$sp,$sp,4
	jr 	$ra
.data:
tobedone:	.asciiz "Hello World (2)"
empty:		.space 51
.text

print_str: # add code for printing string here
	#	replace with your code
	#	-----------------------------------
#	li	$v0,4	
#	la	$a0, tobedone
#	syscall
	
	#--------11/12/13-starting code---------
	li 	$v0, 8 			# take in input
        la 	$a0, empty 		# load empty string into address
        li 	$a1, 50 		# *byte space for string*
        move 	$s0,$a0 		# save string to $t0
        syscall
        
        li	$v0, 4
        syscall
	#---------------------------------------
	
	#	-----------------------------------
	jr	$ra	
print_bin: # add code for printing binary here
	#	replace with your code
	#	-----------------------------------
	li	$v0,4	
	la	$a0, tobedone
	syscall
	#	-----------------------------------
	jr	$ra

print_hex:  # add code for printing hex here
	#	replace with your code
	#	-----------------------------------
	li	$v0,4	
	la	$a0, tobedone
	syscall
	#	-----------------------------------
	jr	$ra

print_int: # code for printing integer is here
	la	$t2,buffer
        sb 	$zero, 0($t2)		# put null character at beginning of string since we'll reverse string
        addi 	$t2,$t2,1		#t2 is address of next byte in buffer
        slt 	$t0, $a1, $zero 	# check to see if input is negative
        beq 	$t0, $zero, posint  	# branch if zero or positive number
negint: 				# negative number
	     addi 	$t1, $zero, 45		# save sign ('-') for later
        sub 	$t3, $zero, $a1		# change input to absolute value and copy to $t3
        j 	procint
posint: addi 	$t3, $a1, 0		# copy input to $t3
procint:	# $t3 holds absolute value of input, $t1 holds sign if negative
	     div	$t4,$t3,10		# strip off rightmost digit and store in $t5
	     mul 	$t4,$t4,10
	     sub	$t5,$t3,$t4
	     addi	$t5,$t5,48		# change t5 to ASCII rep of digit
	     sb	$t5,0($t2)		# store char into next space in string buffer
        addi 	$t2,$t2,1
        div	$t3,$t3,10		# get rid of rightmost digit in input
        beq	$t3,$zero,doneprocint	# if result is 0, done
	     j	procint			# otherwise, process rest of number
doneprocint:	
	     bge	$a1,$zero,signadded	# finished building string - should  
                                 # we  add sign?
	     sb	$t1,0($t2)   		# put the - sign in last position of  
                              # string if negative
	     j	skippos
signadded:
	     sub	$t2, $t2, 1		# for positive number need to readjust $t2 
                           # so it has address of last byte in string
skippos:	# reverse buffer
	                   la	$a0, buffer		# set up arguments for       
                                          # reverse 
      	addi	$a1, $t2, 0
      	sw	$ra, -4($sp)		# put $ra on stack to save it
      	addi	$sp,$sp,-4
	      jal	reverse			# call reverse
	      lw	$ra,0($sp)		# restore $ra from stack
	      addi	$sp,$sp,4
	# print string
      	li	$v0, 4			# print result!
      	la 	$a0,buffer
      	syscall
      	jr	$ra			# return from print_int
	
	# add code here for printing float
print_float:
	#	replace with your code
	#	-----------------------------------
	li	$v0,4	
	la	$a0, tobedone
	syscall
	#	-----------------------------------
	jr	$ra
	# add code here for printing float
print_double:  #new
	#	replace with your code
	#	-----------------------------------
	li	$v0,4	
	la	$a0, tobedone
	syscall
	#	-----------------------------------
	jr	$ra	
	# modify code here for printing invalid data 
print_invalid:
	.data
invalid: .asciiz "Invalid data - bye"	
	.text
	li	$v0,4	
	la	$a0, invalid
	syscall
	j	exit
