.data
enter1:.asciiz "\n enter any number for A:"
enter2:.asciiz "\n enter for B:"
enter3:.asciiz "\n enter a number for C:"
complex_roots:.asciiz "\n complex roots "
answer:.asciiz "\n\nYour answer is\n"
two: .float 2
four: .float 4
discriminant_checker:.float 0

.text
main:
li $t4,10
li $t5,0
Start:
bge $t5,$t4,exit


lwc1 $f1,two                   #$f1 holds 2.0
lwc1 $f2,four                  #$f2 holds 4.0
lwc1 $f3,discriminant_checker       #$f3 holds 0.0

la $a0,enter1                       #Tell user to enter any number as A
li $v0,4
syscall
li $v0,6
syscall
mov.s $f4,$f0                       #$f4 holds A

la $a0,enter2                       #Tell user to enter any number as B
li $v0,4
syscall
li $v0,6
syscall
mov.s $f5,$f0                       #$f5 holds B

la $a0,enter3                       #Tell user make e enter any number as C
li $v0,4
syscall
li $v0,6
syscall
mov.s $f6,$f0                       #$f6 holds C

#calculate discriminant when d = b^2-4*a*c
# 4=$f2, a=$f4, b=$f5, c=$f6

mul.s $f7,$f5,$f5                  #$f7 = b^2
mul.s $f8,$f2,$f4                  
mul.s $f8,$f8,$f6                  #$f8 = 4*a*c
sub.s $f8,$f7,$f8                  #$f8 = d = b^2-4*a*c
mfc1 $t1,$f8                       

blez $t1,error_label               
sqrt.s $f10,$f8                    

#calculate roots                      #-b+-sqrtd/2*a
neg.s $f9,$f5                      
add.s $f13,$f9,$f10               
sub.s $f14,$f9,$f10                
mul.s $f1,$f1,$f4                  
div.s $f15,$f13,$f1                
div.s $f16,$f14,$f1                
la $a0,answer
li $v0,4
syscall

mov.s $f12,$f15                    
li $v0,2
syscall


mov.s $f12,$f16                   
li $v0,2
syscall


error_label:
la $a0,complex_roots
li $v0,4
syscall

return:
addi $t5,$t5,1
b Start


exit:
li $v0,10                    
syscall
