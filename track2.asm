.286
.model small
.stack 64
.data    
lastDirection dw 1 ;;;;0 UP 1 DOWN 2 Right 3 Left
x1 dw 0
x2 dw 0

y1 dw 0
y2 dw 0
row dw 150 ;;;;; akher heta fl track mn taht b3do inline chat
lengthT dw 35
widthT dw 35 ;;; width el track
carwidth dw 1 ;;; width el car
temporaryLength dw 1 ;;; length el track el available
temporaryLength2 dw 1 ;;; length el track el available mn point2
dontDraw dw 0 ;;; boolean hytl3 ml checker functions
drawn dw 1
x dw 0
y dw 0
lengthD dw 32  
k                   equ         320         
pixel_size          equ          10
pos_box1            dw          ?
pos_box2            dw          ?
color_track         db          3
KeyList db 128 dup (0)
last_mov_c1 db  1 ; 0 : up , 1: down, 2: right, 3: left
last_mov_c2 db 1

redcar DB 4, 4, 135, 162, 22, 22, 158, 160, 4, 4, 4, 111, 135, 160, 21, 21, 160, 135, 136, 4, 208, 207, 231, 229, 229, 229, 229, 231, 207, 208, 208, 208, 207, 207, 19, 19, 209, 207, 207, 207
 DB 208, 208, 208, 208, 232, 232, 208, 208, 208, 208, 111, 111, 111, 136, 161, 159, 136, 111, 111, 111, 4, 4, 136, 12, 26, 26, 12, 136, 4, 4, 113, 4, 12, 64, 87, 87, 64, 12, 4, 111
 DB 208, 136, 12, 64, 87, 87, 64, 12, 136, 208, 208, 232, 136, 12, 88, 88, 64, 135, 136, 207, 208, 209, 136, 160, 24, 24, 160, 136, 232, 207, 208, 207, 136, 160, 23, 23, 160, 136, 207, 207
 DB 111, 136, 135, 159, 22, 22, 159, 135, 136, 111, 111, 136, 160, 22, 23, 23, 22, 160, 136, 111, 4, 4, 160, 23, 25, 25, 24, 159, 136, 4, 4, 4, 12, 64, 26, 27, 64, 12, 4, 4
 DB 4, 4, 12, 64, 88, 88, 64, 12, 4, 4, 4, 4, 12, 12, 63, 63, 12, 12, 4, 4, 4, 40, 12, 12, 12, 12, 12, 39, 4, 4, 40, 40, 39, 12, 39, 39, 39, 39, 40, 40
 DB 4, 4, 4, 39, 40, 40, 40, 40, 40, 40, 4, 4, 4, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 
bluecar DB 25, 28, 28, 56, 9, 9, 56, 28, 28, 23, 24, 28, 27, 24, 9, 9, 24, 27, 28, 24, 24, 26, 17, 18, 18, 18, 18, 17, 26, 25, 24, 24, 18, 18, 18, 18, 18, 18, 26, 25
 DB 25, 23, 18, 18, 18, 18, 18, 18, 25, 26, 26, 21, 18, 18, 18, 17, 18, 18, 24, 26, 26, 21, 24, 175, 128, 128, 175, 23, 24, 26, 25, 23, 28, 56, 9, 9, 56, 28, 25, 26
 DB 25, 227, 28, 56, 9, 9, 56, 28, 21, 25, 25, 18, 29, 56, 9, 9, 56, 29, 18, 25, 25, 18, 28, 79, 9, 9, 56, 28, 18, 26, 25, 18, 28, 56, 9, 9, 56, 28, 18, 26
 DB 25, 224, 28, 24, 9, 9, 56, 28, 22, 26, 25, 25, 16, 16, 16, 16, 16, 16, 22, 26, 19, 16, 18, 16, 16, 16, 16, 16, 16, 19, 25, 16, 16, 16, 16, 16, 16, 16, 16, 25
 DB 26, 20, 20, 20, 20, 20, 20, 20, 20, 25, 26, 28, 28, 27, 26, 26, 27, 28, 28, 26, 26, 28, 28, 56, 9, 9, 56, 28, 28, 25, 27, 28, 28, 56, 9, 9, 56, 28, 28, 26
 DB 27, 28, 27, 56, 9, 9, 56, 28, 28, 27, 24, 28, 26, 56, 9, 9, 56, 26, 28, 26, 26, 28, 28, 56, 9, 9, 56, 28, 28, 26, 27, 28, 28, 56, 9, 9, 56, 28, 28, 27
 DB 16, 28, 27, 23, 9, 9, 23, 27, 28, 16
old_int_seg dw ?
old_int_offset dw ?
color_path  db 8
delay    dw 15520  ;HOW MANY SECONDS TO WAIT.
fill             dw 0
skipFill         db 0
addFill          dw 0
.code   


main proc far
        mov ax, @data
        mov ds, ax
        ;;;;; graphics mode
        mov ah, 0
        mov al, 13h
        int 10h
        ;;;;; graphics mode
        
        ;;;; extra segment set

        
        mov ax, 0A000h
        mov es, ax
        ;;;; extra segment set
        
        call cs:drawTrack
        mov pos_box1, 321
        mov pos_box2, 333
    
        call set_interrupt
        
        call initialize_cars
        ;;;;;;;;;;;;;;play
         
        call play
        
        call ret_interrupt
        hlt
        ret
main endp

; ------------------------- Draw Cars ----------------------------------------- ;
set_interrupt proc
            
            push ax
            push es
            push bx
            mov ax, 3509h ; Get Interrupt Vector
            int  21h ; -> ES:BX
            mov old_int_offset, bx
            mov old_int_seg, es
            pop bx
            pop es
            cli
        ; replace the existing int09h handler with ours
            push DS
            mov dx, offset myint ; new offset 
            mov ax, seg myint ; new segment
            mov ds, ax 
            mov ax, 2509h
            int 21h
            pop ds  
            pop ax
            sti
            ret
set_interrupt endp
;-----------------------------------------------------;
ret_interrupt proc
              push ax
              push ds
              push dx
              mov ds,old_int_seg
              mov dx,old_int_offset
              mov ax, 2509h
              int 21h
              pop dx
              pop ds
              pop ax
              ret
ret_interrupt endp
; ------------------ MY Own handler ------------------;
myint proc          ;  my keyboard interrupt handler 
    push bx
    in   al, 60h
    mov  ah, 0
    mov  bx, ax
    and  bx, 127           ; 7-bit scancode goes to BX
    shl  ax, 1             ; 1-bit pressed/released goes to AH
    xor  ah, 1             ; -> AH=1 Pressed, AH=0 Released
    mov  [KeyList + bx], ah
    mov  al, 20h           ; The non specific EOI (End Of Interrupt)
    out  20h, al
    pop  bx 
    iret
myint endp
; ----------------------- Initialize Car components --------------------------- ;
initialize_cars proc
                mov di,pos_box1
                mov si,offset redcar
                call draw_c
                mov di,pos_box2
                mov si,offset bluecar
                call draw_c
                ret
initialize_cars endp
; ------------------------------------------------------------------------------;
draw_c            proc
                push di
                pusha  ; for safety
                mov bl,pixel_size ; loop pixel size times
                my_draw_c:  mov cx,pixel_size ; for stosb 
                        rep movsb  ; draw horizontal line
                        sub di,pixel_size ; return to original position
                        add di,k ; new row
                        dec bl ; loop pixel size times
                        jnz my_draw_c
                popa
                pop di
                ret  
draw_c            endp
; ------------------------------- ;
rotate_left     proc
                pusha
                add di, pixel_size - 1
                mov bl,pixel_size
                mov cl,pixel_size
                outer:
                        mov bl,pixel_size
                        inner:
                                movsb 
                                dec di
                                add di,k
                                dec bl
                                jnz inner
                        
                        
                        dec di
                        sub di,k*(pixel_size)
                        dec cl
                        jnz outer
                popa
                ret
rotate_left     endp            
; ------------------------------- ;
; ------------------------------- ;
rotate_right    proc
                pusha
                add di, k * (pixel_size - 1)
                mov bl,pixel_size
                mov cl,pixel_size
                outer_r:
                        mov bl,pixel_size
                        inner_r:
                                movsb 
                                dec di
                                sub di,k
                                dec bl
                                jnz inner_r
                        
                        
                        inc di
                        add di,k*(pixel_size)
                        dec cl
                        jnz outer_r
                popa
                ret
rotate_right    endp            
; ------------------------------- ;
; - no rotate up just draw car --;
; ------------------------------- ;
rotate_up       proc
                pusha
                add di, (pixel_size - 1)*(k)
                mov bl,pixel_size
                mov cl,pixel_size
                outer_d:
                        mov bl,pixel_size
                        inner_d:
                                movsb 
                                dec bl
                                jnz inner_d
                        
                        
                        sub di,pixel_size
                        sub di,k
                        dec cl
                        jnz outer_d
                popa
                ret
rotate_up       endp            
; ------------------------------- ;
draw_l           proc
        ; ---- store changed vars ------------ ;
                push cx 
                push ax
                push di
                mov cx,pixel_size ; for stosb
                rep movsb
        ; --- return to the original positions -- ;
                pop di
                pop ax
                pop cx
                ret  
draw_l            endp
; ----------------------------------------- ;
; ------------- draw vertical -------------- ;
draw_v          proc 
                push di
                push cx  
                mov cx,pixel_size
                draw_it:
                        stosb
                        dec di
                        add di,k  
                        dec cx
                        jnz draw_it
                pop cx
                pop di  
                ret
draw_v          endp
; --------------------------------------------- ;

; - --------------------Move the second box---------------------------- ;
move_b2            proc
            ; --- push vlues that will be updated -- ;
                push di
                push ax
                push cx
                mov di,pos_box2
                ; ----- Move box 2--------- ;

                move_box2: 
                        push di ; store original value
                        cmp [KeyList + 11h],1 ; up key
                        jnz temp_down2
                ; ------- checks first  --------------;
                    ; ----- first check "track check top right corner"------;
                    push si ; save its value
                    mov si,offset color_track ; color track set
                    sub di,k ; row - 1
                    cmpsb  ; compare previous row with color
                    jnz sec_check_up2 ; ok clear
                    pop si ; no out 
                    jmp terminate2
                    ; ----- second check -----;
                    sec_check_up2: ; check track on the other corner
                    add di,pixel_size - 2 ; adjust position
                    dec si
                    cmpsb 
                    jnz third_check_up2 ; ok clear
                    pop si ; no out
                    jmp terminate2
                    temp_down2: ; because the above down2 is out of range
                    jmp down2
                    ; ----- third check ------;
                    third_check_up2:
                    mov si, pos_box1
                    mov di,pos_box2
                    sub di,k
                    add si,k*(pixel_size - 1)
                    add si,pixel_size - 1
                    cmp di,si
                    ja all_good_up2
                    ; ----- fourth check -----;
                    fourth_check_up2:
                    mov di,pos_box2
                    mov si,pos_box1
                    add si,k*(pixel_size - 1)
                    sub di,k
                    add di,pixel_size - 1
                    cmp di,si
                    jb all_good_up2
                    pop si
                    jmp terminate2
                    ; ------------------------- ;
                    all_good_up2:
                        pop si
                        mov di, pos_box2
                        cmp last_mov_c2, 0
                        jz escape_up2

                        mov si,offset bluecar ; red car
                        mov di, pos_box2 ; copy to position
                        call rotate_up ; rotate the car
                        mov last_mov_c2,0 ; update last move
                        jmp terminate2

                        escape_up2:
                        mov last_mov_c2 , 0

                        removelast2:  
                                    add di, k*(pixel_size - 1) ; go to last row
                                    mov al,color_path ; "MAY BE CHANGED BASED ON BACKGROUND COLOR."
                                    mov cx,pixel_size ; 8 times size of row
                                    rep stosb
                                    
                        pop di
                        sub di,k   ; new  start position
                        push di ; save new start position
                        mov si,offset bluecar
                        call rotate_up ; draw line at the beginning as if move up
                        pop di ; set new value of di
                        mov pos_box2,di
                        jmp endmove2
            ; ---------- LET'S MOVE DOWN ------------------ ;
                        down2: 
                        cmp [KeyList + 1Fh],1 ; down key
                        jnz temp_right2

                        ; ------- checks first  --------------;
                    ; ----- first check "track check top right corner"------;
                    push si ; save its value
                    mov si,offset color_track ; color track set
                    add di,k*pixel_size ; row + 1
                    cmpsb  ; compare following row with color
                    jnz sec_check_down2 ; ok clear
                    pop si ; no out 
                    jmp terminate2
                    ; ----- second check -----;
                    sec_check_down2: ; check track on the other corner
                    add di,pixel_size - 2 ; adjust position
                    dec si
                    cmpsb 
                    jnz third_check_down2 ; ok clear
                    pop si ; no out
                    jmp terminate2
                    temp_right2: ; because the above down2 is out of range
                    jmp right2
                    ; ----- third check ------;
                    third_check_down2:
                    mov si, pos_box1
                    mov di,pos_box2
                    add di,k*pixel_size
                    add si,pixel_size - 1
                    cmp di,si
                    ja all_good_down2
                    ; ----- fourth check -----;
                    fourth_check_down2:
                    mov di,pos_box2
                    mov si,pos_box1
                    add di,k*(pixel_size)
                    add di,pixel_size - 1
                    cmp di,si
                    jb all_good_down2
                    pop si
                    jmp terminate2
                    ; ------------------------- ;
                    all_good_down2:
                        pop si
                        mov di, pos_box2

                        cmp last_mov_c2, 1
                        jz escape_down2 ; complete normally

                        mov si,offset bluecar ; red car
                        mov di, pos_box2 ; copy to position
                        call draw_c ; flip the car
                        mov last_mov_c2,1 ; update last move
                        jmp terminate2

                        escape_down2:
                        mov last_mov_c2 , 1

                        removefirst2:  
                                    mov al,color_path ; "TO BE REPLACED BY THE BACKGROUND COLOR"
                                    mov cx,pixel_size
                                    rep stosb
                                    
                        pop di 
                        add di,k ; set the new pos
                        push di 
                        mov si,offset bluecar
                        call draw_c ; draw horizontal line at the end
                        pop di
                        mov pos_box2,di ; set the new position 
                        jmp endmove2
                ;---------------- LETS MOVE RIGHT   --- ;
                        right2: 
                        cmp [KeyList + 20h],1 ; right key
                        jnz temp_left2
                ; ---- Track colors check ------------;
                    mov di,pos_box2
                    add di,pixel_size
                    mov si,offset color_track
                    cmpsb 
                    jz temp_again2
                    dec di
                    add di,(pixel_size - 1)*k
                    dec si
                    cmpsb
                    jz temp_again2
                ; -------------------------------------- ;
                ; ------------first car check--------------------- ;
                    mov di,pos_box2
                    mov si,pos_box1
                    add di,pixel_size
                    cmp di,si
                    ja fourth_check_r2
                    sub si,di
                    mov ax,si
                    mov dx,0
                    mov cx,k
                    div cx
                    cmp dx,0 ; there is no remainder meaning on the same vertcal line
                    jne all_good_right2
                    cmp ax,pixel_size
                    ja  all_good_right2
                    jmp terminate2
                    temp_left2: jmp left2
                    temp_again2: jmp terminate2 ; "TEMP AGAAIINNN"
                    fourth_check_r2:
                    sub di,si
                    mov ax,di
                    mov dx,0
                    mov cx,k
                    div cx
                    cmp dx,0 ; there is no remainder meaning on the same vertcal line
                    jne all_good_right2
                    cmp ax,pixel_size ; not on the same horizontal line
                    ja  all_good_right2
                    jmp terminate2
                    ;---- END of checks --------;  
                    all_good_right2:
                        mov di, pos_box2

                        cmp last_mov_c2,2 ; if it is the last move don't rotate
                        jz escape_rotr2 ; don't rotate gain
                        mov si,offset bluecar ; red car
                        mov di, pos_box2 ; copy to position
                        call rotate_right ; rotate the car
                        mov last_mov_c2,2 ; update last move
                        jmp terminate2
                        escape_rotr2:

                        mov last_mov_c2 , 2

                        mov cx,pixel_size
                        removeleft2:   ; remove the line on the left
                                    mov al,color_path
                                    stosb
                                    dec di
                                    add di,k
                                    dec cx
                                    jnz removeleft2
                                    
                        pop di 
                        inc di 
                        push di 
                        mov si,offset bluecar
                        call rotate_right
                        pop di
                        mov pos_box2,di
                        jmp endmove2
                        tempppp2: jmp terminate2
                     ; --- left --- ;
                        left2: 
                        cmp [KeyList + 1Eh],1 ; ;eft key
                        jnz tempppp2
                ; ---- Track colors check ------------;
                    mov di,pos_box2
                    dec di
                    mov si,offset color_track
                    cmpsb 
                    jz tempppp2
                    dec di
                    add di,(pixel_size - 1)*k
                    dec si
                    cmpsb
                    jz tempppp2
                ; -------------------------------------- ;
                ; -------------------------------------- ;
                    mov di,pos_box1
                    mov si,pos_box2
                    add di,pixel_size
                    cmp di,si
                    ja fourth_check_l2
                    sub si,di
                    mov ax,si
                    mov dx,0
                    mov cx,k
                    div cx
                    cmp dx,0 ; there is no remainder meaning on the same vertcal line
                    jne all_good_left2
                    cmp ax,pixel_size
                    ja  all_good_left2
                    jmp terminate2
                    fourth_check_l2:
                    sub di,si
                    mov ax,di
                    mov dx,0
                    mov cx,k
                    div cx
                    cmp dx,0 ; there is no remainder meaning on the same vertcal line
                    jne all_good_left2
                    cmp ax,pixel_size ; not on the same horizontal line
                    ja  all_good_left2
                    jmp terminate2
                ; -------------------------------------- ;
                    all_good_left2:
                        mov di, pos_box2

                        cmp last_mov_c2,3 ; if it is the last move don't rotate
                        jz escape_rotl2 ; don't rotate gain
                        mov si,offset bluecar ; red car
                        mov di, pos_box2 ; copy to position
                        call rotate_left ; rotate the car
                        mov last_mov_c2,3 ; update last move
                        jmp terminate2
                        escape_rotl2:
                        mov last_mov_c2 , 3

                        mov cx,pixel_size 
                        add di,pixel_size - 1
                        removeright2:  
                                    mov al,color_path
                                    stosb
                                    dec di
                                    add di,k
                                    dec cx
                                    jnz removeright2
                                    
                        pop di 
                        dec di 
                        push di
                        mov si,offset bluecar
                        call rotate_left
                        pop di
                        mov pos_box2,di
                        jmp endmove2
                    terminate2:
                        pop di
                    endmove2:
                        pop cx
                        pop ax
                        pop di
                ret
move_b2             endp
; --------------------------------------------- ;
move_b1            proc
                pusha
                ; ----- Move box --------- ;
                
                move_box: 
                        push di ; store original value
                        cmp [KeyList + 48h] ,1
                    
                        jnz temp_down1
                    ; ------- checks first  --------------;
                    ; ----- first check "track check top right corner"------;
                    push si ; save its value
                    mov si,offset color_track ; color track set
                    sub di,k ; row - 1
                    cmpsb  ; compare previous row with color
                    jnz sec_check_up1 ; ok clear
                    pop si ; no out 
                    jmp terminate1
                    ; ----- second check -----;
                    sec_check_up1: ; check track on the other corner
                    add di,pixel_size - 2 ; adjust position
                    dec si
                    cmpsb 
                    jnz third_check_up1 ; ok clear
                    pop si ; no out
                    jmp terminate1
                    temp_down1: ; because the above down2 is out of range
                    jmp down
                    ; ----- third check ------;
                    third_check_up1:
                    mov si, pos_box2
                    mov di,pos_box1
                    sub di,k
                    add si,k*(pixel_size - 1)
                    add si,pixel_size - 1
                    cmp di,si
                    ja all_good_up1
                    ; ----- fourth check -----;
                    fourth_check_up1:
                    mov di,pos_box1
                    mov si,pos_box2
                    add si,k*(pixel_size - 1)
                    sub di,k
                    add di,pixel_size - 1
                    cmp di,si
                    jb all_good_up1
                    pop si
                    jmp terminate1
                    ; ------------------------- ;
                    all_good_up1:
                        pop si
                        mov di, pos_box1
                        cmp last_mov_c1, 0
                        jz escape_up1

                        mov si,offset redcar ; red car
                        mov di, pos_box1 ; copy to position
                        call rotate_up ; rotate the car
                        mov last_mov_c1,0 ; update last move
                        jmp terminate1

                        escape_up1:
                        mov last_mov_c1 , 0
                        removelast:  
                                    add di, k*(pixel_size - 1) ; go to last row
                                    mov al,color_path ; "MAY BE CHANGED BASED ON BACKGROUND COLOR."
                                    mov cx,pixel_size ; 8 times size of row
                                    rep stosb
                                    
                        pop di
                        sub di,k   ; new  start position
                        push di ; save new start position
                        mov si,offset redcar
                        call rotate_up ; draw line at the beginning as if move up
                        pop di ; set new value of di
                        mov pos_box1,di
                        jmp endmove


                        down: 
                        cmp [KeyList + 50h] ,1
                        jnz temp_right1
                         ; ------- checks first  --------------;
                    ; ----- first check "track check top right corner"------;
                    push si ; save its value
                    mov si,offset color_track ; color track set
                    add di,k*pixel_size ; row - 1
                    cmpsb  ; compare following row with color
                    jnz sec_check_down1 ; ok clear
                    pop si ; no out 
                    jmp terminate1
                    ; ----- second check -----;
                    sec_check_down1: ; check track on the other corner
                    add di,pixel_size - 2 ; adjust position
                    dec si
                    cmpsb 
                    jnz third_check_down1 ; ok clear
                    pop si ; no out
                    jmp terminate1
                    temp_right1: ; because the above down2 is out of range
                    jmp right
                    ; ----- third check ------;
                    third_check_down1:
                    mov si, pos_box2
                    mov di,pos_box1
                    add di,k*pixel_size
                    add si,pixel_size - 1
                    cmp di,si
                    ja all_good_down1
                    ; ----- fourth check -----;
                    fourth_check_down1:
                    mov di,pos_box1
                    mov si,pos_box2
                    add di,k*(pixel_size)
                    add di,pixel_size - 1
                    cmp di,si
                    jb all_good_down1
                    pop si
                    jmp terminate1
                    ; ------------------------- ;
                    all_good_down1:
                        pop si
                        mov di, pos_box1
                        
                        cmp last_mov_c1, 1
                        jz escape_down1 ; complete normally

                        mov si,offset redcar ; red car
                        mov di, pos_box1 ; copy to position
                        call draw_c ; flip the car
                        mov last_mov_c1,1 ; update last move
                        jmp terminate1

                        escape_down1:
                        mov last_mov_c1 , 1
                        removefirst:  
                                    mov al,color_path ; "TO BE REPLACED BY THE BACKGROUND COLOR"
                                    mov cx,pixel_size
                                    rep stosb
                                    
                        pop di 
                        add di,k ; set the new pos
                        push di 
                        mov si,offset redcar
                        call draw_c ; draw horizontal line at the end
                        pop di
                        mov pos_box1,di ; set the new position 
                        jmp endmove
                      ; --- right --- ;
                        right: 
                       cmp [KeyList + 4Dh] ,1
                        jnz temp_left 
                ; ------- checks first  --------------;
                ; ---- Track colors check ------------;
                    mov di,pos_box1
                    add di,pixel_size
                    mov si,offset color_track
                    cmpsb 
                    jz temp_again
                    dec di
                    add di,(pixel_size - 1)*k
                    dec si
                    cmpsb
                    jz temp_again
                ; -------------------------------------- ;
                    mov di,pos_box1
                    mov si,pos_box2
                    add di,pixel_size
                    cmp di,si
                    ja fourth_check_r1
                    sub si,di
                    mov ax,si
                    mov dx,0
                    mov cx,k
                    div cx
                    cmp dx,0 ; there is no remainder meaning on the same vertcal line
                    jne all_good_right1
                    cmp ax,pixel_size
                    ja  all_good_right1
                    jmp terminate1
                    temp_left: jmp left
                    temp_again: jmp terminate1 ; "TEMP AGAAIINNN"
                    fourth_check_r1:
                    sub di,si
                    mov ax,di
                    mov dx,0
                    mov cx,k
                    div cx
                    cmp dx,0 ; there is no remainder meaning on the same vertcal line
                    jne all_good_right1
                    cmp ax,pixel_size ; not on the same horizontal line
                    ja  all_good_right1
                    jmp terminate1
                ; -------------------------------------- ;
                    all_good_right1:
                        mov di, pos_box1

                        cmp last_mov_c1,2 ; if it is the last move don't rotate
                        jz escape_rotr1 ; don't rotate gain
                        mov si,offset redcar ; red car
                        mov di, pos_box1 ; copy to position
                        call rotate_right ; rotate the car
                        mov last_mov_c1,2 ; update last move
                        jmp terminate1
                        escape_rotr1:

                        mov last_mov_c1 , 2
                        mov cx,pixel_size
                        removeleft:  
                                    mov al,color_path
                                    stosb
                                    dec di
                                    add di,k
                                    dec cx
                                    jnz removeleft
                                    
                        pop di 
                        inc di 
                        mov si,offset redcar
                        call rotate_right
                        mov pos_box1,di
                        jmp endmove
                        tempppp:jmp terminate1
                    ; --- left --- ;
                        left: 
                        cmp [KeyList + 4Bh] ,1
                        jnz box2switchmid
                ; ---- Track colors check ------------;
                    mov di,pos_box1
                    dec di
                    mov si,offset color_track
                    cmpsb 
                    jz tempppp
                    dec di
                    add di,(pixel_size - 1)*k
                    dec si
                    cmpsb
                    jz tempppp
                ; -------------------------------------- ;
                ; ------------first car check--------------------- ;
                    mov di,pos_box2
                    mov si,pos_box1
                    add di,pixel_size
                    cmp di,si
                    ja fourth_check_l1
                    sub si,di
                    mov ax,si
                    mov dx,0
                    mov cx,k
                    div cx
                    cmp dx,0 ; there is no remainder meaning on the same vertcal line
                    jne all_good_left1
                    cmp ax,pixel_size
                    ja  all_good_left1
                    jmp terminate1
                    box2switchmid:jmp terminate1
                    fourth_check_l1:
                    sub di,si
                    mov ax,di
                    mov dx,0
                    mov cx,k
                    div cx
                    cmp dx,0 ; there is no remainder meaning on the same vertcal line
                    jne all_good_left1
                    cmp ax,pixel_size ; not on the same horizontal line
                    ja  all_good_left1
                    jmp terminate1
                    ;---- END of checks --------; 
                    all_good_left1:
                        mov di, pos_box1


                        cmp last_mov_c1,3 ; if it is the last move don't rotate
                        jz escape_rotl1 ; don't rotate gain
                        mov si,offset redcar ; red car
                        mov di, pos_box1 ; copy to position
                        call rotate_left ; rotate the car
                        mov last_mov_c1,3 ; update last move
                        jmp terminate1
                        escape_rotl1:
                        mov last_mov_c1 , 3
                        mov cx,pixel_size 
                        add di,pixel_size - 1
                        removeright:  
                                    mov al,color_path
                                    stosb
                                    dec di
                                    add di,k
                                    dec cx
                                    jnz removeright
                                    
                        pop di 
                        dec di 
                        mov si,offset redcar
                        call rotate_left
                        mov pos_box1,di
                        jmp endmove

                    terminate1:
                        pop di
                    endmove:
                popa
                ret
move_b1             endp
; ------------------------------- ;

play            proc
                push di
                push ax
                check_move:
                        sti
                        mov cx,delay
                        call my_delay 
                        cli
                        mov di,pos_box1
                        call move_b1
                        call move_b2
                        jmp check_move
                pop ax
                pop di
                
                ret
play            endp

; ------------------------------------------------------------------------;
my_delay proc 
    
     delay_loop:
        dec cx          ; Decrement the delay count
        jnz delay_loop  ; Jump back to the loop if CX is not zero
    ret 
my_delay endp
; ------------------------ Draw Track ------------------------------------------ ;
verticalLineD proc far                              ;;;; ersm vertical line ta7t
      ;pusha
                    mov   ax, 320
                    mov   bx, y
                    mul   bx
                    add   ax, x
                    mov   di, ax
                    mov   cx, lengthD
      Line:         
    
                    mov   al, 03h
                    stosb
      ;;; filling
                    mov   dx, fill
                    cmp   dx, 0
                    jz    skipFillD
                    mov   si, di
                    mov   dx, cx
                    mov   al, 08h
                    mov   cx, widthT
                    add   cx, addFill
                    dec   cx
      fillDown:     
                    mov   al, 03h
                    scasb
                    jz    onceD
                    mov   al, 08h
      onceD:        
                    dec   di
                    stosb
                    loop  fillDown

                    mov   cx, dx
                    mov   di, si
                    mov   al, 03h
      skipFillD:    
      ;;;filling
                    add   di, 319                   ;;;;; 320 - 1 elly hwa katabo
                    loop  Line
                    mov   ax, y
                    add   ax, lengthD
                    mov   y, ax
    
      ;popa
                    ret
verticalLineD endp
 
verticalLineU proc far                              ;;;; ersm vertical line fo2
      ;pusha
                    mov   ax, 320
                    mov   bx, y
                    mul   bx
                    add   ax, x
                    mov   di, ax
                    mov   cx, lengthD
      Line1:        
    
                    mov   al, 03h
                    stosb
      ;;; filling
                    mov   dx, fill
                    cmp   dx, 0
                    jz    skipFillU
                    mov   si, di
                    sub   di, 2
                    mov   dx, cx
                    mov   al, 08h
                    mov   cx, widthT
                    add   cx, addFill
                    dec   cx
      fillU:        
                    mov   al, 03h
                    scasb
                    jz    onceU
                    mov   al, 08h
      onceU:        
                    dec   di
                    stosb
                    sub   di, 2
                    loop  fillU
    
                    mov   cx, dx
                    mov   di, si
                    mov   al, 03h
      skipFillU:    
      ;;;filling
                    sub   di, 321                   ;;;;; 320 + 1 elly hwa katabo
                    loop  Line1
                    mov   ax, y
                    sub   ax, lengthD
                    mov   y, ax
    
      ;popa
                    ret
verticalLineU endp


horizLineR proc far                                 ;;;; ersm Horizontal line ymen
      ;pusha
                    mov   ax, 320
                    mov   bx, y
                    mul   bx
                    add   ax, x
                    mov   di, ax
                    mov   cx, lengthD
                    mov   al, 03h
      storeR:       
                    stosb
      ;;; filling
                    mov   dx, fill
                    cmp   dx, 0
                    jz    skipFillR
                    mov   si, di
                    add   di, 319
                    mov   dx, cx
                    mov   al, 08h
                    mov   cx, widthT
                    add   cx, addFill
                    dec   cx
      fillR:        
                    mov   al, 03h
                    scasb
                    jz    onceR
                    mov   al, 08h
      onceR:        
                    dec   di
                    stosb
                    add   di, 319
                    loop  fillR
    
                    mov   cx, dx
                    mov   di, si
                    mov   al, 03h
      skipFillR:    
      ;;;filling
                    loop  storeR
                    mov   ax, x
                    add   ax, lengthD
                    mov   x, ax
    
      ;popa
                    ret
horizLineR endp

horizLineL proc far
      ;pusha
                    mov   ax, 320
                    mov   bx, y
                    mul   bx
                    add   ax, x
                    sub   ax, lengthD
                    mov   di, ax
                    mov   cx, lengthD
                    mov   al, 03h
      storeL:       
                    stosb
      ;;; filling
                    mov   dx, fill
                    cmp   dx, 0
                    jz    skipFillL
                    mov   si, di
                    sub   di,321
                    mov   dx, cx
                    mov   al, 08h
                    mov   cx, widthT
                    add   cx, addFill
                    dec   cx
      fillL:        
                    mov   al, 03h
                    scasb
                    jz    onceL
                    mov   al, 08h
      onceL:        
                    dec   di
                    stosb
                    sub   di, 321
                    loop  fillL
    
                    mov   cx, dx
                    mov   di, si
                    mov   al, 03h
      skipFillL:    
      ;;;filling
                    loop  storeL
                    mov   ax, x
                    sub   ax, lengthD
                    mov   x, ax
    
      ;popa
                    ret
horizLineL endp

trackUp proc far
      ;;;; tkmlt track;;;;;

                    mov   ax, lastDirection
                    cmp   ax, 0                     ;;; same direction fo2
                    jz    skip1
                    cmp   ax, 1                     ;;; cancel aslan (up then down)
                    jz    exit1
                    cmp   ax, 2                     ;;; right then up
                    jz    RU
                    cmp   ax, 3                     ;;; left then up
                    jz    LU
      LU:           
                    mov   ax, x2
                    mov   bx, y2
                    mov   x, ax
                    mov   y, bx
                    mov   dx, widthT
                    mov   lengthD, dx
                    mov   fill,1
                    mov   addFill, 1
                    call  horizLineL
                    mov   addFill, 0
                    mov   fill,0
                    call  verticalLineU
                    mov   ax, x
                    mov   bx, y
                    mov   x2, ax
                    mov   y2, bx
                    jmp   skip1
      RU:           
                    mov   ax, x2
                    mov   bx, y2
                    mov   x, ax
                    mov   y, bx
                    mov   dx, widthT
                    mov   lengthD, dx
                    call  horizLineR
                    mov   fill,1
                    mov   addFill, 1
                    call  verticalLineU
                    mov   addFill, 0
                    mov   fill,0
                    mov   ax, x
                    mov   bx, y
                    mov   x2, ax
                    mov   y2, bx
                    jmp   skip1
      skip1:        
      ;;; test for line1, line2 ;;; shmal 3ayzeeeno line1
                    mov   ax, x2
                    mov   bx, x1
                    cmp   ax, bx
                    ja    skipSwapUP
                    mov   x1, ax                    ;; xchg
                    mov   x2, bx
      SkipSwapUP:   
      ;;; test for line1, line2

                    mov   cx, lengthT
                    cmp   cx, 0
                    jz    skipLs1
      ;;;; tkmlt track;;;;;

      
                    mov   ax, x1
                    mov   bx, y1
                    mov   x, ax
                    mov   y, bx
                    mov   dx, lengthT
                    mov   lengthD, dx
      
                    call  verticalLineU

                    mov   ax, x
                    mov   bx, y
                    mov   x1, ax
                    mov   y1, bx
                    mov   ax, x2
                    mov   bx, y2
                    mov   x, ax
                    mov   y, bx
                    mov   fill,1
                    call  verticalLineU
                    mov   fill,0
                    mov   ax, x
                    mov   bx, y
                    mov   x2, ax
                    mov   y2, bx
      skipLs1:      
                    mov   ax, 0
                    mov   lastDirection, ax
      
      exit1:        
                    ret
trackUp endp

trackDown proc far
      ;;;; tkmlt track;;;;;
                    mov   ax, lastDirection
                    cmp   ax, 1                     ;;; same direction ta7t
                    jz    skip
                    cmp   ax, 0                     ;;; cancel aslan (up then down)
                    jz    exit
                    cmp   ax, 2                     ;;; right then down
                    jz    RD
                    cmp   ax, 3                     ;;; left then down
                    jz    LD
      LD:           
                    mov   ax, x1
                    mov   bx, y1
                    mov   x, ax
                    mov   y, bx
                    mov   dx, widthT
                    mov   lengthD, dx
                    call  horizLineL
                    mov   fill,1
                    mov   addFill, 1
                    call  verticalLineD
                    mov   addFill, 0
                    mov   fill,0
                    mov   ax, x
                    mov   bx, y
                    mov   x1, ax
                    mov   y1, bx
                    jmp   skip
      RD:           
                    mov   ax, x1
                    mov   bx, y1
                    mov   x, ax
                    mov   y, bx
                    mov   dx, widthT
                    mov   lengthD, dx
                    mov   fill,1
                    mov   addFill, 1
                    call  horizLineR
                    mov   fill,0
                    mov   addFill, 0
                    call  verticalLineD
                    mov   ax, x
                    mov   bx, y
                    mov   x1, ax
                    mov   y1, bx
                    jmp   skip
      
      ;;;; tkmlt track;;;;;
      skip:         
      
      ;;; test for line1, line2 ;;; shmal 3ayzeeeno line1
                    mov   ax, x2
                    mov   bx, x1
                    cmp   ax, bx
                    ja    skipswapDown
                    mov   x1, ax                    ;; xchg
                    mov   x2, bx
      skipswapDown: 
      ;;; test for line1, line2
                    mov   cx, lengthT
                    cmp   cx, 0
                    jz    skipLs

                    jz    exit
                    mov   ax, x1
                    mov   bx, y1
                    mov   x, ax
                    mov   y, bx
                    mov   dx, lengthT
                    mov   lengthD, dx
                    mov   fill,1
                    call  verticalLineD
                    mov   fill,0
                    mov   ax, x
                    mov   bx, y
                    mov   x1, ax
                    mov   y1, bx
                    mov   ax, x2
                    mov   bx, y2
                    mov   x, ax
                    mov   y, bx
                    call  verticalLineD
                    mov   ax, x
                    mov   bx, y
                    mov   x2, ax
                    mov   y2, bx
      skipLs:       
                    mov   ax, 1
                    mov   lastDirection, ax
      
      
      exit:         
                    ret
trackDown endp


trackRight proc far
      ;;;; tkmlt track;;;;;

                    mov   ax, lastDirection
                    cmp   ax, 0                     ;;; UP then right
                    jz    UR
                    cmp   ax, 1                     ;;; down then right
                    jz    DR
                    cmp   ax, 2                     ;;; right then right (skip)
                    jz    skip2
                    cmp   ax, 3                     ;;; left then right  (cancel)
                    jz    exit2
      UR:           
                    mov   ax, x1
                    mov   bx, y1
                    mov   x, ax
                    mov   y, bx
                    mov   dx, widthT
                    mov   lengthD, dx
                    call  verticalLineU
                    mov   fill,1
                    mov   addFill, 1
                    call  horizLineR
                    mov   addFill, 0
                    mov   fill,0
                    mov   ax, x
                    mov   bx, y
                    mov   x1, ax
                    mov   y1, bx
                    jmp   skip2
      DR:           
                    mov   ax, x1
                    mov   bx, y1
                    mov   x, ax
                    mov   y, bx
                    mov   dx, widthT
                    mov   lengthD, dx
                    mov   fill,1
                    mov   addFill, 1
                    call  verticalLineD
                    mov   addFill, 0
                    mov   fill,0
                    call  horizLineR
                    mov   ax, x
                    mov   bx, y
                    mov   x1, ax
                    mov   y1, bx
                    jmp   skip2
      skip2:        
      ;;;; tkmlt track;;;;;
      ;;; test for line1, line2 ;;; fo2 3ayzeeeno line1
                    mov   ax, y2
                    mov   bx, y1
                    cmp   ax, bx
                    ja    skipswapRight
                    mov   y1, ax                    ;; xchg
                    mov   y2, bx
      skipswapRight:
      ;;; test for line1, line2
                    mov   cx, lengthT
                    cmp   cx, 0
                    jz    skipLs2
                    mov   ax, x1
                    mov   bx, y1
                    mov   x, ax
                    mov   y, bx
                    mov   dx, lengthT
                    mov   lengthD, dx
                    mov   fill,1
                    call  horizLineR
                    mov   fill,0
                    mov   ax, x
                    mov   bx, y
                    mov   x1, ax
                    mov   y1, bx
                    mov   ax, x2
                    mov   bx, y2
                    mov   x, ax
                    mov   y, bx
                    call  horizLineR

                    mov   ax, x
                    mov   bx, y
                    mov   x2, ax
                    mov   y2, bx
      skipLs2:      
                    mov   ax, 2
                    mov   lastDirection, ax
      
      
     
      exit2:        
                    ret
trackRight endp


trackLeft proc far
    
    
        
      ;;;; tkmlt track;;;;;

                    mov   ax, lastDirection
                    cmp   ax, 0                     ;;; UP then left
                    jz    UL
                    cmp   ax, 1                     ;;; down then left
                    jz    downLL
                    cmp   ax, 2                     ;;; right then left (cancel)
                    jz    exit3
                    cmp   ax, 3                     ;;; left then left  (skip)
                    jz    skip3
      UL:           
                    mov   ax, x2
                    mov   bx, y2
                    mov   x, ax
                    mov   y, bx
                    mov   dx, widthT
                    mov   lengthD, dx
                    mov   fill, 1
                    mov   addFill, 1
                    call  verticalLineU
                    mov   addFill, 0
                    mov   fill,0
                    call  horizLineL
                    mov   ax, x
                    mov   bx, y
                    mov   x2, ax
                    mov   y2, bx
                    jmp   skip3
      downLL:       
                    mov   ax, x2
                    mov   bx, y2
                    mov   x, ax
                    mov   y, bx
                    mov   dx, widthT
                    mov   lengthD, dx
                    call  verticalLineD
                    mov   fill,1
                    mov   addFill, 1
                    call  horizLineL
                    mov   addFill, 0
                    mov   fill,0
                    mov   ax, x
                    mov   bx, y
                    mov   x2, ax
                    mov   y2, bx
                    jmp   skip3
      skip3:        
      ;;;; tkmlt track;;;;;
      ;;; test for line1, line2 ;;; fo2 3ayzeeeno line1
                    mov   ax, y2
                    mov   bx, y1
                    cmp   ax, bx
                    ja    skipswapLeft
                    mov   y1, ax                    ;; xchg
                    mov   y2, bx
      skipswapLeft: 
      ;;; test for line1, line2
                    mov   cx, lengthT
                    cmp   cx, 0
                    jz    skipLs3
                    mov   ax, x1
                    mov   bx, y1
                    mov   x, ax
                    mov   y, bx
                    mov   dx, lengthT
                    mov   lengthD, dx

                    call  horizLineL

                    mov   ax, x
                    mov   bx, y
                    mov   x1, ax
                    mov   y1, bx
                    mov   ax, x2
                    mov   bx, y2
                    mov   x, ax
                    mov   y, bx
                    mov   dx, lengthT
                    mov   lengthD, dx
                    mov   fill,1
                    call  horizLineL
                    mov   fill,0
                    mov   ax, x
                    mov   bx, y
                    mov   x2, ax
                    mov   y2, bx
      skipLs3:      
                    mov   ax, 3
                    mov   lastDirection, ax
      
      
     
      exit3:        
                    ret
trackLeft endp


checkUP proc far
      ;;;; mmkn nhtag n shift el x 3la hasab howa gy mn ymen wla shmal fl second test

                    mov   ax, y1
                    cmp   ax, 0
                    jz    dontU
      ;;;;; first test
                    mov   ax, lengthT
                    mov   temporaryLength, ax

                    mov   ax, y1
                    mov   bx, lengthT
                    add   bx, widthT
                    add   bx, widthT
                    cmp   ax, bx
                    jae   skip1U
                    mov   ax, y1
                    mov   bx, widthT
                    add   bx, widthT
                    cmp   ax, bx
                    jb    lowU
                    sub   ax, bx
                    mov   temporaryLength, ax
      skip1U:                                       ;;;; check for lines in memory, ax = temporary length
                    mov   cx, temporaryLength
                    add   cx, widthT
                    add   cx, widthT
                    mov   ax, 320
                    mov   bx, y1
                    sub   bx, 1                     ;;; 3shan abos 3l above pixel
                    mul   bx
                    add   ax, x1
                    mov   di, ax
                    mov   ah, 0                     ;
                    mov   al, 03h                   ;;;;; color
      scan1U:                                       ;;; hnscan shwya
                    scasb
                    jz    exit1U
                    sub   di, 321                   ;;; elly et7arakha w hnwdeha fo2
                    loop  scan1U
      exit1U:                                       ;;; hndraw el allowed - 2* width lw mfesh 2*width yb2a don't draw asln
                    mov   dx, cx                    ;;; allowed fl dx
                    mov   cx, temporaryLength
                    mov   bx, widthT
                    add   bx, widthT
                    add   cx, bx
                    sub   cx, dx
                    cmp   cx, bx
                    jb    dontU
                    sub   cx, bx                    ;;; allowed
                    mov   temporaryLength, cx       ;;;; allowed mn first check 3ayzeen 3l tany mn gher mnghyr
    
      ;;;;; first test
    
    
      ;;;; second test
                    mov   ax, lengthT
                    mov   temporaryLength2, ax

                    mov   ax, y1
                    mov   bx, lengthT
                    add   bx, widthT
                    add   bx, widthT
                    cmp   ax, bx
                    jae   skip2U
                    mov   ax, y1
                    mov   bx, widthT
                    add   bx, widthT
                    cmp   ax, bx
                    jb    lowU
                    sub   ax, bx
                    mov   temporaryLength2, ax
      skip2U:                                       ;;;; check for lines in memory, ax = temporary length
                    mov   cx, temporaryLength2
                    add   cx, widthT
                    add   cx, widthT
                    mov   ax, 320
                    mov   bx, y1
                    sub   bx, 1
                    mul   bx
                    add   ax, x2
      ;;;; mmkn nhtag n shift el X 3la hasab howa gy mn ymen wla shmal

                    mov   dx, lastDirection
                    cmp   dx, 0                     ;;; cancel
                    jz    leftU                     ;;;;;; cancel
                    cmp   dx, 2
                    jz    rightU
                    mov   dx, x1                    ;;;;;; added to not exit bounds
                    cmp   dx, widthT                ;;;;;; added to not exit bounds
                    jb    dontD                     ;;;;;; added to not exit bounds
                    sub   ax, widthT
                    jmp   leftU
      rightU:       
                    add   ax, widthT
                    mov   dx, x2                    ;;;;;; added to not exit bounds
                    add   dx, widthT                ;;;;;; added to not exit bounds
                    cmp   dx, 319                   ;;;;;; added to not exit bounds
                    ja    dontD                     ;;;;;; added to not exit bounds
      leftU:        
      ;;;;
                    mov   di, ax
                    mov   ah, 0                     ;
                    mov   al, 03h                   ;;;;; color
      scan2U:                                       ;;; hnscan shwya
                    scasb
                    jz    exit2U
                    sub   di, 321                   ;;; elly et7arakha w hnwdeha fo2
                    loop  scan2U
      exit2U:                                       ;;; hndraw el allowed - 2* width lw mfesh 2*width yb2a don't draw asln
                    mov   dx, cx                    ;;; allowed fl dx
                    mov   cx, temporaryLength2
                    mov   bx, widthT
                    add   bx, widthT
                    add   cx, bx
                    sub   cx, dx
                    cmp   cx, bx
                    jb    dontU
                    sub   cx, bx                    ;;; allowed
                    mov   temporaryLength2, cx      ;;;; allowed mn second check 3l tany
                    jmp   exitAllU
      ;;;; second test
    
    
    
      dontU:        
                    mov   temporaryLength2, 0
                    mov   temporaryLength, 0
                    mov   dontDraw, 1
    
      lowU:         
                    mov   temporaryLength2, 0
                    mov   temporaryLength, 0
      exitAllU:     
                    ret
checkUp endp
 
 

checkDown proc far                                  ;;;; still to be tested  dymn check bl Y2 3shan lower w ghyr X
    
      ;;;; mmkn nhtag n shift el x 3la hasab howa gy mn ymen wla shmal fl second test
                    mov   ax, y2
                    cmp   ax, row
                    jz    dontD
      ;;;;; first test
                    mov   ax, lengthT
                    mov   temporaryLength, ax

                    mov   ax, row

                    mov   bx, y2
                    add   bx, lengthT
                    add   bx, widthT
                    add   bx, widthT
                    cmp   ax, bx
                    jae   skip1D
                    mov   ax, row
                    sub   ax, widthT
                    sub   ax, widthT
                    mov   bx, ax
                    mov   ax, y2
                    cmp   bx, ax
                    jb    low1D
    
                    sub   bx, ax
                    mov   ax, bx
                    mov   temporaryLength, ax
      skip1D:                                       ;;;; check for lines in memory, ax = temporary length
                    mov   cx, temporaryLength
                    add   cx, widthT
                    add   cx, widthT
                    mov   ax, 320
                    mov   bx, y2
                    add   bx, 1                     ;; nnzl taht pixel
                    mul   bx
                    add   ax, x1
                    mov   di, ax
                    mov   ah, 0                     ;
                    mov   al, 03h                   ;;;;; color
      scan1D:                                       ;;; hnscan shwya
                    scasb
                    jz    exit1D
                    add   di, 319                   ;;; elly et7arakha w hnwdeha fo2
                    loop  scan1D
      exit1D:                                       ;;; hndraw el allowed - 2* width lw mfesh 2*width yb2a don't draw asln
                    mov   dx, cx                    ;;; allowed fl dx
                    mov   cx, temporaryLength
                    mov   bx, widthT
                    add   bx, widthT
                    add   cx, bx
                    sub   cx, dx
                    cmp   cx, bx
                    jb    dontD
                    sub   cx, bx                    ;;; allowed
                    mov   temporaryLength, cx       ;;;; allowed mn first check 3ayzeen 3l tany mn gher mnghyr
    
      ;;;;; first test
    
    
      ;;;; second test
                    mov   ax, lengthT
                    mov   temporaryLength2, ax

                    mov   ax, row
                    mov   bx, y2
                    add   bx, lengthT
                    add   bx, widthT
                    add   bx, widthT
                    cmp   ax, bx

                    jae   skip2D
                    mov   ax, row
                    sub   ax, widthT
                    sub   ax, widthT
                    mov   bx, ax
                    mov   ax, y2
                    cmp   bx, ax
                    jb    low1D
                    sub   bx, ax
                    mov   ax, bx
                    mov   temporaryLength2, ax
      skip2D:                                       ;;;; check for lines in memory, ax = temporary length
                    mov   cx, temporaryLength2
                    add   cx, widthT
                    add   cx, widthT
                    mov   ax, 320
                    mov   bx, y2
                    add   bx, 1                     ;;;; check pixel taht
                    mul   bx
    
    
                    add   ax, x2
    
      ;;;; mmkn nhtag n shift el X 3la hasab howa gy mn ymen wla shmal

                    mov   dx, lastDirection
                    cmp   dx, 1                     ;;; cancel
                    jz    leftD                     ;;;;;; cancel
                    cmp   dx, 2
                    jz    rightD
                    mov   dx, x1                    ;;;;;; added to not exit bounds

                    cmp   dx, widthT                ;;;;;; added to not exit bounds
                    jb    dontD                     ;;;;;; added to not exit bounds
                    sub   ax, widthT
                    jmp   leftD
      rightD:       
                    add   ax, widthT
                    mov   dx, x2                    ;;;;;; added to not exit bounds
                    add   dx, widthT                ;;;;;; added to not exit bounds
                    cmp   dx, 319                   ;;;;;; added to not exit bounds
                    ja    dontD                     ;;;;;; added to not exit bounds
    
      leftD:        
      ;;;;
                    mov   di, ax
                    mov   ah, 0                     ;
                    mov   al, 03h                   ;;;;; color
      scan2D:                                       ;;; hnscan shwya
                    scasb
                    jz    exit2D
                    add   di, 319                   ;;; elly et7arakha w hnwdeha taht
                    loop  scan2D
      exit2D:                                       ;;; hndraw el allowed - 2* width lw mfesh 2*width yb2a don't draw asln
                    mov   dx, cx                    ;;; allowed fl dx
                    mov   cx, temporaryLength2
                    mov   bx, widthT
                    add   bx, widthT
                    add   cx, bx
                    sub   cx, dx
                    cmp   cx, bx
                    jb    dontD
                    sub   cx, bx                    ;;; allowed
                    mov   temporaryLength2, cx      ;;;; allowed mn second check 3l tany
                    jmp   exitAllD
      ;;;; second test
    
    
    
      dontD:        
                    mov   temporaryLength2, 0
                    mov   temporaryLength, 0
                    mov   dontDraw, 1
      low1D:        
                    mov   temporaryLength2, 0
                    mov   temporaryLength, 0
      exitAllD:     
                    ret
checkDown endp



checkRight proc far                                 ;;;y1 = y2, x2 3l ymen = use it
    
                    mov   ax, x2
                    cmp   ax, 319
                    jz    dontR
      ;;;;; first test
                    mov   ax, lengthT
                    mov   temporaryLength, ax

                    mov   ax, 319
                    mov   bx, x2
                    add   bx, lengthT
                    add   bx, widthT
                    add   bx, widthT
                    cmp   ax, bx
                    jae   skip1R
                    mov   ax, 319                   ;;;;; test
                    sub   ax, widthT
                    sub   ax, widthT
                    mov   bx, ax
                    mov   ax, x2
                    cmp   bx, ax
                    jb    lowR
                    sub   bx, ax
                    mov   ax, bx
                    mov   temporaryLength, ax
      skip1R:                                       ;;;; check for lines in memory, ax = temporary length
                    mov   cx, temporaryLength
                    add   cx, widthT
                    add   cx, widthT
                    mov   ax, 320
                    mov   bx, y1
            
                    mul   bx
                    add   ax, x2
                    add   ax,1                      ;;; 3shan abos 3l right pixel
                    mov   di, ax
                    mov   ah, 0                     ;
                    mov   al, 03h                   ;;;;; color
      scan1R:                                       ;;; hnscan shwya
                    scasb
                    jz    exit1R
                    loop  scan1R
      exit1R:                                       ;;; hndraw el allowed - 2* width lw mfesh 2*width yb2a don't draw asln
                    mov   dx, cx                    ;;; allowed fl dx
                    mov   cx, temporaryLength
                    mov   bx, widthT
                    add   bx, widthT
                    add   cx, bx
                    sub   cx, dx
                    cmp   cx, bx
                    jb    dontR
                    sub   cx, bx                    ;;; allowed
                    mov   temporaryLength, cx       ;;;; allowed mn first check 3ayzeen 3l tany mn gher mnghyr
    
      ;;;;; first test
    
    
      ;;;; second test
                    mov   ax, lengthT
                    mov   temporaryLength2, ax

                    mov   ax, 319
                    mov   bx, x2
                    add   bx, lengthT
                    add   bx, widthT
                    add   bx, widthT
                    cmp   ax, bx
                    jae   skip2R
                    mov   ax, 319
                    sub   ax, widthT
                    sub   ax, widthT
                    mov   bx, ax
                    mov   ax, x2
                    cmp   bx, ax
                    jb    lowR
                    sub   bx, ax
                    mov   ax, bx
                    mov   temporaryLength2, ax
      skip2R:                                       ;;;; check for lines in memory, ax = temporary length
                    mov   cx, temporaryLength2
                    add   cx, widthT
                    add   cx, widthT
                    mov   ax, 320
                    mov   bx, y2                    ;;;; changed to y2
    
      ;;;; mmkn nhtag n shift el height 3la hasab howa gy mn taht wla fo2

                    mov   dx, lastDirection
                    cmp   dx, 2                     ;;; cancel
                    jz    upR                       ;;;;;; cancel
                    cmp   dx, 1
                    jz    downR
                    sub   bx, widthT
                    mov   dx, y1                    ;;;;;; added to not exit bounds
                    cmp   dx, widthT                ;;;;;; added to not exit bounds
                    jb    dontR                     ;;;;;; added to not exit bounds
                    jmp   upR
      downR:        
                    add   bx, widthT
                    mov   dx, y2                    ;;;;;; added to not exit bounds
                    add   dx, widthT                ;;;;;; added to not exit bounds
                    cmp   dx, row                   ;;;;;; added to not exit bounds
                    jae   dontR                     ;;;;;; added to not exit bounds
      upR:          
      ;;;;
                    mul   bx
                    add   ax, x2
                    add   ax,1                      ;;; 3shan abos 3l right pixel
                    mov   di, ax
                    mov   ah, 0                     ;
                    mov   al, 03h                   ;;;;; color
      scan2R:                                       ;;; hnscan shwya
                    scasb
                    jz    exit2R
                    loop  scan2R
      exit2R:                                       ;;; hndraw el allowed - 2* width lw mfesh 2*width yb2a don't draw asln
                    mov   dx, cx                    ;;; allowed fl dx
                    mov   cx, temporaryLength2
                    mov   bx, widthT
                    add   bx, widthT
                    add   cx, bx
                    sub   cx, dx
                    cmp   cx, bx
                    jb    dontR
                    sub   cx, bx                    ;;; allowed
                    mov   temporaryLength2, cx      ;;;; allowed mn second check 3ayzeen 3l tany mn gher mnghyr
                    jmp   exitAllR
      ;;;; second test
    
    
    
      dontR:        
                    mov   temporaryLength2, 0
                    mov   temporaryLength, 0
                    mov   dontDraw, 1
    
      lowR:         
                    mov   temporaryLength2, 0
                    mov   temporaryLength, 0
      exitAllR:     
                    ret
checkRight endp


checkLeft proc far                                  ;;;y1 = y2, x1 3l shmal = use it
    
                    mov   ax, x1
                    cmp   ax, 0
                    jz    dontL
      ;;;;; first test
                    mov   ax, lengthT
                    mov   temporaryLength, ax

                    mov   ax, x1
                    mov   bx, lengthT
                    add   bx, widthT
                    add   bx, widthT
                    cmp   ax, bx
                    jae   skip1L
                    mov   ax, x1
                    mov   bx, widthT
                    add   bx, widthT
                    cmp   ax, bx
                    jb    lowL
                    sub   ax, bx
                    mov   temporaryLength, ax
      skip1L:                                       ;;;; check for lines in memory, ax = temporary length
                    mov   cx, temporaryLength
                    add   cx, widthT
                    add   cx, widthT
                    mov   ax, 320
                    mov   bx, y1
            
                    mul   bx
                    add   ax, x1
                    sub   ax,1                      ;;; 3shan abos 3l left pixel
                    mov   di, ax
                    mov   ah, 0                     ;
                    mov   al, 03h                   ;;;;; color
      scan1L:                                       ;;; hnscan shwya
                    scasb
                    jz    exit1L
                    sub   di, 2                     ;;;; 3shan amshy shmal
                    loop  scan1L
      exit1L:                                       ;;; hndraw el allowed - 2* width lw mfesh 2*width yb2a don't draw asln
                    mov   dx, cx                    ;;; allowed fl dx
                    mov   cx, temporaryLength
                    mov   bx, widthT
                    add   bx, widthT
                    add   cx, bx
                    sub   cx, dx
                    cmp   cx, bx
                    jb    dontL
                    sub   cx, bx                    ;;; allowed
                    mov   temporaryLength, cx       ;;;; allowed mn first check 3ayzeen 3l tany mn gher mnghyr
    
      ;;;;; first test
    
    
      ;;;; second test
                    mov   ax, lengthT
                    mov   temporaryLength2, ax

                    mov   ax, x1
                    mov   bx, lengthT
                    add   bx, widthT
                    add   bx, widthT
                    cmp   ax, bx
                    jae   skip2L
                    mov   ax, x1
                    mov   bx, widthT
                    add   bx, widthT
                    cmp   ax, bx
                    jb    lowL
                    sub   ax, bx
                    mov   temporaryLength2, ax
      skip2L:                                       ;;;; check for lines in memory, ax = temporary length
                    mov   cx, temporaryLength2
                    add   cx, widthT
                    add   cx, widthT
                    mov   ax, 320
                    mov   bx, y2                    ;;;  change to y2 test
      ;;;; mmkn nhtag n shift el height 3la hasab howa gy mn taht wla fo2

                    mov   dx, lastDirection
                    cmp   dx, 3                     ;;; cancel
                    jz    upL                       ;;;;;; cancel
                    cmp   dx, 1
                    jz    downL
                    sub   bx, widthT
                    mov   dx, y1                    ;;;;;; added to not exit bounds
                    cmp   dx, widthT                ;;;;;; added to not exit bounds
                    jb    dontL                     ;;;;;; added to not exit bounds
                    jmp   upL
      downL:        
                    add   bx, widthT
                    mov   dx, y2                    ;;;;;; added to not exit bounds
                    add   dx, widthT                ;;;;;; added to not exit bounds
                    cmp   dx, row                   ;;;;;; added to not exit bounds
                    jae   dontL                     ;;;;;; added to not exit bounds
      upL:          
      ;;;;
                    mul   bx
                    add   ax, x1
                    sub   ax,1                      ;;; 3shan abos 3l left pixel
                    mov   di, ax
                    mov   ah, 0                     ;
                    mov   al, 03h                   ;;;;; color
      scan2L:                                       ;;; hnscan shwya
                    scasb
                    jz    exit2L
                    sub   di, 2                     ;;;; 3shan amshy shmal
                    loop  scan2L
      exit2L:                                       ;;; hndraw el allowed - 2* width lw mfesh 2*width yb2a don't draw asln
                    mov   dx, cx                    ;;; allowed fl dx
                    mov   cx, temporaryLength2
                    mov   bx, widthT
                    add   bx, widthT
                    add   cx, bx
                    sub   cx, dx
                    cmp   cx, bx
                    jb    dontL
                    sub   cx, bx                    ;;; allowed
                    mov   temporaryLength2, cx      ;;;; allowed mn first check 3ayzeen 3l tany mn gher mnghyr
                    jmp   exitAllL
      ;;;; second test
    
    
    
      dontL:        
                    mov   temporaryLength2, 0
                    mov   temporaryLength, 0
                    mov   dontDraw, 1
    
      lowL:         
                    mov   temporaryLength2, 0
                    mov   temporaryLength, 0
      exitAllL:     
                    ret
    
    
checkLeft endp
 
 
 

drawUp proc far                                     ;;; after checking

                    call  checkUP
                    cmp   dontDraw, 1
                    jz    exitU
                    mov   ax, temporaryLength
                    cmp   ax, temporaryLength2
                    jbe   skipSwapU
                    mov   ax, temporaryLength2
                    mov   temporaryLength, ax
  
      skipSwapU:    
                    mov   lengthT, ax
                    call  trackUp
                    mov   ax, lengthD
                    mov   lengthT, ax
     
      exitU:        
                    mov   dontDraw, 0
                    ret
drawUp endP

drawRight proc far                                  ;;; after checking

                    call  checkRight
                    cmp   dontDraw, 1
                    jz    exit
                    mov   ax, temporaryLength
                    cmp   ax, temporaryLength2
                    jbe   skipSwapR
                    mov   ax, temporaryLength2
                    mov   temporaryLength, ax

      skipSwapR:    
                    mov   lengthT, ax
                    call  trackRight
                    mov   ax, lengthD
                    mov   lengthT, ax
     
      exitR:        
                    mov   dontDraw, 0
                    ret
drawRight endp

drawLeft proc far                                   ;;; after checking

                    call  checkLeft
                    cmp   dontDraw, 1
                    jz    exitL
                    mov   ax, temporaryLength
                    cmp   ax, temporaryLength2
                    jbe   skipSwapL
                    mov   ax, temporaryLength2
                    mov   temporaryLength, ax

      skipSwapL:    
                    mov   lengthT, ax
                    call  trackLeft
                    mov   ax, lengthD
                    mov   lengthT, ax
     
      exitL:        
                    mov   dontDraw, 0
                    ret
drawLeft endp


drawDOWN proc far

                    call  checkDown
                    cmp   dontDraw, 1
                    jz    exitD
                    mov   ax, temporaryLength
                    cmp   ax, temporaryLength2
                    jbe   skipSwapD
                    mov   ax, temporaryLength2
                    mov   temporaryLength, ax
      skipSwapD:    
                    mov   lengthT, ax
                    call  trackDown
                    mov   ax, lengthD
                    mov   lengthT, ax
     
      exitD:        
                    mov   dontDraw, 0
                    ret
drawDOWN endp


drawTrack proc far
   
        

                    call  drawStartLine

                    mov   ax, widthT
                    mov   x2, ax

                    call  drawDown
                    
                    
                    call drawUp
                    call drawLeft
                    mov   cx, 00ffh                 ;;; 3dd el randoms
      ;;; random
      rand:         
        
                    push  cx
                    mov   ah, 2ch
                    int   21h

      ;; test2
                    mov   ch,0
                    mov   cl, dh
                    add cl, 10
                    shl   cl, 2
      loop22:       
                    push  cx
                    mov   ah, 2ch
                    int   21h
                    pop   cx
                    loop  loop22
      ;; test2
                    mov   ah, 0
                    mov   al, dl                    ;;micro seconds?
                    mov   bl, 4
        
                    div   bl
      ;;; ah = rest 
                    
                    jz next
                    cmp   ah, 0
                    jz    U
                    cmp   ah, 3
                    jz    D
                    cmp   ah,1
                    jz    R
                    cmp   ah,2
                    jz    L
      U:            
                    call  drawUP
                    jmp   next
      D:            
                    call  drawDOWN
                    jmp   next
      R:            
                    mov   ax, lengthT
                    push  ax
                    add   ax, lengthT
                    mov   lengthT, ax
                    call  drawRight
                    pop   ax
                    mov   lengthT, ax
                    jmp   next
        
      L:            
                    mov   ax, lengthT
                    push  ax
                    add   ax, lengthT
                    mov   lengthT, ax
                    call  drawLeft
                    pop   ax
                    mov   lengthT, ax
                    jmp   next
        
      next:         
                    pop   cx
                    loop  rand
                    call  drawEndLine
      ;;;;; inline chat row
                    mov   ax, 320
                    mov   bx, word ptr row
                    inc   bx
                    mul   bx
                    mov   di, ax
                    mov   al, 0eh
                    mov   cx, 320
                    rep   stosb
        
      ;;;;;inline chat row

                    ret
drawtrack endp

drawEndLine proc far
                    mov   ax, x1
                    mov   bx, x2
                    cmp   ax, bx
                    jz    vertical
                    mov   ax, 320
                    mov   bx, y1
                    mul   bx
                    add   ax, x1
                    mov   di, ax
                    mov   cx, x2
                    sub   cx, x1

                    mov   al, 04h
                    rep   stosb

                    jmp   endLine
      vertical:     
                    mov   cx, y2
                    sub   cx, y1
                    mov   ax, 320
                    mov   bx, y1
                    mul   bx
                    add   ax, x1
                    mov   di, ax
      color:        
                    mov   al, 04h
                    stosb
                    add   di, 319
                    loop  color
    
    
    
      endLine:      
                    ret
drawEndLine endp


drawStartLine proc far
      ;;start line
                    mov   ax, widthT
                    mov   lengthD, ax
                    call  horizLineR
                    mov   ax, lengthT
                    mov   lengthD, ax
    
                    mov   x, 0
      ;;start line
                    ret
drawStartLine endp



end main