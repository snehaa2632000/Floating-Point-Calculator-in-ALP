  
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
 
include 'emu8086.inc'
 
org 100h

.DATA

msg1 db "FOR THE FIRST OPERAND ",0
msg2 db "FOR THE SECOND OPERAND ",0

msg3 db " ENTER THE MANTISSA: ",0
msg4 db " ENTER THE EXPONENT: ",0

msg5 db " THE SUM IS ",0
msg6 db " THE DIFFERENCE IS ",0
msg7 db " AFTER MULTIPLICATION ",0
msg8 db " AFTER DIVISION ",0


.CODE

mov ax,@DATA
mov dx,ax
mov ds,ax 
   
   
;;FOR THE FIRST OPERAND   

       
;lea si,msg1
;call print_string
printn "FOR THE FIRST OPERAND"
printn " " 


;lea si,msg3
;call print_string
print " ENTER THE MANTISSA: " 

call scan_num
mov [0200h],cx
 
printn " "

;lea si,msg4
;call print_string 
print " ENTER THE EXPONENT: "

call scan_num
mov [0204h],cx
 
;;FOR THE SECOND OPERAND
printn " " 
          
;lea si,msg2
;call print_string 
printn "FOR THE SECOND OPERAND"
printn " "

lea si,msg3
call print_string 

call scan_num
mov [0208h],cx
 
printn " "

lea si,msg4
call print_string 

call scan_num
mov [020ch],cx


mov [0210h],0h
mov [0211h],0h 
mov [0214h],0h
mov [0215h],0h
mov [0220h],0h
mov [0221h],0h
mov [0224h],0h
mov [0225h],0h

mov [0230h],0h
mov [0231h],0h 
mov [0234h],0h
mov [0235h],0h
mov [0230h],0h
mov [0235h],0h
mov [0240h],0h
mov [0241h],0h

mov [0244h],0h
mov [0245h],0h
mov [0270h],0h
mov [0271h],0h
mov [0234h],0h
mov [0235h],0h
mov [0370h],0h
mov [0371h],0h
mov [0334h],0h
mov [0335h],0h 


mov [0214h],0h
mov [0215h],0h
mov [0224h],0h
mov [0225h],0h
mov [0228h],0h
mov [0229h],0h


;;ADDITION

call ADDITION

ADDITION PROC
    
    mov ax,[0204h]
    mov dx,[020ch]
    
    cmp ax,dx
    je lab3
    jb lab2
    jg lab1
    
    
    ;both operands have same exponent

    lab3:
        mov [0270h],ax
        
        mov ax,[0200h]
        mov [0250h],ax
         
        mov ax,[0208h]
        mov [0260h],ax
        
        jmp add1


    ;first operand has higher exponent
    ;shift first operand by the difference of exponent to right
    ;multiply first operand
        
    lab1:
        
        mov [0270h],dx
    
        mov cx,[0204h]
        mov bx,[020ch]
        sub cx,bx
    
        mov ax,[0200h]
        mov bx,0ah
    
        mul1:
            mul bx
            loop mul1
        
        mov [0250h],ax
        mov ax,[0208h]
        mov [0260h],ax
    
        jmp add1    
    
    ;first operand has lesser exponent
    ;shift second operand by the difference of exponent to right
    ;multiply second operand
    
    lab2:             
        mov [0270h],ax
    
        mov cx,[020ch]
        mov bx,[0204h]
        sub cx,bx
    
        mov ax,[0208h]
        mov bx,0ah
    
        mul2:
            mul bx
            loop mul2
        
        mov [0250h],ax 
        mov ax,[0200h]
        mov [0260h],ax
    
        jmp add1
        

    add1:
        mov ax,[0250h]
        mov bx,[0260h]
        add ax,bx
        mov [0230h],ax
        
        mov ax,[0270h]
        mov [0234h],ax
            
    
    endp ADDITION


;MANTISSA OF RESULT IS STORED AT 0230
;EXPONENT OF RESULT IS STORED AT 0234  


;;SUBTRACTION

call SUBTRACTION

SUBTRACTION PROC
    mov ax,[0204h]
    mov dx,[020ch]
    
    cmp ax,dx
    je lab4
    jb lab6
    jg lab5
    
    ;both operands have same exponents 
    
    lab4:
        mov [0370h],ax
        
        mov ax,[0200h]
        mov [0350h],ax
         
        mov ax,[0208h]
        mov [0360h],ax
        
        jmp sub1
        
    
    ;first operand has higher exponent
    ;shift first operand by the difference of exponent to right
    ;multiply first operand
    
        
    lab5:
        
        mov [0370h],dx
    
        mov cx,[0204h]
        mov bx,[020ch]
        sub cx,bx
    
        mov ax,[0200h]
        mov bx,0ah
    
        mul3:
            mul bx
            loop mul3
        
        mov [0350h],ax
        mov ax,[0208h]
        mov [0360h],ax
    
        jmp sub1    
    
    ;first operand has lesser exponent
    ;shift second operand by the difference of exponent to right
    ;multiply second operand
    
    lab6:             
        mov [0270h],ax
    
        mov cx,[020ch]
        mov bx,[0204h]
        sub cx,bx
    
        mov ax,[0208h]
        mov bx,0ah
    
        mul4:
            mul bx
            loop mul4
        
        mov [0350h],ax 
        mov ax,[0200h]
        mov [0360h],ax
    
        jmp sub2
        
    ;WHEN FIRST OPERAND IS GREATER
    sub1:
        mov ax,[0350h]
        mov bx,[0360h]
        
        sub ax,bx
        mov [0330h], ax
        
        mov ax,[0270h]
        mov [0334h],ax
        
        jmp endSub
        
    ;WHEN SECOND OPERAND IS GREATER
    sub2:
        mov bx,[0350h]
        mov ax,[0360h]
        
        sub ax,bx
        mov [0330h], ax
        
        mov ax,[0270h]
        mov [0334h],ax
            

    endp SUBTRACTION


;MANTISSA OF RESULT IS STORED AT 0330
;EXPONENT OF RESULT IS STORED AT 0334  


endSub:

;;MULTIPLICATION
 
call MULTIPLY 
 
  
MULTIPLY PROC
    mov ax,[0200h]
    mov bx,[0208h]
    mul bx
    mov [0210h],ax
    
    mov ax,[0204h]
    mov bx,[020ch]
    add ax,bx
    mov [0214h],ax
    
    endp MULTIPLY  
  
;MANTISSA OF RESULT IS STORED AT 0210
;EXPONENT OF RESULT IS STORED AT 0214  


;;DIVISION  

call DIVISION
 
DIVISION PROC
    mov ax,[0200h]
    mov bx,[0208h]
    div bx
    mov [0220h],ax
    mov [0228h],dx
    
    mov ax,[0204h]
    mov bx,[020ch]
    sub ax,bx      
    mov [0224h],ax
    
    endp DIVISION  
  
;MANTISSA OF RESULT IS STORED AT 0220
;EXPONENT OF RESULT IS STORED AT 0224   
;REMAINDER OF RESULT IS STORED AT 0228 


;;To print data stored in the memory


;;To print the sum

printn " " 
printn "-----------------------------"
printn " THE SUM"
print "  THE MANTISSA OF THE SUM: "
mov ax,[0230h]
call print_num

printn " "

print "  THE EXPONENT OF THE SUM: "
mov ax,[0234h]
call print_num

printn " "
printn "------------------------------"

;;To print the difference 


printn "  THE DIFFERENCE"               
print "  THE MANTISSA OF THE DIFFERENCE: "
mov ax,[0330h]
call print_num

printn " "

print "  THE EXPONENT OF THE DIFFERENCE: "
mov ax,[0334h]
call print_num

printn " "
printn "------------------------------"

;;To print the product


printn "  THE PRODUCT"               
print "  THE MANTISSA OF THE PRODUCT: "
mov ax,[0210h]
call print_num

printn " "

print "  THE EXPONENT OF THE PRODUCT: "
mov ax,[0214h]
call print_num

printn " "
printn "-----------------------------"

;;To print the quotient and remainder


printn "  THE QUOTIENT AND REMAINDER"               
print "  THE MANTISSA OF THE QUOTIENT: "
mov ax,[0220h]
call print_num

printn " "

print "  THE EXPONENT OF THE QUOTIENT: "
mov ax,[0224h]
call print_num

printn " "

print "  THE REMAINDER: "
mov ax,[0228h]
call print_num

printn " "
printn "----------------------------" 
  
mov ah,04ch
int 21h

ret

define_scan_num
define_print_num
define_print_num_uns
define_get_string
define_print_string

end
