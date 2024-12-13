.model small

.data
msg1 db 0dh,0ah," Welcome to our simple Drawing Program.$"
msg2 db 0dh,0ah," 1-Free Drawing $"
msg3 db 0dh,0ah," 2-Square $"
msg4 db 0dh,0ah," 3-Rectangle $"
msg5 db 0dh,0ah," 4-Triangle $"
msg6 db 0dh,0ah," 5-Cube $"
msgex db 0dh,0ah," 6-Exit $"
nl db 0dh,0ah," $"
msg db 0dh,0ah," Goodbye....     $"
color_prompt db "Press a number to select a color: ", 0Dh, 0Ah
             db "1=Red, 2=Green, 3=Blue , 4=Yellow", 0Dh, 0Ah
             db "5=Magenta, 6=Cyan, 7=Brown, 8=Pink$", 0
oldX dw -1
oldY dw -1
selected_color db 0
 
.code
main proc far
mov ax , @data
mov ds , ax

Main_Menu:

lea dx ,msg1
mov ah,9
int 21h

lea dx ,msg2
mov ah,9
int 21h

lea dx ,msg3
mov ah,9
int 21h

lea dx ,msg4
mov ah,9
int 21h

lea dx ,msg5
mov ah,9
int 21h 

lea dx ,msg6
mov ah,9
int 21h

lea dx ,msgex
mov ah,9
int 21h

lea dx ,nl
mov ah,9
int 21h

mov ah, 1
int 21h

cmp al, '1'
je Free_Drawing_choose

cmp al, '2'
je Square_choose

cmp al, '3'
je Rectangle_choose

cmp al, '4'
je Triangle_choose

cmp al,'5'
je Cube_choose

cmp al, '6'
je Exit_choose

jmp Main_Menu

Free_Drawing_choose:
call Free_Drawing

Square_choose:
call Square

Rectangle_choose:
call Rectangle

Triangle_choose:
call Triangle

Cube_choose:
call Cube

Exit_choose:
call Exit
          
main endp

Free_Drawing proc near
    mov ah, 0
    mov al, 13h       
    int 10h

    
    mov ax, 0         
    int 33h

    
    mov dx, offset color_prompt
    call display_message

    
    mov byte ptr [selected_color], 0

check_mouse_button:
    mov ah, 1          
    int 16h
    jz no_key_press    

    
    mov ah, 0
    int 16h
    cmp al, '1'    
    mov [selected_color], 4  ;Red
    je check_mouse_button
    cmp al, '2'        
    mov [selected_color], 2  ;Green
    je check_mouse_button
    cmp al, '3'       
    mov [selected_color], 1  ;Blue
    je check_mouse_button
    cmp al, '4'        
    mov [selected_color], 14 ;Yellow
    je check_mouse_button
    cmp al, '5'
    mov [selected_color], 5 ;Magenta
    je check_mouse_button
    cmp al, '6'        
    mov [selected_color], 3 ;Cyan
    je check_mouse_button
    cmp al, '7'        
    mov [selected_color], 6  ;Brown
    je check_mouse_button
    cmp al, '8'        
    mov [selected_color], 13 ;Pink
    je check_mouse_button
    cmp al, 27         ; Esc key
    je stop

no_key_press:

    mov ax, 3          
    int 33h
    
    shr cx, 1          

    cmp bx, 1          
    jne xor_cursor

    
    mov al, [selected_color]   
    jmp draw_pixel

xor_cursor:
    cmp oldX, -1
    je not_required
    push cx
    push dx
    mov cx, oldX
    mov dx, oldY
    mov ah, 0Dh       
    int 10h
    xor al, 1111b     
    mov ah, 0Ch       
    int 10h
    pop dx
    pop cx

not_required:
    mov ah, 0Dh      
    int 10h
    xor al, 1111b     
    mov oldX, cx
    mov oldY, dx

draw_pixel:
    mov ah, 0Ch       
    int 10h

    jmp check_mouse_button
    
stop:
    mov ax, 3         
    int 10h
    jmp Main_Menu

display_message:
    mov ah, 09h
    int 21h
    ret
    
Free_Drawing endp
;-----------------------------------------------------------------------------------;
Square proc near

STARTDRAWING:
    mov ah, 0        
    mov al, 13h
    int 10h
    
    MOV AH,0CH  
    MOV AL,2    
    MOV CX,110  
    MOV DX,50   
    INT 10H    
           

    MOV BL,100  
TOPLINE:
    INT 10H
    INC CX
    DEC BL
    JNZ TOPLINE  
     
     
    MOV BL,100   
RIGHTLINE:
    INT 10H
    INC DX
    DEC BL
    JNZ RIGHTLINE  
      
      
    MOV BL,100  
BOTLINE:
    INT 10H
    DEC CX
    DEC BL
    JNZ BOTLINE
     

    MOV BL,100   
LEFTLINE:
    INT 10H
    DEC DX
    DEC BL
    JNZ LEFTLINE 
Finish_square:

check_esc_key_square:
   
    mov ah, 6
    mov dl, 255
    int 21h
    cmp al, 27        ; Esc key
    je stop_square
    jmp Finish_square
    
stop_square:
  
    mov ax, 3                   ; Set video mode to 80x25 text
    int 10h
    jmp Main_Menu               

Square endp
;-----------------------------------------------------------------------------------;
Rectangle proc near

STARTDRAWING2:
    mov ah, 0        
    mov al, 13h
    int 10h 
       
    MOV AH,0CH  
    MOV AL,2    
    MOV CX,85   
    MOV DX,60   
    INT 10H    
       

    MOV BL,150   
TOPLINE2:
    INT 10H
    INC CX
    DEC BL
    JNZ TOPLINE2  
 
 
    MOV BL,75   
RIGHTLINE2:
    INT 10H
    INC DX
    DEC BL
    JNZ RIGHTLINE2  
  
  
    MOV BL,150   
BOTLINE2:
    INT 10H
    DEC CX
    DEC BL
    JNZ BOTLINE2
 

    MOV BL,75   
LEFTLINE2:
    INT 10H
    DEC DX
    DEC BL
    JNZ LEFTLINE2
Finish_Rectangle:

check_esc_key_Rectangle:
    
    mov ah, 6
    mov dl, 255
    int 21h
    cmp al, 27        
    je stop_Rectangle
    jmp Finish_Rectangle
    
stop_Rectangle:
    
    mov ax, 3         
    int 10h
    jmp Main_Menu                
  
Rectangle endp
;-----------------------------------------------------------------------------------;
Triangle proc near

STARTDRAWING3:
    
    mov ah, 0
    mov al, 13h
    int 10h

    
    mov cx, 90       
    mov dx, 120      

    
    mov ah, 0Ch     
    mov al, 2 
    
    mov bl, 130      
BASELINE3:
    int 10h
    inc cx           
    dec bl
    jnz BASELINE3

    
    mov cx, 220       
    mov dx, 120      
    mov bl, 66       
LEFTSIDE3:
    int 10h
    dec cx           
    dec dx           
    dec bl
    jnz LEFTSIDE3

    
    mov cx, 90      
    mov dx, 120      
    mov bl, 66      
RIGHTSIDE3:
    int 10h
    inc cx           
    dec dx           
    dec bl
    jnz RIGHTSIDE3
Finish_Triangle:

check_esc_key_Triangle:
    
    mov ah, 6
    mov dl, 255
    int 21h
    cmp al, 27        
    je stop_Triangle
    jmp Finish_Triangle
    
stop_Triangle:
    
    mov ax, 3         
    int 10h
    jmp Main_Menu                
  
Triangle endp
;-----------------------------------------------------------------------------------;
 Cube Proc Near
  ;----------------------Outer Squre --------------------------    
    mov ah, 0        
    mov al, 13h
    int 10h
        
    MOV AH,0CH  
    MOV AL,2   
    MOV CX,110   
    MOV DX,50   
    INT 10H    
           

     MOV BL,70   
     TOP:
      INT 10H
      INC CX
      DEC BL
      JNZ TOP 
     
     
     MOV BL,70   
     RIGHT:
      INT 10H
      INC DX
      DEC BL
      JNZ RIGHT 
      
      
     MOV BL,70  
     BOT:
      INT 10H
      DEC CX
      DEC BL
      JNZ BOT
     

     MOV BL,70   
     LEFT:
      INT 10H
      DEC DX
      DEC BL
      JNZ LEFT
      
    ;Stop       
    cmp cx,140
    je Slanted_lines  
         
     ;----------------------------Inner Squar---------------------------------
     
     MOV AL,2   
     MOV CX,140   
     MOV DX,80   
     INT 10H    
           
     MOV BL,70   
     jmp TOP 
     
     ;---------------------------Slanted lines--------------------------------
     
     
Slanted_lines:
    MOV AH,0CH  
    MOV AL,2   

    ; Top-left
    MOV CX,110   
    MOV DX,50   
    MOV BL,30   
    TOPLEFT4:
      INT 10H
      INC CX
      INC DX
      DEC BL
      JNZ TOPLEFT4

    ; Top-righ
    MOV CX,180   
    MOV DX,50   
    MOV BL,30   
    TOPRIGHT4:
      INT 10H
      INC CX
      INC DX
      DEC BL
      JNZ TOPRIGHT4

    ; Bottom-left
    MOV CX,110 
    MOV DX,120 
    MOV BL,30  
    BOTTOMLEFT4:
      INT 10H
      INC CX
      INC DX
      DEC BL
      jnz BOTTOMLEFT4

    ; Bottom-right
    MOV CX,180  
    MOV DX,120  
    MOV BL,30   
    BOTTOMRIGHT4:
      INT 10H
      INC CX
      INC DX
      DEC BL
      JNZ BOTTOMRIGHT4
 
Finish_Cube:

check_esc_key_Cube:
    mov ah, 6
    mov dl, 255
    int 21h
    cmp al, 27        
    je stop_Cube
    jmp Finish_Cube
    
stop_Cube:
    
    mov ax, 3                   
    int 10h
    jmp Main_Menu 
    
 Cube EndP
;-----------------------------------------------------------------------------------;
Exit proc near

mov ax, 3  
int 10h

mov ah, 1  ; show box-shaped blinking text cursor:
mov ch, 0
mov cl, 8
int 10h

Lea dx, msg
mov ah, 9
int 21h

mov ah, 0
int 16h

mov ah, 4Ch
int 21h

Exit endp

end main
