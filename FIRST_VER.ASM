.model tiny
.data


output_phrase db 'You entered:', 0
output_phrase_correct db 'You have admin rights!', 0
output_phrase_incorrect db 'You entered incorrect password!', 0
correct_password db '1234', 0
len_output_phrase dw $ - output_phrase
len_output_phrase_correct dw $ - output_phrase_correct
len_output_phrase_incorrect dw $ - output_phrase_incorrect
len_buffer_for_text dw 0


.code
org 100h
Start:
    call Read_the_text
    call Check_password
    ;call Print_text
    mov ax, 4c00h
    int 21h

;----------------------------------------------------------
;Read_the_text
;----------------------------------------------------------
Read_the_text proc
    xor cx, cx

    ;mov ah, 0Ah
    ;mov dx, offset buffer_for_text
    ;int 21h

    mov si, offset buffer_for_text + 2
    ;mov cl, [buffer_for_text+1]
    ;add si, cx
    ;mov byte ptr [si], 0

InputLoop:
    mov ah, 00h
    int 16h
    cmp al, 0Dh
    je Finish
    cmp al, 08h  ; Backspace?
    je Backspace
    mov ah, 0Eh
    int 10h
    mov [si], al
    inc si
    inc cx
    cmp cx, 13
    jne InputLoop
Backspace:
    cmp cx, 0
    je Finish
    dec si
    dec cx
    mov ah, 0Eh
    mov al, 08h; Delete symbol
    int 10h
    mov al, ' '
    int 10h
    mov al, 08h
    int 10h
    jmp InputLoop

Finish:
    mov byte ptr [si], 0
    mov len_buffer_for_text, si
    mov cx, len_buffer_for_text
    call Print_newline
    ret
endp

;----------------------------------------------------------
;Check_password
;----------------------------------------------------------
Check_password proc
    mov si, offset buffer_for_text + 2
    mov di, offset correct_password
    xor cx, cx
    cmp cx, 0
    jmp Jump_buffer

    buffer_for_text db 12, 0, 10 dup(0)

Jump_buffer:
    xor cx, cx
    ;je End_of_loop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
Loop_print:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne Incorrect
    cmp al, 0
    je End_of_loop
    inc si
    inc di
    jmp Loop_print
End_of_loop:
    mov si, offset output_phrase_correct
    call Print_loop
    mov cx, len_output_phrase_correct
    call Print_newline
    ret
Incorrect:
    mov si, offset output_phrase_incorrect
    call Print_loop
    mov cx, len_output_phrase_incorrect
    call Print_newline
    call Print_text
    ret
endp


;----------------------------------------------------------
;Print_text
;----------------------------------------------------------
Print_text proc

    mov si, offset output_phrase
    mov ah, 0Eh
    call Print_loop

    mov si, offset buffer_for_text + 2
    mov cx, len_output_phrase
    call Print_newline
    call Print_loop

    ret
endp

;----------------------------------------------------------
;Print_loop
;----------------------------------------------------------
Print_loop proc
    mov ah, 0Eh
OutputLoop:
    mov al, [si]
    cmp al, 0
    je Done
    int 10h

    inc si
    jmp OutputLoop
Done:
    ret
endp

;----------------------------------------------------------
;Print_newline
;----------------------------------------------------------
Print_newline proc
    mov ah, 0Eh
    mov al, 0Ah
    int 10h
    mov al, 08h
Cycle:
    cmp cx, 0
    je Ended
    int 10h
    dec cx
    jmp Cycle
Ended:
    ret
endp
end Start
