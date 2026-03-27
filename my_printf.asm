
global my_printf

section .text
my_printf:

        WRITING:
        movzx r10, word [rel INDEX]
        mov al, [rdi + r10]
        cmp al, 0
        je STOP

        cmp al, '%'
        jne case_default

        movzx rbx, byte [rdi + r10 + 1]

        cmp rbx, byte 'b'
        jb case_default
        cmp rbx, byte 'x'
        jg case_default

        lea r11, [rel jmp_table]
        jmp [r11 + (rbx-'b')*8]

        jmp STOP
        

        case_b:

        case_c:
        jmp GET_CURRENT_VALUE
        GO_BACK:

        lea r11, [rel buff_to_wr]
        movzx r10, word [rel LEN]
        mov [r11 + r10], byte al
        add word [rel COUNTER], 1
        add word [rel INDEX], 2
        add word [rel LEN], 1

        jmp WRITING

        case_d:

        case_o:

        case_s:

        case_x:

        case_default:
        lea r11, [rel buff_to_wr]
        movzx r10, word [rel LEN]
        mov [r11 + r10], byte al
        add  word [rel INDEX], 1
        add  word [rel LEN], 1
        jmp WRITING



        STOP:
        mov rdi, 1
        lea rsi, [rel buff_to_wr] 
        movzx rdx, word [rel LEN]
        mov rax, 1
        syscall
        ret

        GET_CURRENT_VALUE:
        lea r11, [rel jmp_table_reg]
        movzx r10, word [rel COUNTER]
        jmp [r11 + r10*8]
        


        case_rsi:
        mov rax, rsi
        jmp GO_BACK
        case_rdx:
        mov rax, rdx
        jmp GO_BACK
        case_rcx:
        mov rax, rcx
        jmp GO_BACK
        case_r8:
        mov rax, r8
        jmp GO_BACK
        case_r9:
        mov rax, r9
        jmp GO_BACK
        case_stack:

section .data
        LEN dw 0
        INDEX dw 0
        COUNTER dw 0

        buff_to_wr:
        times (256) db 0


        jmp_table:
        dq case_b
        dq case_c
        dq case_d
        times('o'-'d' - 1) dq case_default

        dq case_o

        times('s'-'o' - 1) dq case_default

        dq case_s

        times('x'-'s' - 1) dq case_default

        dq case_x

        jmp_table_reg:
        dq case_rsi
        dq case_rdx
        dq case_rcx
        dq case_r8
        dq case_r9
        times (250) dq case_stack
section .note.GNU-stack noalloc noexec nowrite progbits
