    BITS 16

os_main:
    cli             ; Clear interrupts
    mov ax, 0
    mov ss, ax          ; Set stack segment and pointer
    mov sp, 0FFFFh
    sti             ; Restore interrupts

    cld             ; The default direction for string operations
                    ; will be 'up' - incrementing address in RAM

    mov ax, 2000h           ; Set all segments to match where kernel is loaded
    mov ds, ax          ; After this, we don't need to bother with
    mov es, ax          ; segments ever again, as MikeOS and its programs
    mov fs, ax          ; live entirely in 64K
    mov gs, ax

start:
    mov si, welcome        ; Put string position into SI
    call print_string      ; Call our string-printing routine
    call input_char
    
    jmp $                  ; Jump here

    welcome db 'Welcome to my new OS. You can write something here: ', 0dh, 0ah, 0
    goodbye db 0dh, 0ah, 'Goodbye. Hope you liked my OS!', 0

print_string:              ; Routine: output string in SI to screen
    mov ah, 0Eh            ; int 10h 'print char' function

.repeat:
    lodsb                  ; Get character from string
    cmp al, 0
    je .done               ; If char is zero, end of string
    int 10h                ; Otherwise, print it
    jmp .repeat

.done:
    ret

input_char:
    mov ah, 00h            ; int 16h char from keyboard
    int 16h                ; Get one char input
    cmp al, 'q'
    je .done               ; if you input 'q', i will stop taking input
    mov ah, 0Eh
    int 10h                ; Print that char
    jmp input_char

.done:
    mov si, goodbye
    call print_string
    ret

    times 510-($-$$) db 0  ; Pad remainder of boot sector with 0s
    dw 0xAA55              ; The standard PC boot signature
