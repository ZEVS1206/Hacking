.model tiny
.data

buffer_for_text db 20 dup(0)
output_phrase db 'You entered:', 0
len_output_phrase dw $ - output_phrase
len_buffer_for_text dw 0

.code
org 100h
Start:
    call Read_the_text
    call Print_text
    mov ax, 4c00h
    int 21h

;----------------------------------------------------------
;Read_the_text
;----------------------------------------------------------
Read_the_text proc
    xor cx, cx
    mov si, offset buffer_for_text
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
    cmp cx, 20
    jl InputLoop
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
    ret
endp

;----------------------------------------------------------
;Print_text
;----------------------------------------------------------
Print_text proc

    mov si, offset output_phrase
    mov ah, 0Eh
    xor cx, cx
    mov cx, len_buffer_for_text
    call Print_newline
    call Print_loop

    mov si, offset buffer_for_text
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
