#Implemente um programa em assembly para o IBM PC 8086 para ler um número via teclado, imprimir números entre 0 e o número lido. Cada número deve ser impresso em uma nova linha. Organize seu código em procedimentos (rotinas chamadas via call).


/*
* \author: Marco e Sá
* \date: February, 2022
* \version: February, 2022
*/

# generate 16-bit code
.code16 			   
# executable code location
.text 				   

.globl _start

# entry point

_start:
    
    movb $0, %bh

    dirty_leitura:
        #bios code to scan from KB
        movb $0x00, %ah

        #BIOS interrupt KB
        int $0x16

        #al <- input

        cmp $'p', %al
        je dirty_print

        movb $0x00, %ah
        push %ax
        inc %bh
        jmp dirty_leitura


    dirty_print:
        movw $0x00, %ax
        pop %ax

        sub $0x30, %ax
        movw %ax, %dx
        mov $0x0a, %ax


        # Zerar o cl
        movb $0x01, %cl

        compara:
            cmp %bh, %cl
            je multiply
        

        #bios code to print
        movb $0x0e, %ah

        #BIOS interrupt screen
        int $0x10
        
        
        movb $0x2f, %al
        
        jmp Print

    multiply:
        mul %dx
        inc %cl
        jmp compara
        


    Print:
        inc %al

        movb $'9', %al

        #bios code to print
        movb $0x0e, %ah

        #BIOS interrupt screen
        int $0x10

        hlt
        jmp Print

        movb %al, %bh

        movb $0x0a, %al

        #bios code to print
        movb $0x0e, %ah

        #BIOS interrupt screen
        int $0x10

        movb $0x08, %al

        #bios code to print
        movb $0x0e, %ah

        #BIOS interrupt screen
        int $0x10

        movb %bh, %al

        cmp %al, %bl
        jne Print






# mov to 510th byte from 0 pos
. = _start + 510	    
    
# MBR boot signature 
.byte 0x55		        
# MBR boot signature 
.byte 0xaa		        



# 1 2 7

# 100
# 20
# 7
