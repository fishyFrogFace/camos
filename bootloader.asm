    BITS 16

start:
    mov ax, 07C0h          ; Set up 4K stack space after this bootloader
    add ax, 288            ; (4096 + 512) / 16 bytes per paragraph
    mov ss, ax
    mov sp, 4096

    mov ax, 07C0h          ; Set data segment to where we're loaded
    mov ds, ax


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
